---
title: "GCP"
metaTitle: "Creating new clusters on Spectro Cloud"
metaDescription: "The methods of creating clusters for a speedy deployment on any CSP"
hideToC: false
fullWidth: false
---

import Tabs from 'shared/components/ui/Tabs';
import WarningBox from 'shared/components/WarningBox';
import InfoBox from 'shared/components/InfoBox';
import PointsOfInterest from 'shared/components/common/PointOfInterest';

# Overview

The following are some highlights of Google Cloud Platform (GCP) clusters provisioned by Palette:

1. On the GCP cluster, control plane nodes and worker nodes are placed within a single private subnet spanning across different availability zones within a region.


2. A new VPC Network is created with all the network infrastructure components like Cloud NAT and a Cloud Router. In addition, firewall rules are created to protect all the API endpoints.


3. API server endpoint is exposed through a Global Load Balancer. Applications running with the cluster use a Regional Load Balancer to expose the load-balancer services.


![gcp_cluster_architecture.png](/gcp_cluster_architecture.png)

# Prerequisites

The following are required for deploying a workload cluster on GCP:

1. You must have an active GCP service account with all the permissions listed below in the **GCP Cloud Account Permissions** section.


2. Register your GCP cloud account in Palette as described in the **Creating a GCP Cloud account** section below.


3. You should have an Infrastructure cluster profile created in Palette for GCP.


4. Palette creates compute, network, and storage resources on GCP during the provisioning of Kubernetes clusters. Therefore, Sufficient capacity in the desired GCP region should exist for the creation of the cluster.

# GCP Cloud Account Permissions

**Last Update**: December 13, 2020

Create a service account in GCP with the required permissions and register it with Palette to create a GCP cloud account in Palette. To create a service account, you should have one of the following Identity and Access Management (IAM) roles:
`roles/iam.serviceAccountAdmin` or `roles/editor`. For detailed instructions on creating a service account refers to [Creating and managing service accounts](https://cloud.google.com/iam/docs/creating-managing-service-accounts).

You can create a service account either using existing standard roles or create a new role with custom permissions.


<Tabs>

<Tabs.TabPane tab="Existing Standard Roles" key="Existing Standard Roles">

## Create Service Account with existing standard roles


The service account should have the following roles:

1. Compute Admin
2. Service Account User
3. Storage Object Viewer


</Tabs.TabPane>

<Tabs.TabPane tab="New Role with Custom Permissions" key="new role with custom permissions">

## Create Service Account with a new role with custom permissions


The custom new role should include these minimum permissions:

```
compute.backendServices.create
compute.backendServices.delete
compute.backendServices.get
compute.backendServices.list
compute.backendServices.update
compute.backendServices.use
compute.disks.create
compute.firewalls.create
compute.firewalls.delete
compute.firewalls.get
compute.firewalls.list
compute.globalAddresses.create
compute.globalAddresses.delete
compute.globalAddresses.get
compute.globalAddresses.list
compute.globalAddresses.use
compute.globalForwardingRules.create
compute.globalForwardingRules.delete
compute.globalForwardingRules.get
compute.globalForwardingRules.list
compute.healthChecks.create
compute.healthChecks.delete
compute.healthChecks.get
compute.healthChecks.list
compute.healthChecks.useReadOnly
compute.instanceGroups.create
compute.instanceGroups.delete
compute.instanceGroups.get
compute.instanceGroups.list
compute.instanceGroups.update
compute.instanceGroups.use
compute.instances.create
compute.instances.delete
compute.instances.get
compute.instances.list
compute.instances.setLabels
compute.instances.setMetadata
compute.instances.setServiceAccount
compute.instances.setTags
compute.instances.use
compute.networks.create
compute.networks.delete
compute.networks.get
compute.networks.list
compute.networks.updatePolicy
compute.regions.get
compute.regions.list
compute.routers.create
compute.routers.delete
compute.routers.get
compute.routes.delete
compute.routes.get
compute.routes.list
compute.subnetworks.create
compute.subnetworks.delete
compute.subnetworks.get
compute.subnetworks.list
compute.subnetworks.use
compute.targetTcpProxies.create
compute.targetTcpProxies.delete
compute.targetTcpProxies.get
compute.targetTcpProxies.use
compute.zones.get
compute.zones.list
iam.serviceAccounts.actAs
iam.serviceAccounts.get
iam.serviceAccounts.list
resourcemanager.projects.get
resourcemanager.projects.list
storage.objects.get
storage.objects.list
```

</Tabs.TabPane>

</Tabs>




Retrieve the JSON credential file for your service account. For detailed instructions on creating your service account keys refer to [Creating and managing service account keys](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

# Creating a GCP Cloud Account

`video: title: "gcp-cluster-creation": cloud-accounts/google.mp4`

1. To create a GCP cloud account, provide a name for the account and enter the JSON credentials for your service account either by pasting into the space provided or uploading from your JSON credential file.


2. Then, Validate and Save your account.

# Deploying a GCP Cluster

`video: title: "gcp-cluster-creation": ./cluster-creation-videos/google-cloud.mp4`

Performed the steps below to provision a new GCP cluster:

1. Provide basic cluster information like name, description, and tags. Tags on a cluster are propagated to the VMs deployed on the cloud/data center environments.


2. Select a cluster profile created for GCP cloud. The profile definition will be used as the cluster construction template.


3. Review and override pack parameters as desired. By default, parameters for all packs are set with values defined in the cluster profile.


4. Provide the GCP Cloud account and placement information.

  |**Parameter**| **Description**|
  |-------------|---------------|
  | **Cloud Account** | Select the desired cloud account. GCP cloud accounts with GCP credentials need to be pre-configured in project settings.
  | **Project** | The project to which the cluster belongs.
  | **Region** | Choose the desired GCP region where you would like the clusters to be provisioned.
  | **SSH Key Pair Name** | Choose the desired SSH Key|pair. It is the Public key to configure remote SSH access to the nodes.
  | **Static Placement** | By default, Palette uses dynamic placement wherein a new VPC with a public and private subnet is created to place cluster resources for every cluster. These resources are fully managed by Palette and deleted when the corresponding cluster is deleted. Turn on the **Static Placement** option if it is desired to place resources into preexisting VPCs and subnets. If the user is making the selection of **Static Placement** of resources, the following placement information need to be provided:
    ||- Virtual Network
    ||- Control plane Subnet
    ||- Worker Network

5. Make the choice of updating the worker pool in parallel.


6. Configure the master and worker node pools. To learn more about the configuration options, review the [Node Pool](/clusters/cluster-management/node-pool) documentation page. Click on **Next** when you are done with node pool configurations.


8. The settings page is where you can configure patching schedule, security scans, backup settings, setup role based access control (RBAC), and enable [Palette Virtual Clusters](/devx/palette-virtual-clusters). Review the settings and make changes if needed. Click on **Validate**.


9. Review the settings summary and click on **Finish Configuration** to deploy the cluster. Be aware that provisioning IaaS clusters can take several minutes.


The cluster details page of the cluster contains the status and details of the deployment. Use this page to track the deployment progress.

# Deleting a GCP Cluster

The deletion of a GCP cluster results in the removal of all Virtual machines and associated storage disks created for the cluster. The following tasks need to be performed to delete a GCP cluster:


1. Select the cluster to be deleted from the **Cluster** **View** page and navigate to the **Cluster Overview** page.


2. Invoke a delete action available on the page: **Cluster** > **Settings** > **Cluster** **Settings** > **Delete** **Cluster**.


3. Click **Confirm** to delete.


The Cluster Status is updated to **Deleting** while cluster resources are being deleted. Provisioning status is updated with the ongoing progress of the delete operation. Once all resources are successfully deleted, the cluster status changes to **Deleted** and is removed from the list of clusters.

# Force Delete a Cluster

A cluster stuck in the **Deletion** state can be force deleted by the user through the User Interface. The user can go for a force deletion of the cluster, only if it is stuck in a deletion state for a minimum of **15 minutes**. Palette enables cluster force delete from the Tenant Admin and Project Admin scope.

## To force delete a cluster:

1. Log in to the Palette Management Console.


2. Navigate to the **Cluster Details** page of the cluster stuck in deletion.

      - If the deletion is stuck for more than 15 minutes, click the **Force Delete Cluster** button from the **Settings** dropdown.

      - If the **Force Delete Cluster** button is not enabled, wait for 15 minutes. The **Settings** dropdown will give the estimated time for the auto-enabling of the **Force Delete** button.



<WarningBox>

A force delete can result in resources Palette provisioned to be missed in the removal process. Verify there are no remaining Palette provisioned resources such as:

- Virtual Private Cloud (VPC) Network
- Static External IP Address
- Network Interfaces 
- Cloud NAT
- Cloud Load Balancing
- Persistent Disks
- Cloud Router

Failure in removing provisioned resources can result in unexpected costs. Be sure to carefully review your Google Cloud Platform resources to prevent any unintended charges.

</WarningBox>
