#!/usr/bin/env perl6
use v6.c;
use lib '.';
use Spinners;

sub MAIN() {
    my $promise = start sleep 2;
    while !$promise.status {
        spin;
    }

    say '';

    $promise = start sleep 2;
    while !$promise.status {
        bounce;
    }

    say '';

    for 1e0 .. 3000e0 {
        my $percent = $_ * 100e0 / 3000e0;
        print "\b" x 80;
        equals-bar $percent;
        sleep 0.0002;
    }

    say '';

    for 1e0 .. 3000e0 {
        my $percent = $_ * 100e0 / 3000e0;
        print "\b" x 80;
        hash-bar $percent;
        sleep 0.0002;
    }

    say '';
}
