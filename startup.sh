#!/bin/bash

export LANG="pt_BR.UTF-8"

if [ -n "${XAUTHORITY}" ] && [ -n "${HOST_HOSTNAME}" ]
then
  if [ "${HOSTNAME}" != "${HOST_HOSTNAME}" ]
  then
    [ -f ${XAUTHORITY} ] || touch ${XAUTHORITY}
    xauth add ${HOSTNAME}/unix${DISPLAY} . \
    $(xauth -f /tmp/.docker.xauth list ${HOST_HOSTNAME}/unix${DISPLAY} | awk '{ print $NF }')
  else
    cp /tmp/.docker.xauth ${XAUTHORITY}
  fi
fi

if [ ! -d ~/.mozilla ]
then
  # sudo dbus-uuidgen > /etc/machine-id \
  firefox -CreateProfile default \
  && sudo apt update \
  && sudo apt -y upgrade \
  && sudo apt -y install /src/GBPCEFwr64.deb
else
  sudo /etc/init.d/warsaw start
fi

/usr/local/bin/warsaw/core \
&& firefox -private-window www.caixa.gov.br
