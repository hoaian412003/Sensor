#!/bin/bash


agg_conf_name=$1

if [ -z ${agg_conf_name+x} ];
then
    echo "Invalid command, unknow first parameter. Using: ./sensor.install.sh <agg_config_name>"
else
    echo "Creating file agg"
fi


cat << EOF > winery-agg.conf
[agent]
      hostname = "$agg_conf_name"
  flush_interval = "10s"
  interval = "10s"


# Input Plugins
[[inputs.cpu]]
    percpu = true
    totalcpu = true
    collect_cpu_time = false
    report_active = false
[[inputs.disk]]
    ignore_fs = ["tmpfs", "devtmpfs", "devfs"]
[[inputs.io]]
[[inputs.mem]]
[[inputs.net]]
[[inputs.system]]
[[inputs.swap]]
[[inputs.netstat]]
[[inputs.processes]]
[[inputs.kernel]]

# Output Plugin InfluxDB
[[outputs.influxdb]]
  database = "telegraf"
  urls = [ "http://54.254.47.35:8086" ]
  username = "telegraf2"
  password = "5aMWYbKGUv3Q7A4U"
EOF

echo "Created file agg.conf !!!"


chmod +x telegraf.install.sh
source telegraf.install.sh

sudo systemctl start telegraf
sudo systemctl enable telegraf
