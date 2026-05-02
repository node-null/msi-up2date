# msi-up2date






# timesyncd
cat << 'EOF' > /opt/zabbix/configs/msi-timesyncd.conf
UserParameter=timesyncd.LinkNTPServers,timedatectl show-timesync --property=LinkNTPServers | awk -F= '{print $2}'
UserParameter=timesyncd.SystemNTPServers,timedatectl show-timesync --property=SystemNTPServers | awk -F= '{print $2}'
UserParameter=timesyncd.RuntimeNTPServers,timedatectl show-timesync --property=RuntimeNTPServers | awk -F= '{print $2}'
UserParameter=timesyncd.FallbackNTPServers,timedatectl show-timesync --property=FallbackNTPServers | awk -F= '{print $2}'
UserParameter=timesyncd.ServerName,timedatectl show-timesync --property=ServerName | awk -F= '{print $2}'
UserParameter=timesyncd.ServerAddress,timedatectl show-timesync --property=ServerAddress | awk -F= '{print $2}'
UserParameter=timesyncd.RootDistanceMaxUSec,timedatectl show-timesync --property=RootDistanceMaxUSec | awk -F= '{print $2}'
UserParameter=timesyncd.PollIntervalMinUSec,timedatectl show-timesync --property=PollIntervalMinUSec | awk -F= '{print $2}'
UserParameter=timesyncd.PollIntervalMaxUSec,timedatectl show-timesync --property=PollIntervalMaxUSec | awk -F= '{print $2}'
UserParameter=timesyncd.PollIntervalUSec,timedatectl show-timesync --property=PollIntervalUSec | awk -F= '{print $2}'
UserParameter=timesyncd.NTPMessage,timedatectl show-timesync --property=NTPMessage
UserParameter=timesyncd.Frequency,timedatectl show-timesync --property=Frequency | awk -F= '{print $2}'
EOF
