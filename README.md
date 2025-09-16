# Muninwrt - a Munin node for small Linux systems

Munin is a networked resource monitoring tool that helps analyze resource trends.

Although Munin is an older tool, it can outperform Prometheus/AlertManager/Grafana on small systems, thanks to its lightweight design and use of an RRD-based fixed-size database.

Muninwrt is a Munin node implemented in perl, similar to `pmmn`, with all plugins located in `/etc/munin/plugins`.

It works on small Linux systems: OpenWRT, RUTX, Tiny Core Linux, piCorePlayer and so on, and even Debian 🥳.

As of version 1.0.0, Muninwrt no longer depends on `xinetd`.

Just add this to your `munin.conf`:

```
[chez.wam;sb-bose]
  address ssh://tc@sb-bose -t /etc/munin/munin-pmmn
  use_node_name yes
```

You must have `ssh` installed and a properly configured `authorized_keys`.

On OpenWRT, you will need to install perl and possibly the `perlbase-getopt` and `perlbase-file` packages.

## Source code
https://github.com/czodroid/muninwrt

