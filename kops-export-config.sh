# This is something that I always forget and had a surprisingly hard time finding (or better yet, understanding).  Here's the
# scenario: a colleague creates a new kubernetes cluster, named" cluster-foo.example.com".  You want to look at it (for 
# troubleshooting, updating the deployment, whatever).  To get your kubectl installation to "see" the new cluster, take the 
# following steps:

# ASSUMPTION:  You have pointed kops to some location where the cluster configurations are stored 
# (I have this in my ~/.bash_profile):
export KOPS_STATE_STORE=s3://example-state-store

# Use kops to get the list of clusters
$ kops get clusters
NAME                         CLOUD   ZONES
cluster-alpha.example.com    aws     us-west-2a
cluster-bravo.example.com    aws     us-west-2a
cluster-foo.example.com      aws     us-west-2a

# Export the configuration of the cluster you care about; this will update your ~/.kube/config file, so kubectl knows about it:
$ kops export kubecfg cluster-foo.example.com
Kops has set your kubectl context to awsstaging.sbtds.org

# Now you should see the cluster-foo.example.com in your list of kubectl contexts:
$ kubectl config get-contexts
CURRENT   NAME                           CLUSTER                      AUTHINFO                   NAMESPACE
          cluster-alpha.example.com      cluster-alpha.example.com    cluster-alpha.example.com
          cluster-bravo.example.com      cluster-bravo.example.com    cluster-bravo.example.com
*         cluster-foo.example.com        cluster-foo.example.com      cluster-foo.example.com
