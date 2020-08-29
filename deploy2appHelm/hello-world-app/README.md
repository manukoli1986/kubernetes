

# devops-challange
## Deploying K8s Hello World Proxy

This repository contains code to deploy hello world application on kubernetes with provisioning tool HELM.

Pre-requiste setup on workstation:
1. Install Helm tool,  Kubectl and  minikube 
2. 

Let's start Minikube on workstation

```
$ minikube.exe start
* minikube v1.2.0 on windows (amd64)
* Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
* Restarting existing virtualbox VM for "minikube" ...
* Waiting for SSH access ...
* Configuring environment for Kubernetes v1.15.0 on Docker 18.09.6
* Relaunching Kubernetes v1.15.0 using kubeadm ...
* Verifying: apiserver proxy etcd scheduler controller dns
* Done! kubectl is now configured to use "minikube"
```

To check any existing pod
```
$sudo kubectl.exe get all

```

Now go to directory where code is and run below command
```
$ cd deploy2appHelm/

$ helm.exe install --name hello-world .
NAME:   hello-world
LAST DEPLOYED: Sat Aug 29 17:14:54 2020
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME            DATA  AGE
nginxconfigmap  1     1s

==> v1/Deployment
NAME         READY  UP-TO-DATE  AVAILABLE  AGE
hello-world  0/1    1           0          1s
nginx        0/1    1           0          1s

==> v1/Pod(related)
NAME                          READY  STATUS             RESTARTS  AGE
hello-world-5dd6954bbc-ksvgz  0/1    ContainerCreating  0         1s
nginx-ffb747f8d-fdm8p         0/1    ContainerCreating  0         1s

==> v1/Service
NAME         TYPE          CLUSTER-IP      EXTERNAL-IP  PORT(S)       AGE
hello-world  ClusterIP     10.111.138.126  <none>       8080/TCP      1s
nginx        LoadBalancer  10.96.128.3     <pending>    80:30300/TCP  1s

```
Verify now that app is deployed 
```
$ kubectl.exe get all
NAME                               READY   STATUS    RESTARTS   AGE
pod/hello-world-5dd6954bbc-85qrf   1/1     Running   0          12s
pod/nginx-ffb747f8d-rw7cg          1/1     Running   0          12s


NAME                  TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/hello-world   ClusterIP      10.110.85.140    <none>        8080/TCP       12s
service/kubernetes    ClusterIP      10.96.0.1        <none>        443/TCP        325d
service/nginx         LoadBalancer   10.104.139.134   <pending>     80:30300/TCP   12s


NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hello-world   1/1     1            1           12s
deployment.apps/nginx         1/1     1            1           12s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/hello-world-5dd6954bbc   1         1         1       12s
replicaset.apps/nginx-ffb747f8d          1         1         1       12s
```

Your hello world application is deployed and you can access page by getting below IP
```
$minikube.exe service nginx
* Opening kubernetes service default/nginx in default browser...

or Get IP  and access app with 30300 port on your work station.
$minikube.exe ip
```

#Code:

I have used Helm chart with template where defination files are mentioned and values will be imported from values.yaml. You can updated values according to your requirement. Using default.conf for nginx where our reverse proxy is setup and and helm will create configmap and bind as volume attach in POD. I could have used updated docker images of nginx as well but used native tool configmap of kubernetes. 