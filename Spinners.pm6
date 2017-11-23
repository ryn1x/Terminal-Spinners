use v6.c;

unit module Spinners:ver<0.0.2>:auth<github:ryn1x>;

class spinner is export {
    has $.type = 'classic';
    has $.speed = 0.08;
    has $!index = 0;
    has @!spin = <| / - \\>;
    has @!bounce = ('[=   ]', '[==  ]', '[=== ]', '[ ===]', '[  ==]',
                  '[   =]', '[    ]', '[   =]', '[  ==]', '[ ===]',
                  '[====]', '[=== ]', '[==  ]', '[=   ]', '[    ]');
    has %!types = classic => @!spin,
                  bounce => @!bounce;

    method next() {
        print "\b" x %!types{$.type}[0].chars;
        print %!types{$.type}[$!index];
        sleep $!speed;
        $!index = ($!index + 1) % %!types{$.type}.elems;
    }
}

sub equals-bar(Num $percent is copy) is export {
    # Takes a floating point number and displays a progress bar for that percent
    $percent = 0e0 if $percent < 0e0;
    $percent = 100e0 if $percent > 100e0;
    my $percent-string = sprintf '%.2f', $percent;
    my $bar-length = $percent.Int * 71 div 100;
    my $blank-space = 71 - $bar-length;
    print "\b" x 80;
    print '[' ~
          '=' x $bar-length ~
          ' ' x $blank-space ~
          ']' ~
          $percent-string ~
          '%';
}

sub hash-bar(Num $percent is copy) is export {
    # Takes a floating point number and displays a progress bar for that percent
    $percent = 0e0 if $percent < 0e0;
    $percent = 100e0 if $percent > 100e0;
    my $percent-string = sprintf '%.2f', $percent;
    my $bar-length = $percent.Int * 71 div 100;
    my $blank-space = 71 - $bar-length;
    print "\b" x 80;
    print '[' ~
          '#' x $bar-length ~
          '.' x $blank-space ~
          ']' ~
          $percent-string ~
          '%';
}
