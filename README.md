# Muninwrt - a munin node for OpenWRT

Munin is a monitoring system for Unix networks.

Munin node for OpenWRT implemented in perl like pmmn, with all plugins in /etc/munin/plugins.

As of version 1.0, it does not depends on xinetd.

Just do add this in munin.conf:

```
[chez.wam;sb-bose]
  address ssh://tc@sb-bose -t /etc/munin/munin-pmmn
  use_node_name yes
```

So you must have ```ssh``` and configured ```authorized_keys```

On OpenWRT you need to install perl and maybe perlbase-getopt and perlbase-file


## Source code
https://github.com/czodroid/muninwrt



