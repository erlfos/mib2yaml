# mib2yaml
Translate MIB files to YAML files to use them with Logstash SNMP trap plugin. The script requires snmptranslate, part of snmp package and snmp-mibs-downloader package for common MIBS.
## Usage
Declare the MIBs as arguments to the script, with space in between each MIB:
```
./mib2yaml.sh GNOME-SMI SNMP-TARGET-MIB IANA-MALLOC-MIB
```
The MIB files must exist in a directory you have assigned for MIBs, usually /usr/share/snmp/mibs. The output files are stored in the current dir as yaml files, for example NSN-SNMP-NBI-COMMONFUNCTIONS-MIB.yaml.

To use the yaml files with Logstash, copy the files to /usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/snmp-1.3.1/data/ruby/snmp/mibs/ (this directory name may vary according to your Logstash version. This is for Logstash 6.8), or use a custom directory if you don't want to use the default MIBs shipped with Logstash. Example Logstash config with custom MIB dir:
```
 snmptrap {
    id => 'snmptrap'
    port => 5062
    type => 'snmptrap'
    community => ["public", "test"]
    yamlmibdir => "/usr/share/logstash/yamlfiles/"
  }
``` 

The script will translate a MIB and all it's dependencies, so you might get duplicate OID errors from Logstash. I solved this by manually removing the OID lines that were duplicated in other MIBs. Usually it is enough to have everything from the root of the MIB and up. The dependencies are usually covered in a MIB that is already present in Logstash (SNMPv2-SMI for example).
