#! /usr/bin/env perl
#
# Filename: acpi
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 07 July 2025
# Last Modified: Monday 07 July 2025, 22:33
# $Id: acpi,v 1.42 2025/07/07 22:33:31 czo Git $
# Edit Time: 0:54:00
# Description:
#
#       Munin plugin
#       monitor the temperature
#
#       Load the 'thermal' kernel module and the plugin gets the
#       thermal zones from /sys/class/thermal/thermal_zone*/
#
#       Orig (c) Nicolai Langfeldt (janl@linpro.no) 2006-11-13
#
# Copyright: (C) 2025 Olivier Sirol <czo@free.fr>

# use strict;
use warnings;

## No warning or critical

##===================================================================##
## Main
exit;
$thrm='/sys/class/thermal';

die "ERROR: can't read $thrm\n" if !-d $thrm;

    ATZ=$(find /sys/class/thermal/ -maxdepth 1 -name "thermal_zone*" | sort -V)


if ( $ARGV[0] and $ARGV[0] eq "config" ) {
    print <<EOT;
    echo "graph_title ACPI Thermal zone temperatures"
    echo "graph_vlabel Celsius"
    echo "graph_category sensors"
    echo "graph_info This graph shows the temperature in different ACPI Thermal zones.  If there is only one it will usually be the case temperature."
    for ZONE in $ATZ; do
         TYPE=$(cat "$ZONE/type")
         echo "$(basename "$ZONE").label $TYPE"
    done

graph_title Load average
graph_args --base 1000 -l 0
graph_vlabel load
graph_scale no
graph_category system
graph_info The load average of the machine describes how many processes are in the run-queue (scheduled to run "immediately").
load.label load
load.info 5 minute load average"
EOT

    if ( defined $warning ) {
        $file = '/proc/stat';
        open( FILE, "<$file" ) or die "ERROR: can't read $file: $!\n";
        while (<FILE>) {
            chomp;
            if (/^cpu[0-9]+\s/) { $ncpu++ }
        }
        close FILE;

        $warning  = $warning * $ncpu;
        $critical = $critical * $ncpu;

        print <<EOT;
load.warning $warning
load.critical $critical
EOT
    }
    exit 0;
}

    for ZONE in $ATZ; do
         TEMP=$(cat "$ZONE/temp")
         echo "$(basename "$ZONE").value $(echo "$TEMP" | awk '{print $1/1000}')"
    done
    exit 0

$file = '/proc/loadavg';
open( FILE, "<$file" ) or die "ERROR: can't read $file: $!\n";
while (<FILE>) {
    chomp;
    ($load) = /^[0-9.]+\s+([0-9.]+)/;
    print "load.value $load\n";
}
close FILE;

__END__
