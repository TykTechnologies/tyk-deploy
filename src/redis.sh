tykRedisArgs=();
redisReleaseName="tyk-redis";
checkHelmReleaseExists $redisReleaseName;

if [ REDISCLUSTER == $redis ]; then
  tykRedisArgs=(--set "redis.addrs[0]=$redisReleaseName-redis-cluster.$namespace.svc.cluster.local:6379" \
    --set "redis.pass=$PASSWORD" \
    --set "redis.enableCluster=true");
else
  tykRedisArgs=(--set "redis.addrs[0]=$redisReleaseName-master.$namespace.svc.cluster.local:6379" \
    --set "redis.pass=$PASSWORD");
fi

if $releaseExists; then
  logger $INFO "$redisReleaseName release already exists in $namespace namespace...skipping Redis install"
else
  if [ REDISCLUSTER == $redis ]; then
    set -x
    helm install $redisReleaseName bitnami/redis-cluster --version 7.6.4 \
      -n $namespace \
      --set "password=$PASSWORD" \
      "${redisSecurityContextArgs[@]}" \
      --wait
    set +x
  else
    set -x
    helm install $redisReleaseName bitnami/redis --version 17.3.2 \
      -n $namespace \
      --set "auth.password=$PASSWORD" \
      "${redisSecurityContextArgs[@]}" \
      --wait
    set +x
  fi
fi
