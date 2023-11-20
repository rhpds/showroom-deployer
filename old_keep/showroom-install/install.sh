#!/bin/bash
#

# This is for the use case of an environment deploying
# Showroom WITHOUT agsnoticd
#
# Prereqs:
# 1. oc login with cluster-admin
# 2. a name like "showroom-$GUID-$CATALOG_ITEM_NAME" to be used
# when this script creates a namespace for showroom.
#
# This script
# . Makes sure you're logged into OCP ok
# . Gets the OCP wildcard domain
# . Creates the namespace `showroom-$GUID-$CATALOG_ITEM_NAME
# . Creates the configmap `showroom-userdata` with yaml formatted user data
#    for Antora/Asciidoc template rendering
# . Runs a Job
# .. Job runs a container with Helm
# .. Helm runs the Helm Chart to do the Showroom installation in $NAMESPACE
#
#

# set -eo pipefail

GUID=$1
CATALOG_ITEM_NAME=$2
VALUES_FILENAME=$3

NAMESPACE="showroom-${GUID}-${CATALOG_ITEM_NAME}"

oc whoami
oc whoami --show-server

WILDCARD=$(oc get ingresses.config/cluster -o jsonpath={.spec.domain})
echo $WILDCARD

oc new-project $NAMESPACE || echo "NOTICE: namespace $NAMESPACE already exists."

oc create configmap showroom-userdata --from-file=$VALUES_FILENAME -n $NAMESPACE || echo "NOTICE: configmap 'showroom-userdata' already exists in namespace $NAMESPACE."

cat << EOF | oc create -f -
apiVersion: batch/v1
kind: Job
metadata:
  labels:
    job-name: my-job
  name: my-job
spec:
  backoffLimit: 6
  completionMode: NonIndexed
  completions: 1
  parallelism: 1
  suspend: false
  template:
    metadata:
      labels:
        job-name: my-job
    spec:
      containers:
        - "helm"
        - "oci://quay.io/rhpds/showroom"
        - "--repository-cache=/helmwork/cache"
        - "--debug"
        - "--set"
        - "general.guid=$GUID"
        - "--set"
        - "general.catalogItem=$CATALOG_ITEM_NAME"
        # - "--set-file content.user_data=/user-data/user-data.yml"
        # --set-file content.user_data=/user-data/user-data.yml --set general.guid=$GUID --namespace $NAMESPACE" ]
      - args:
        image: quay.io/rhpds/showroom-install:latest
        imagePullPolicy: Always
        name: my-job
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
          - name: user-data
            mountPath: /user-data/
          - name: cache
            mountPath: /helmwork/
      dnsPolicy: ClusterFirst
      restartPolicy: Never
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - name: user-data
        configMap:
          name: showroom-userdata
      - name: cache
        emptyDir: {}
EOF

exit 0
# helm install
# myshowroom
# oci://quay.io/rhpds/showroom
# --set deployer.domain=apps.shared-410.openshift.redhatworkshops.io
# --set-file content.user_data=./azure-user-data.yaml
# --set general.guid=11021
# --namespace showroom-11021-test

exit 0
cat << EOF | oc create -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: showroom-install
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: showroom-helm
        image: busybox
        # image: quay.io/rhpds/showroom-install:latest
        # command: [ "helm install myshowroom --debug oci://quay.io/rhpds/showroom --repository-cache=/helmwork/cache --set-file content.user_data=/user-data/user-data.yml --set general.guid=$GUID --namespace $NAMESPACE" ]
        # serviceAccountName: self-provisioner:openshift-config:showroom-deployer
        command: [ "ls /user-data/" ]
        volumeMounts:
          - name: user-data
            mountPath: /user-data/
          - name: cache
            mountPath: /helmwork/
      volumes:
      - name: user-data
        configMap:
          name: showroom-userdata
      - name: cache
        emptyDir: {}
  backoffLimit: 1
# helm install
# myshowroom
# oci://quay.io/rhpds/showroom
# --set deployer.domain=apps.shared-410.openshift.redhatworkshops.io
# --set-file content.user_data=./azure-user-data.yaml
# --set general.guid=11021
# --namespace showroom-11021-test

EOF
