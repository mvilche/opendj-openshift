#!/bin/sh
set -e

if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
cat /usr/share/zoneinfo/$TIMEZONE >> /etc/localtime && \
echo $TIMEZONE >> /etc/timezone
fi

export JAVA_OPTS="-XX:MaxRAMFraction=1 -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Dfile.encoding=UTF8 -XX:+ExitOnOutOfMemoryError"
/opt/opendj/setup --no-prompt --cli --propertiesFilePath /opt/initialConfig/config.properties -O
exec /opt/opendj/bin/start-ds -N
