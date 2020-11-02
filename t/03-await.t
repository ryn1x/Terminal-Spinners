#!/usr/bin/env raku
use v6.c;
use Test;
use Terminal::Spinners;

plan 1;

my $spinner = Spinner.new;
my $promise = Promise.start: {40 + 2};

# capture the output so it doesn't print during testing
my $result = do {
    my $*OUT = class { method print(Str $s) {} }.new;
    $spinner.await: $promise;
}

is $result, 42, 'Spinner await returns the right result';

