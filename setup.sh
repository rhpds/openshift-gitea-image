oc new-app postgresql-persistent --param POSTGRESQL_DATABASE=gitea --param POSTGRESQL_USER=gitea --param POSTGRESQL_PASSWORD=gitea --param VOLUME_CAPACITY=4Gi -lapp=postgresql_gitea

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
oc set volume dc/gitea --add  --overwrite --name=gitea-volume-1 --mount-path=/gitea-repositories --type persistentVolumeClaim --claim-name=gitea-data
oc expose svc gitea
