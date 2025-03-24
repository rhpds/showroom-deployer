#!/bin/bash

if [ -z "$GIT_REPO_URL" ]; then
  echo "GIT_REPO_URL is not set. Exiting."
  exit 1
fi

if [ -z "$HELM_CHART" ]; then
  echo "HELM_CHART not defined.  Falling back to HELM_CHART=showroom"
  HELM_CHART="showroom"
fi
# Setup working directory for cloning and rendering

# WORKDIR=/home/antora/repo
WORKDIR=/showroom/repo
#mkdir -p $WORKDIR

echo
echo "git clone the $GIT_REPO_URL into $WORKDIR"
git clone $GIT_REPO_URL $WORKDIR || cd $WORKDIR && git pull
cd $WORKDIR

### Zero Touch UI integration
if [ "$ZT_UI_BUNDLE" = true ]; then
  ZT_BUNDLE_NAME="zt_bundle.zip"
  ZT_BUNDLE_DIR="$WORKDIR/www/"

  echo
  echo "download $ZT_BUNDLE into $WORKDIR"
  curl -L -o $ZT_BUNDLE_DIR/$ZT_BUNDLE_NAME $ZT_BUNDLE

  echo
  echo "unzip $ZT_BUNDLE into $ZT_BUNDLE_DIR"
  unzip $ZT_BUNDLE_DIR/$ZT_BUNDLE_NAME -d $ZT_BUNDLE_DIR

  echo
  echo "remove zip after extraction"
  rm $ZT_BUNDLE_DIR/$ZT_BUNDLE_NAME

  echo
  echo "Symlink zero-touch-config.yml to www/zero-touch-config.yml"
  ln -sfn $ZT_BUNDLE_DIR/zero-touch-config.yml $ZT_BUNDLE_DIR/www/zero-touch-config.yml
fi

# Extract the name of the repository to use as the working directory
# REPO_NAME=$(basename $GIT_REPO .git)

# run the helm template to create the showroom application

oc login --cacert-file $CA_CERT_FILE \
  --api_url $API_URL \
  --token $TOKEN

helm template ./$HELM_CHART \
  --set deployer.domain=$WILDCARD \
  --set general.guid=$GUID \
  --set-file content.user_data=/user-data/user-data.yml \
  --debug | oc create -f -

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
