# mib2yaml
Translate MIB files to YAML files to use them with Logstash SNMP trap plugin. The script requires snmptranslate, part of net-snmp-utils packege (I believe).
## Usage
Put the names of the MIBs you want to translate into the mibs array (replace the MIB names I have put there as an example). The MIB files must exist in a directory you have assigned for MIBs, usually /usr/share/snmp/mibs. The output files are stored in /tmp, for example /tmp/NSN-SNMP-NBI-COMMONFUNCTIONS-MIB.yaml.

To use the yaml files with Logstash, copy the files to /usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/snmp-1.3.1/data/ruby/snmp/mibs/ (this directory name may vary according to your Logstash version. This is for Logstash 6.8).

The script will translate a MIB and all it's dependencies, so you might get duplicate OID errors from Logstash. I solved this by manually removing the OID lines that were duplicated in other MIBs. Usually it is enough to have everything from the root of the MIB and up. The dependencies are usually covered in a MIB that is already present in Logstash (SNMPv2-SMI for example).
