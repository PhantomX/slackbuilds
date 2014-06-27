#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use LWP::Simple;
use File::Copy;
use Carp;

my $ipdb     = "GeoLiteCity.dat";
my $datadir  = "/usr/share/GeoIP/";
my $fullpath = $datadir . $ipdb;
my $url = "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz";
my $date = strftime "%Y%m%d", localtime;

# Do we have an existing IP database?
if ( -e $fullpath ) {
    print "Fetching " . $ipdb . " from " . $url . "\r\n";
    if ( is_success( getstore( $url, $datadir . "GeoLiteCity.dat.gz" ) ) ) {
        move( $fullpath, $datadir . $ipdb . "." . $date )
          || croak "Can't move the old database aside\r\n";
        system( 'gzip', '-d', $datadir . 'GeoLiteCity.dat.gz' );
        if ( $? ne 0 ) {
            croak "Could not uncompress database - exited $?\r\n";
        }
        print "GeoIP database updated. Old copy is at " . $ipdb . "." . $date
          . "\r\n";
    }
    else {
        croak "Fetch failed - try again later?\r\n";
    }
}
else {
    croak "You don't appear to have a valid GeoIP database installed..\r\n";
}

