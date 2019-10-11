#-----------
# Variables
#-----------
PROJECT_ID=rrodriguezgil-helm-jenkins
PROJECT_ZONE=europe-west2
CLUSTER_NAME=helm-jenkins-cluster
CLUSTER_NUM_NODES=2
HELM_RELEASE_NAME=my-jenkins
HELM_CHART=stable/jenkins

#-----------
# Commands
#-----------
## Creating GCP project and configuring it
### Create project
gcloud projects create $PROJECT_ID
### Set project
gcloud config set project $PROJECT_ID
### Set zone
gcloud config set compute/zone $PROJECT_ZONE

## Creating cluster
### Create GKE cluster
gcloud container clusters create $CLUSTER_NAME --num-nodes=$CLUSTER_NUM_NODES

## Helm
### Apply RBAC
kubectl create -f conf/rbac-config.yaml
### Init Helm and Tiller
helm init --service-account tiller --history-max 200

## Jenkins
### Install Jenkins
helm install --name $HELM_RELEASE_NAME $HELM_CHART
