tykRedisArgs=();
redisReleaseName="tyk-redis";
checkHelmReleaseExists $redisReleaseName;

if [[ $REDISCLUSTER == $redis ]]; then
  tykRedisArgs=(--set "redis.addrs[0]=$redisReleaseName-redis-cluster.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD" \
    --set "redis.enableCluster=true");
elif [[ $REDISSENTINEL == $redis ]]; then
  tykRedisArgs=(--set "redis.addrs[0]=$redisReleaseName.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD");
else
  tykRedisArgs=(--set "redis.addrs[0]=$redisReleaseName-master.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD");
fi

if $releaseExists; then
  logger $INFO "$redisReleaseName release already exists in $namespace namespace...skipping Redis install";
else
  logger $INFO "installing $redisReleaseName in namespace $namespace";
  if [[ $REDISCLUSTER == $redis ]]; then
    setVerbose;
    helm install $redisReleaseName bitnami/redis-cluster --version 7.6.4 \
      -n $namespace \
      --set "password=$PASSWORD" \
      "${redisSecurityContextArgs[@]}" \
      --atomic \
      --wait > /dev/null;
    unsetVerbose;
  elif [[ $REDISSENTINEL == $redis ]]; then
    setVerbose;
    helm install $redisReleaseName bitnami/redis --version 17.3.2 \
      -n $namespace \
      --set "auth.password=$PASSWORD" \
      --set "sentinel.enabled=true" \
      "${redisSecurityContextArgs[@]}" \
      --atomic \
      --wait > /dev/null;
    unsetVerbose;
  else
    setVerbose;
    helm install $redisReleaseName bitnami/redis --version 17.3.2 \
      -n $namespace \
      --set "auth.password=$PASSWORD" \
      "${redisSecurityContextArgs[@]}" \
      --atomic \
      --wait > /dev/null;
    unsetVerbose;
  fi
  logger $INFO "installed $redisReleaseName in namespace $namespace";
fi
