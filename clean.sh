oc delete all -lapp=gitea
oc delete cm gitea
oc delete pvc gitea-data
oc delete all -lapp=postgresql_gitea
oc delete pvc postgresql
oc delete secret postgresql
