#! /usr/bin/env perl
#
# Filename: acpi.pl
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 07 July 2025
# Last Modified: Sunday 15 February 2026, 15:24
# $Id: acpi.pl,v 1.42 2026/02/15 15:24:34 czo Git $
# Edit Time: 1:36:53
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
# Copyright: (C) 2025, 2026 Olivier Sirol <czo@free.fr>

# use strict;
use warnings;

## No warning or critical

##===================================================================##
## Main
$thrm = '/sys/class/thermal';
die "ERROR: can't read $thrm\n" if !-d $thrm;

foreach (qx(find /sys/class/thermal/ -maxdepth 1 -name "thermal_zone*")) {
    chomp;
    push( @ATZ, $_ );
}

if ( $ARGV[0] and $ARGV[0] eq "config" ) {
    print <<EOT;
graph_title ACPI Thermal zone temperatures
graph_vlabel Celsius
graph_category sensors
graph_info This graph shows the temperature in different ACPI Thermal zones. If there is only one it will usually be the case temperature.
EOT
    foreach $zone ( sort @ATZ ) {
        if ( open( my $fh, '<', "$zone/type" ) ) {
            my $type = <$fh>;
            chomp $type;
            close $fh;
            $zone_name = $zone;
            $zone_name =~ s,^.*/,,;
            print "${zone_name}.label $type\n";
        }
    }
    exit 0;
}

foreach $zone ( sort @ATZ ) {
    if ( open( my $fh, '<', "$zone/temp" ) ) {
        my $temp = <$fh>;
        chomp $temp;
        close $fh;
        $zone_name = $zone;
        $zone_name =~ s,^.*/,,;
        print "${zone_name}.value " . $temp_celsius / 1000 . "\n";
    }
}

__END__
