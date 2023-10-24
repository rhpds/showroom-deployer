# SHOWROOM

Welcome to the showroom OpenShift application.

## Install

A basic installation will vary depending if you have a docs site running or you want to build and serve
the documentation from the source code.

### Namespace name generation

Typically, user interface namespace names have been just `bookbag-GUID` or `showroom-GUID`.
This makes management and cleanup a bit difficult.

.The namespace is now a combination as follows:
* namespace: (default) showroom
* guid: (default) nnnn
* catalogItem: (default) test

Which produces, for example:

Namespace:

`showroom-nnn-test`

And a route for the `showroom-proxy` pod:

`showroom-proxy-showroom-nnnn-test.apps.shared-410.openshift.redhatworkshops.io/`

### Bring your own docs

In this scenario you have the docs served externally with a public URL:

```
helm template ./helm \
--set deployer.domain=apps.cluster-guid.sandbox.opentlc.com \
--set documentation.url=https://my-documentation.external.com | oc apply -f -
```

### Build docs from source

In this scenario you have a Git repo URL with an Antora website and want OpenShift to build and deploy
the documentation from the source code.

Now you're ready to install showroom by just providing the documentation source repository:

```
helm template ./helm \
--set deployer.domain=apps.cluster-guid.sandbox.opentlc.com \
--set documentation.repoUrl=https://github.com/tonykay/showroom-poc-2023-06 | oc apply -f -
```

## ArgoCD

It is possible to deploy the helm chart with ArgoCD. This repo provides an ArgoCD/Application for
your convenience.

```
oc create -f ./argocd/application.yaml
```

## Multi-user installation

The chart can be installed multiple times in one namespace per user. You control this in helm values.yaml.

An easy way to setup and manage a multi-user deployment is via the ArgoCD/ApplicationSet.

```
oc create -f ./argocd/applicationset.yaml
```

## TODO

. Test applicationSet
. DONE add CatalogItem name to namespace: showroom-{{ catalogitemname }}-{{ guid }}
. for Shared OCP cluster, run applicationset from GitHub on controller or logged into the bastion (or not)
. for dedicated OCP cluster, just install helm chart (?)
. ssh to bastion automatically if set
