VANILLA="vanilla";
OPENSHIFT="openshift";
MONGO="mongo";
POSTGRES="postgres";
REDIS="redis";
REDISCLUSTER="redis-cluster";
REDISSENTINEL="redis-sentinel";
DEFAULTNAMESPACE="tyk";
LOGLEVEL=$INFO;

# Default values
namespace=$DEFAULTNAMESPACE;
flavor=$VANILLA;
redis=$REDIS;
storage=$MONGO;
deployments=$();

# Translate long argument flags into short ones.
for arg in "$@"; do
  shift
  case "$arg" in
    '--help')        set -- "$@" '-h'   ;;
    '--verbose')     set -- "$@" '-v'   ;;
    '--namespace')   set -- "$@" '-n'   ;;
    '--flavor')      set -- "$@" '-f'   ;;
    '--redis')       set -- "$@" '-r'   ;;
    '--storage')     set -- "$@" '-s'   ;;
    '--deployments') set -- "$@" '-d'   ;;
    *)               set -- "$@" "$arg" ;;
  esac
done

# Parse short options
OPTIND=1
while getopts "hvn:f:r:s:d:" opt
do
  case "$opt" in
    'h') usage; exit 0     ;;
    'v') LOGLEVEL=$DEBUG   ;;
    'n') namespace=$OPTARG ;;
    'f') flavor=$OPTARG    ;;
    'r') redis=$OPTARG     ;;
    's')
        storage=$OPTARG
        logger $INFO "Warning: MDCB installtion does not currently support postgres database";
        ;;
    'd')
        IFS=',' read -r -a deployments <<< "$OPTARG";
        ;;
    '?') usage; exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if ([[ $VANILLA != $flavor   ]] && [[ $OPENSHIFT    != $flavor   ]]) || \
   ([[ $MONGO   != $storage  ]] && [[ $POSTGRES     != $storage  ]]) || \
   ([[ $REDIS   != $redis    ]] && [[ $REDISCLUSTER != $redis    ]]  && [[ $REDISSENTINEL != $redis ]]); then
  usage; exit 1;
fi
