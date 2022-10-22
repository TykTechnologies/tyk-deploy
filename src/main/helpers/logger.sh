ERROR="ERROR";
INFO="INFO";
DEBUG="DEBUG";

E=0
I=1
D=2

logLevelValue() {
  if [[ $LOGLEVEL == $ERROR ]]; then
    logLevel=$E
  elif [[ $LOGLEVEL == $DEBUG ]]; then
    logLevel=$D
  else
    logLevel=$I
  fi
}

setLevelValue() {
  if [[ $1 == $ERROR ]]; then
    levelValue=$E
  elif [[ $1 == $INFO ]]; then
    levelValue=$I
  elif [[ $1 == $DEBUG ]]; then
    levelValue=$D
  fi
}

logger() {
  logLevelValue
  setLevelValue $1

  if [[ $levelValue -le logLevel ]]; then
    echo -e "[$1]\t$(date +"%T") ${@: 1}";
  fi
}
