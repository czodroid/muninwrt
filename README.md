# Muninwrt - a munin node for small Linux systems

Munin is a networked resource monitoring tool that can help analyze resource trends.

Munin is an old resource monitoring tool with an RRD database that can outperform Prometheus/AlertManager/Grafana for small systems.

Muninwrt is a munin node implemented in perl like pmmn, with all plugins in /etc/munin/plugins.

It works on small Linux systems: OpenWRT, RUTX, Tiny Core Linux, piCorePlayer and so on, and even on debian 🥳

As of version 1.0.0 of muninwrt, it does not depends on xinetd.

Just do add this in munin.conf:

```
[chez.wam;sb-bose]
  address ssh://tc@sb-bose -t /etc/munin/munin-pmmn
  use_node_name yes
```

So you must have ```ssh``` and a configured ```authorized_keys```

On OpenWRT you need to install perl and maybe perlbase-getopt and perlbase-file


## Source code
https://github.com/czodroid/muninwrt



