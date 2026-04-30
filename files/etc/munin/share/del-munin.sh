#! /usr/bin/env bash
#
# Filename: munin-del
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 15 February 2026
# Last Modified: Sunday 15 February 2026, 17:34
# $Id:$
# Edit Time: 0:11:38
# Description:
#
#           deletes old munin plugins
#            - df_abs is dfb
#            - df_inode wich i don't use
#
# Copyright: (C) 2026 Olivier Sirol <czo@free.fr>

if [ -d /etc/munin/plugins ]; then
    cat <<'EOF'
use at your own risk:

(
cd /etc/munin/plugins
rm df_abs df_inode acpi if_* systemd cpu df dfb forks interrupts irqstats load memory open_files open_inodes plugin.sh processes swap uptime wireless
)
EOF
fi
