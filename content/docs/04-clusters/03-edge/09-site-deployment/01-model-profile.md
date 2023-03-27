---
title: "Model Edge Native Cluster Profile"
metaTitle: "Instructions for creating an Edge Native Cluster Profile"
metaDescription: "Instructions for creating an Edge Native Cluster Profile"
hideToC: false
fullWidth: false
---

import Tabs from 'shared/components/ui/Tabs';
import WarningBox from 'shared/components/WarningBox';
import InfoBox from 'shared/components/InfoBox';
import PointsOfInterest from 'shared/components/common/PointOfInterest';

# Overview

[Cluster profiles](/cluster-profiles) contain the desired specifications the Kubernetes cluster  Edge host makes up. The cluster profile defines the following components.

<br />

- Kubernetes flavor and version

- Operating system (OS)

- Container network interface (CNI)

- Container storage interface (CSI)  

You define these components in an Edge Native Infrastructure profile. As with any other environment in Palette, you can define additional add-on cluster profiles. You can use add-on profiles to define integrations or applications that must be included when Palette deploys the cluster.

<br/>

# Profile Scope

You can create a profile in the tenant scope or the project scope. The choice depends on how you would like to organize your Edge deployments. If all your Edge deployments are organized within a single project, you can define the cluster profile in the project scope. However, if you would like to use projects to group related sites or have one site per project, then define the cluster profile in the tenant scope. You can share cluster profiles that you define in the tenant scope among all the projects in your tenant.

# Create Edge Native Cluster Profile

Use the following steps to create a cluster profile for Edge hosts.

# Prerequisites

No prerequisites.

# Enablement

1. Log in to [Palette](https://console.spectrocloud.com).

2. Choose the desired scope, project or **Tenant Admin**.

![Select the scope by using the drop-down Menu.  Either project or tenant admin are the displayed values in the screenshot.](/clusters_site_deployment_mode-profile_scope-selector.png)

<br />

3. Navigate to the left **Main Menu** and select **Profiles**.

4. Click the **Add new Profile** button.

5. Provide the profile with a name, description, version, and tags. Select **Full** for the profile type. Click on **Next**.

6. Select **Edge Native** as the cloud type and click on **Next**.

7. In the profile layers screen, for the OS layer, choose the desired OS type and  OS version. Click on **Next layer**.

<InfoBox>

Choose the *Bring Your Own OS* (BYOOS) option can be chosen if you are building your own enterprise edge artifacts. Provide the location of your provider image as the system provider uri.  You can also provide additional cloud-init configurations in the OS pack's YAML values for setting up Edge host users, installing additional OS packages, installing certificates and more. Refer to the [Cloud-Init Stages](/clusters/edge/edge-configuration/cloud-init) resource to learn more about cloud-init stages.

</InfoBox>

<InfoBox>
If you choose BYOOS as your OS layer, K8s flavor you chosse for the K8s layer should match the flavor used for your enterprise provider image. If these are different, deployments will fail in the final step during configuration of Kubernetes. Also, in this scenario, the version specified for the K8s layer is not propagated to the edge site. The version from your enterprise provider image take precendence.
</InfoBox>

8. Choose the desired Kubernetes distribution and version. Click on **Next layer**.

9. Choose the desired CNI type and version. Click on **Next layer**.

10. Review and save your cluster profile.

You now have a cluster profile you can use for deploying Edge hosts.

Consider creating additional profiles with out-of-the-box packs for monitoring, security, authentication, or other capabilities. If you need remote access to the cluster, consider adding the [Spectro Proxy](/integrations/frp) pack to one of the add-on profiles.

Optionally, add additional Helm or OCI registries and include applications hosted in those registries in add-on profiles. Check out the guide for adding a [Helm](/registries-and-packs/helm-charts) or [OCI](/registries-and-packs/oci-registry) registry to learn more.

# Validation

Verify you created a cluster profile for Edge hosts by using the following steps.

1. Log in to [Palette](https://console.spectrocloud.com).

2. Choose the desired scope, project or **Tenant Admin**.

3. Navigate to the left **Main Menu** and select **Profiles**.

4. Use the **Cloud Types drop-down Menu** and select **Edge Native**.

5. Your newly created cluster profile is displayed along with other cluster profiles of the same type.

# Next Steps

Your next step in the deployment lifecycle is to prepare the Edge Installer user data. Use the [Prepare User Data](/clusters/edge/site-deployment/prepare-edge-configuration) guide to continue.

<br />