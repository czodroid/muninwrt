# Muninwrt - a Munin node for small Linux systems

### Last Modified: Monday 23 February 2026, 11:03

Munin is a networked resource monitoring tool that helps analyze resource trends.

Although Munin is an older tool, it can outperform Prometheus/AlertManager/Grafana on small systems, thanks to its lightweight design and use of an RRD-based fixed-size database.

Muninwrt is a Munin node implemented in perl, similar to `pmmn`, with all plugins located in `/etc/munin/plugins`.

It works on small Linux systems: OpenWRT, RUTX, Tiny Core Linux, piCore and so on, and even Debian 🥳.

As of version 1.0.0, Muninwrt no longer depends on `xinetd`.

Just add this to your `munin.conf`:

```
[chez.wam;sb-bose]
  address ssh://tc@sb-bose -t /etc/munin/munin-pmmn
  use_node_name yes
```

You must have `ssh` installed and a properly configured `authorized_keys`.

## Building

get the sdk, untar it, then cd to it

    ./scripts/feeds update -a
    make tools/install
    make toolchain/install

    cd feeds/packages/utils
    git clone https://github.com/czodroid/muninwrt
    cd ../../..
    ./scripts/feeds update -a
    ./scripts/feeds install muninwrt
    make menuconfig

Then in `Utilities  --->` select muninwrt `<*> muninwrt`

    make package/muninwrt/compile
    make package/index

opkg .ipk is a file like `bin/packages/arm_cortex-a7_neon-vfpv4/packages/muninwrt_1.0.1-1_all.ipk`

## Install by Releases

You can get the release here: https://github.com/czodroid/muninwrt/releases

Then copy this file to your router and install it:

    opkg install /tmp/muninwrt_1.0.1-1_all.ipk

## Install by hand

On OpenWRT, you will need to install perl and possibly the `perlbase-getopt` and `perlbase-file` packages for the plugins.

You must also run /etc/munin/share/munin-node-configure to configure all interfaces, systemd and thermal acpi if your operating system allows it (which is done when you install a release).


## Source code
https://github.com/czodroid/muninwrt


## License

License: GPL-2.0 (http://www.gnu.org/copyleft)

Copyright: (C) 2014-2026 Olivier Sirol <czo@free.fr>



