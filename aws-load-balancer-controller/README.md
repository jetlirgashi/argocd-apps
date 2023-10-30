# AWS Load Balancer Controller

https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.6/deploy/installation/

### Deployment 

```
helm repo add eks https://aws.github.io/eks-charts

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=eks-cluster --set serviceAccount.create=true --set serviceAccount.name=aws-load-balancer-controller


```


1. Create policy

        aws iam create-policy \
        --policy-name AWSLoadBalancerControllerIAMPolicy \
        --policy-document file://iam_policy.json
        
2. 
        aws eks describe-cluster --name eks-cluster --query "cluster.identity.oidc.issuer" --output text

3. 
        aws iam create-role \
        --role-name AmazonEKSLoadBalancerControllerRole \
        --assume-role-policy-document file://"load-balancer-role-trust-policy.json"

4. 
        aws iam attach-role-policy \
        --policy-arn arn:aws:iam::313422618945:policy/AWSLoadBalancerControllerIAMPolicy \
        --role-name AmazonEKSLoadBalancerControllerRole


5. 
        helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
            -n kube-system \
            --set clusterName=eks-cluster \
            --set serviceAccount.create=false \
            --set serviceAccount.name=aws-load-balancer-controller 