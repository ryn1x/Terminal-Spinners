#!/usr/bin/env perl6
use v6.c;
use Test;
use Terminal::Spinners;

plan 1;

my $spinner = Spinner.new;
my $promise = Promise.start: {40 + 2};
my $result = $spinner.await: $promise;

is $result, 42, 'Spinner await returns the right result';
