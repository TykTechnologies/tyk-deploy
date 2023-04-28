if [[ $POSTGRES == "$storage" ]]; then
  tykDBName="storage";
  tykDBPort=5432;
  source src/main/storage/pgsql.sh $tykDBName $tykDBPort;
  logger "$DEBUG" "storage/main.sh: setting tyk related postgres configuration";
  args=(--set "backend=postgres" \
    --set "postgres.host=tyk-$tykDBName-postgres-postgresql.$namespace.svc" \
    --set "postgres.port=$tykDBPort" \
    --set "postgres.password=$PASSWORD" \
    --set "postgres.database=$tykDBName" \
    --set "postgres.sslmode=disable");
else
  source src/main/storage/mongo.sh;
  logger "$DEBUG" "storage/main.sh: setting tyk related mongo configuration";
  args=(--set "mongo.mongoURL=mongodb://root:$PASSWORD@tyk-mongo-mongodb.$namespace.svc:27017/tyk_analytics?authSource=admin");
fi

addDeploymentArgs "${args[@]}";
