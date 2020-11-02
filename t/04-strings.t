#!/usr/bin/env raku
use v6.c;
use Test;
use Terminal::Spinners;

plan 2;

my $classic = Spinner.new;
my $hash-bar = Bar.new;

my $spinner-output = 
    $classic.next(:nop) ~
    $classic.next(:nop) ~
    $classic.next(:no-print, :no-overwrite);

my $bar-output =
    $hash-bar.show( 0.Rat, :nop ) ~
    $hash-bar.show( 0.Num, :nop ) ~
    $hash-bar.show( 0.Int, :nop ) ~
    $hash-bar.show( (1/3*100).Rat, :nop )~
    $hash-bar.show( (1/3*100).Num, :nop )~
    $hash-bar.show( 50.Rat, :nop ) ~
    $hash-bar.show( 50.Num, :nop ) ~
    $hash-bar.show( 50.Int, :nop ) ~
    $hash-bar.show( 100.Rat, :nop ) ~
    $hash-bar.show( 100.Num, :nop ) ~
    $hash-bar.show( 100.Int, :nop ) ~
    $hash-bar.show( 100, :no-overwrite, :no-print ) ;

my $bar0-string = '[' ~
                  '#' x 0 ~
                  '.' x 71 ~
                  ']' ~
                  '  ' ~
                  '0.00%';

my $bar33-string = '[' ~
                  '#' x 23 ~
                  '.' x 48 ~
                  ']' ~
                  ' ' ~
                  '33.33%';

my $bar50-string = '[' ~
                    '#' x 35 ~
                    '.' x 36 ~
                    ']' ~
                    ' ' ~
                    '50.00%';

my $bar100-string = '[' ~
                    '#' x 71 ~
                    '.' x 0 ~
                    ']' ~
                    '100.00%';

is $spinner-output, "\b|\b/-", 'Spinner next works';

is $bar-output, "\b" x 80 ~
                $bar0-string ~
                "\b" x 80 ~
                $bar0-string ~
                "\b" x 80 ~
                $bar0-string ~
                "\b" x 80 ~
                $bar33-string ~
                "\b" x 80 ~
                $bar33-string ~
                "\b" x 80 ~
                $bar50-string ~
                "\b" x 80 ~
                $bar50-string ~
                "\b" x 80 ~
                $bar50-string ~
                "\b" x 80 ~
                $bar100-string ~
                "\b" x 80 ~
                $bar100-string ~
                "\b" x 80 ~
                $bar100-string ~
                $bar100-string,
    'Bar show works';
