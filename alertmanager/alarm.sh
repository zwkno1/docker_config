#!/bin/bash

set -euo pipefail

env >> /opt/docker_config/alertmanager/alarm.log

if [[ "$AMX_STATUS" != "firing" ]]; then
  exit 0
fi


alarm() {
#echo $@
#echo "usage: msg recvier1;recvier2... extand_param(template code)"
#PHONE_NUM=(
#"17621859408"
#"18601707630" 
#"18717851796"
#)

PHONE_NUM=(
"17621859408"
"18601707630" 
"18717851796"
"15618051015"
)

MSG=$1
encode_str=$(python -c "import urllib; print urllib.quote('''$MSG''')")
#echo $encode_str

for i in ${PHONE_NUM[*]}
do
curl -i --get --include "http://sms.market.alicloudapi.com/singleSendSms?ParamString=%7B%22msg%22%3A%22${encode_str}%22%7D&RecNum=${i}&SignName=上海点就通&TemplateCode=SMS_67565123"  -H 'Authorization:APPCODE 3fed1e8cc1c94e53b95427b97ac4d9ee'
done

}

main() {

for i in $(seq 1 "$AMX_ALERT_LEN"); do
  name="AMX_ALERT_${i}_LABEL_alertname"
  eval "value=\$$name"
  echo "----------------------$value------------------------" >> /opt/docker_config/alertmanager/alarm.log
  name="AMX_ALERT_${i}_LABEL_name"
  eval "value=\$$name"
  alarm $value
done

}

main "$@"
