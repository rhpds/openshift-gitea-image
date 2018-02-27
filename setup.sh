echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: gitea-data
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 4Gi" | oc create -f -

oc new-app docker.io/wkulhanek/gitea:latest -lapp=gitea --name=gitea
oc set volume dc/gitea --add  --overwrite --name=gitea-volume-1 --mount-path=/home/gitea/data --type persistentVolumeClaim --claim-name=gitea-data
oc expose svc gitea
