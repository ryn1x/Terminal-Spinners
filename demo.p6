#!/usr/bin/env perl6
use v6.c;
use lib '.';
use Spinners;

multi MAIN() {
    my $classic = Spinner.new: type => 'classic';
    my $promise = start sleep 2;
    while !$promise.status {
        $classic.next;
    }

    say '';

    my $bounce = Spinner.new: type => 'bounce';
    $promise = start sleep 2;
    while !$promise.status {
        $bounce.next;
    }

    say '';

    equals-bar 0e0;
    for 1e0 .. 3000e0 {
        my $percent = $_ * 100e0 / 3000e0;
        sleep 0.0002; # do work here
        equals-bar $percent;
    }

    say '';

    hash-bar 0e0;
    for 1e0 .. 3000e0 {
        my $percent = $_ * 100e0 / 3000e0;
        sleep 0.0002; # do work here
        hash-bar $percent;
    }

    say '';
}
