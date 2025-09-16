#!/usr/bin/perl
# -*- perl -*-

=head1 NAME
acpi - Munin plugin to monitor the temperature in different ACPI Thermal zones.

=head1 APPLICABLE SYSTEMS
Linux systems with ACPI support.

=head1 CONFIGURATION
Load the 'thermal' kernel module and the plugin gets the thermal zones from /sys/class/thermal/thermal_zone*/ automagically.

=head1 USAGE
Link this plugin to /etc/munin/plugins/ and restart the munin-node.

=head1 INTERPRETATION
The plugin shows the temperature from the different thermal zones.

=head1 MAGIC MARKERS
 #%# family=auto
 #%# capabilities=autoconf

=head1 BUGS
None known.

=head1 VERSION
v1.0 - 2006-11-13
v1.1 - 2018-03-24

=head1 AUTHOR
Nicolai Langfeldt (janl@linpro.no) 2006-11-13

=head1 LICENSE
GPLv2

=cut

use strict;
use warnings;
use File::Basename;

# directories containing thermal zone information
my @ATZ;
if (-d '/sys/class/thermal/') {
    opendir(my $dh, '/sys/class/thermal/') or die "Cannot open /sys/class/thermal/: $!";
    my @entries = readdir($dh);
    closedir($dh);

    # Filter only thermal_zone* directories
    @ATZ = grep { /^thermal_zone/ && -d "/sys/class/thermal/$_" } @entries;

    # Sort naturally by zone number
    @ATZ = sort { version_sort($a, $b) } @ATZ;

    # Add full path
    @ATZ = map { "/sys/class/thermal/$_" } @ATZ;
}

sub version_sort {
    my ($a, $b) = @_;
    # Extract numbers from thermal_zone paths for natural sorting
    my ($num_a) = $a =~ /thermal_zone(\d+)/;
    my ($num_b) = $b =~ /thermal_zone(\d+)/;
    return ($num_a || 0) <=> ($num_b || 0);
}

sub do_fetch {
    for my $zone (@ATZ) {
        my $temp_file = "$zone/temp";
        if (open(my $fh, '<', $temp_file)) {
            my $temp = <$fh>;
            chomp $temp;
            close $fh;

            my $zone_name = basename($zone);
            my $temp_celsius = $temp / 1000;
            print "${zone_name}.value $temp_celsius\n";
        }
    }
    exit 0;
}

sub do_config {
    print "graph_title ACPI Thermal zone temperatures\n";
    print "graph_vlabel Celsius\n";
    print "graph_category sensors\n";
    print "graph_info This graph shows the temperature in different ACPI Thermal zones.  If there is only one it will usually be the case temperature.\n";

    for my $zone (@ATZ) {
        my $type_file = "$zone/type";
        if (open(my $fh, '<', $type_file)) {
            my $type = <$fh>;
            chomp $type;
            close $fh;

            my $zone_name = basename($zone);
            print "${zone_name}.label $type\n";
        }
    }

    # print values immediately if dirtyconfig is supported
    if (($ENV{MUNIN_CAP_DIRTYCONFIG} || 0) eq '1') {
        do_fetch();
    }
}

sub do_autoconf {
    if (@ATZ == 0) {
        print "no (failed to find thermal zones below /sys/class/thermal/thermal_zone*)\n";
        exit 0;
    }

    for my $zone (@ATZ) {
        my $temp_file = "$zone/temp";
        if (!-r $temp_file) {
            print "no (cannot read $temp_file)\n";
            exit 0;
        }
    }

    print "yes\n";
    exit 0;
}

# Main logic
my $action = $ARGV[0] || '';

if ($action eq 'config') {
    do_config();
} elsif ($action eq 'autoconf') {
    do_autoconf();
} elsif ($action eq 'fetch') {
    do_fetch();
} elsif ($action eq '') {
    # no-arg is fetch
    do_fetch();
} else {
    # Invalid argument, exit with error
    exit 1;
}

exit 0;
