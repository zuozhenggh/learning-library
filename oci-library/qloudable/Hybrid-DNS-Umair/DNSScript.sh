#cloud-config
runcmd:
-     sudo yum update -y
-     sudo /usr/bin/ol_yum_configure.sh
-     sudo yum install bind -y
-     sudo firewall-offline-cmd --add-port=53/udp
-     sudo firewall-offline-cmd --add-port=53/tcp
-     sudo yum install dnsmasq -y
-     sudo systemctl enable dnsmasq
-     sudo systemctl restart dnsmasq
-     sudo /bin/systemctl restart firewalld
-     sudo cp ~/named.conf /etc/named.conf
     
