oc exec $(oc get pod | grep "^gitea" | awk '{print $1}') -- cat /home/gitea/conf/app.ini >app.ini
oc create configmap gitea --from-file=app.ini
oc set volume dc/gitea --add --overwrite --name=config-volume -m /home/gitea/conf/ -t configmap --configmap-name=gitea
