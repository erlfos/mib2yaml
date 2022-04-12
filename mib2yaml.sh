#!/bin/bash
# Put the names of the MIBs you want to translate into the mibs array. The MIB files must exist in a directory you have assigned for MIBs, usually /usr/share/snmp/mibs
# The output files are stored in current dir (ex NSN-SNMP-NBI-COMMONFUNCTIONS-MIB.yaml)
# To use the yaml files with Logstash, copy the files to /usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/snmp-1.3.1/data/ruby/snmp/mibs/
# (this directory name may vary according to your Logstash version. This is for Logstash 6.8)

#declare -a mibs=("NSN-SNMP-NBI-COMMONFUNCTIONS-MIB" "NSN-SNMP-NBI-REGISTRATION-MIB" "NSN-SNMP-NBI-TOPOLOGY-MIB" "NSN-SNMP-NBI-FAULTMANAGEMENT-MIB" "NSN-SNMP-NBI-TEXTUALCONVENTIONS-MIB" "SYSAPPL-MIB")
declare -a mibs=($*)
for mib in "${mibs[@]}"
do
        snmptranslate -Ts -Pu -m $mib | awk -F"." '{print $NF}' >> /tmp/$mib.s
        snmptranslate -To -Pu -m $mib | sed 's/^\./: /g' >> /tmp/$mib.o
        paste -d "" /tmp/$mib.s /tmp/$mib.o >> $mib.yaml
        rm /tmp/$mib.s
        rm /tmp/$mib.o
done
