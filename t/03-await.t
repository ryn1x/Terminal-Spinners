#!/usr/bin/env raku
use v6.c;
use Test;
use Terminal::Spinners;

plan 3;

my class OutputCapture {
    # credit M. Lenz, Perl 6 Fundamentals
    has @!lines;
    method print(\s) {
        @!lines.push(s);
    }
    method captured() {
    @!lines.join;
    }
}

# -- Basic use --

my $spinner = Spinner.new;
my $promise = Promise.start: {40 + 2};
# capture the output so it doesn't print during testing
my $result = do {
    my $*OUT = class { method print(Str $s) {} }.new;
    $spinner.await: $promise;
}

is $result, 42, 'Spinner await returns the right result';

# -- $now --

my $outputWithN = do {
    my $*OUT = OutputCapture.new;
    my $spinner = Spinner.new;
    $spinner.await: $promise;
    $*OUT.captured;
};
like $outputWithN, /\n/, "Should have a final newline by default";

my $outputWithoutN = do {
    my $*OUT = OutputCapture.new;
    my $spinner = Spinner.new;
    $spinner.await: $promise, :no-final-newline;
    $*OUT.captured;
};
say $outputWithoutN;
unlike $outputWithoutN, /\n/, "Should not have a final newline with :no-final-newline";
