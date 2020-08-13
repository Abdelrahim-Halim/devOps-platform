# devOps-platform

This repo is a DevOps platform repo to [Build DevOps platform on Aws](https://github.com/Abdelrahim-Halim/devOps-platform/edit/master/README.md), containing

1) Terraform configuration files to provision an EKS cluster on AWS.

 => The platform architecture 
 ![alt text](https://learn.hashicorp.com/img/terraform/eks/overview.png)

2) Implementation the needed DevOps tools to create CICD pipeline (Jenkins, SonarQube,
Nexus, etc. ...) using ansible or any other configuration management tool on the created
k8s cluster.

3) Implementation a CICD pipeline for any application using the tools and the platform
implemented from the previous steps this pipeline should be using groovy scripting
Jenkins file.

After installing the AWS CLI. Configure it to use your credentials.

```shell
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
```

This enables Terraform access to the configuration file and performs operations on your behalf with these security credentials.

After you've done this, initalize your Terraform workspace, which will download 
the provider and initialize it with the values provided in the `terraform.tfvars` file.

```shell
$ terraform init
Initializing modules...
Downloading terraform-aws-modules/eks/aws 9.0.0 for eks...
- eks in .terraform/modules/eks/terraform-aws-modules-terraform-aws-eks-908c656
- eks.node_groups in .terraform/modules/eks/terraform-aws-modules-terraform-aws-eks-908c656/modules/node_groups
Downloading terraform-aws-modules/vpc/aws 2.6.0 for vpc...
- vpc in .terraform/modules/vpc/terraform-aws-modules-terraform-aws-vpc-4b28d3d

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "template" (hashicorp/template) 2.1.2...
- Downloading plugin for provider "kubernetes" (hashicorp/kubernetes) 1.10.0...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.52.0...
- Downloading plugin for provider "random" (hashicorp/random) 2.2.1...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...

Terraform has been successfully initialized!
```

Then, provision your EKS cluster by running `terraform apply`. This will 
take approximately 10 minutes.

```shell
$ terraform apply

# Output truncated...

Plan: 51 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

# Output truncated...

Apply complete! Resources: 51 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = https://xxxxxxxxxxxxxxxx.gr7.us-east-2.eks.amazonaws.com
cluster_security_group_id = sg-xxxxxxxxxxxx
kubectl_config = apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: https://xxxxxxxxxxxxxxxx.gr7.us-east-2.eks.amazonaws.com
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01ETXdPVEU0TXpVeU1sb1hEVE13TURNd056RTRNelV5TWxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTThkClZaN1lmbjZmWm41MEgwL0d1Qi9lRmVud2dydXQxQlJWd29nL1JXdFpNdkZaeStES0FlaG5lYnR5eHJ2VVZWMXkKTXVxelBiMzgwR3Vla3BTVnNTcDJVR0ptZ2N5UVBWVi9VYVZDQUpDaDZNYmIvL3U1bWFMUmVOZTBnb3VuMWlLbgpoalJBYlBJM2JvLzFPaGFuSXV1ejF4bmpDYVBvWlE1U2N5MklwNnlGZTlNbHZYQmJ6VGpESzdtK2VST2VpZUJWCjJQMGd0QXJ3alV1N2MrSmp6OVdvcGxCcTlHZ1RuNkRqT1laRHVHSHFRNEpDUnRsRjZBQXpTUVZ0cy9aRXBnMncKb2NHakd5ZE9pSmpMb1NsYU9weDIrMTNMbHcxMDAvNmY4Q0F2ajRIbFZUZDBQOW5rN1UyK04xNSt5VjRpNjFoQgp3bHl4SXFUWEhDR0JvYmRNNE5VQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFIbEI3bGVMTnJYRXZnNksvNUdtR2s5Tlh4SUkKRDd0Y1dkTklBdnFka1hWK3ltVkxpTXV2ZGpQVjVKV3pBbEozTWJqYjhjcmlQWWxnVk1JNFJwc0N0aGJnajMzMwpVWTNESnNxSmZPUUZkUnkvUTlBbHRTQlBqQldwbEtaZGc2dklxS0R0eHB5bHovOE1BZ1RldjJ6Zm9SdzE4ZnhCCkI2QnNUSktxVGZCNCtyZytVcS9ULzBVS1VXS0R5K2gyUFVPTEY2dFVZSXhXM2RncWh0YWV3MGJnQmZyV3ZvSW8KYitSOVFDTk42UHRQNEFFQSsyQnJYYzhFTmd1M2EvNG9rN3lPMjZhTGJLdC9sbUNoNWVBOEdBRGJycHlWb3ZjVgpuTGdyb0FvRnVRMCtzYjNCTThUcEtxK0YwZ2dwSFptL3ZFNjh5NUk1VFlmUUdHeEZ6VEVyOHR5NHk1az0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  name: eks_platform-eks-TNajBRIF

contexts:
- context:
    cluster: eks_platform-eks-TNajBRIF
    user: eks_platform-eks-TNajBRIF
  name: eks_platform-eks-TNajBRIF

current-context: eks_platform-eks-TNajBRIF

users:
- name: eks_platform-eks-TNajBRIF
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "platform-eks-TNajBRIF"



region = us-east-2
```

## Configure kubectl

To configure kubetcl, you need both [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

The following command will get the access credentials for your cluster and automatically
configure `kubectl`.

```shell
$ aws eks --region us-east-2 update-kubeconfig --name platform-eks-sR8eLIil
```
You can view these outputs again by running:

```shell
$ terraform output
```

Use the AWS CLI update-kubeconfig command to create or update your kubeconfig for your cluster.

```shell
$ aws eks --region region-code update-kubeconfig --name cluster_name
```
Get the region-code and cluster_name from the output of the previous step.

Then install Ansible and openshift using pip3

```shell
$ pip3 install openshift
$ pip3 install ansible --user
```
Run the Deployments Playbook to deploy ( Jenkins, Nexus and Sonarqube) on the created eks cluster

```shell
$ ansible-playbook deploymentsPlaybook.yaml

[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [localhost] ***************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [deploy jenkins] **********************************************************
ok: [localhost]

TASK [deploy nexus] ************************************************************
ok: [localhost]

TASK [deploy sonarqube] ********************************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

```

Configure Jenkins to create CI/CD pipline

```shell
$ kubectl get svc --namespace devops

NAME        TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
jenkins     LoadBalancer   172.20.253.238   a25af165b92664db1a3a7455248e2dd6-951940550.us-east-2.elb.amazonaws.com   80:32544/TCP   4m32s
nexus       LoadBalancer   172.20.140.113   a61ac66d8c7064a50906972e0c802668-260146710.us-east-2.elb.amazonaws.com   80:30362/TCP   3m26s
sonarqube   LoadBalancer   172.20.95.231    a2ac338b8d5d7499caed546e0d35f28c-345267086.us-east-2.elb.amazonaws.com   80:30305/TCP   2m21s

```
Get InitialAdminPassword from the running jenkins pod

```shell
$ kubectl get po -n devops
$ kubectl exec jenkins-deployment-759b989cf4-cjcl6 -n devops cat /var/jenkins_home/secrets/initialAdminPassword
```

