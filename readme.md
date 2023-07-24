## in wsl

- [x] list source code files `ls .`
- [x] add x right to files `ls . | grep *.sh$ `

- [x] speed up snap `sudo snap install snap-store snap-store-proxy snap-store-proxy-client`
- [x] install microk8s `sudo snap install microk8s --classic`
- [x] microk8s start k8s `microk8s start`
- [x] microk8s get pods `microk8s.kubectl get pods -A`
- [x] d2n `sudo ./microk8s.d2n.sh`
- [x] d2c `sudo ./microk8s.d2c.sh mirrorgooglecontainers k8s.gcr.io pause:3.1`

```bash
# cd /mnt/d/code/shell/pullk8s

# list source code files

# zero:task:s:speed-up-snap
sudo snap install snap-store snap-store-proxy snap-store-proxy-client
# zero:task:e:speed-up-snap

# install microk8s
# sudo snap install microk8s --classic 
# sudo snap install microk8s --classic --channel=1.27


# enable seamless usage of commands which require admin privilege
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

su - $USER

# get k8s latest stable version
# microk8s version

# microk8s start k8s
# sudo microk8s start

# microk8s get pods
# sudo microk8s.kubectl get pods -A
# microk8s status --wait-ready

# microk8s get status
# sudo microk8s.status

# zero:task:s:fix-start-in-china
# dli
# ./admk8s.dli.sh 1.27.2

# d2n 
# sudo ./microk8s.d2n.sh

# d2c
# ./microk8s.d2c.sh -h
# sudo ./microk8s.d2c.sh mirrorgooglecontainers k8s.gcr.io pause:3.1
# sudo ./microk8s.d2c.sh registry.aliyuncs.com/google_containers registry.k8s.io pause:3.7 # microk8s@1.27.2 

# microk8s restart 
# microk8s stop && microk8s start
# zero:task:e:fix-start-in-china



# microk8s stop k8s
# sudo microk8s stop

# remove microk8s
# sudo snap remove microk8s

# zero:task:s:fix-capital-hostname
# WARNING:  This machine's hostname contains capital letters and/or underscores.
# sudo hostname devink8s
# host
# oldname=DESKTOP-H1IKCEF ; sed -i "s/$oldname/devink8s/g" /etc/hosts
# or:
# echo --hostname-override=devink8s >> /var/snap/microk8s/current/args/kubelet
# zero:task:e:fix-capital-hostname


# docker image prune -a

# microk8s enable dns
# microk8s enable dashboard

# get dashboard token

# token=$(microk8s.kubectl -n kube-system get secret | grep dashboard-token | cut -d " " -f1)
# microk8s.kubectl -n kube-system describe secret $token

# kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

# get dashboard cluster ip
microk8s.kubectl get svc -n kube-system | grep kubernetes-dashboard
# curl https://10.152.183.131:443

microk8s.kubectl port-forward -n kube-system --address 0.0.0.0 service/kubernetes-dashboard 5000:443
```

- [x] microk8s 1.27.2


## scripts

`./admk8s.dli.sh`
```bash
./admk8s.dli.sh version
```