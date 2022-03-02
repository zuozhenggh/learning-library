# How to allow incoming http traffic (port 80) on an Ubuntu instance?
Duration: 5 minutes

## Update iptables

The Ubuntu firewall is disabled by default. However, you still need to update your iptables configuration to allow HTTP traffic. Update iptables with the following commands.

```
<copy>
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo netfilter-persistent save
</copy>
```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)


