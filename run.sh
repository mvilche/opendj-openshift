#!/bin/sh
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
/opt/opendj/setup --no-prompt --acceptLicense --cli --propertiesFilePath /opt/opendj/initialConfig/config.properties -O
rm -rf /opt/opendj/locks/server.lock &> /dev/null
exec /opt/opendj/bin/start-ds -N
