use v6.c;

unit module Spinners:ver<0.0.1>:auth<github:ryn1x>;

sub bounce() is export {
    # one loop of the bounce animation
    # overwrites itself and does not end with a new line
    my @bounce = ('[=   ]',
                  '[==  ]',
                  '[=== ]',
                  '[ ===]',
                  '[  ==]',
                  '[   =]',
                  '[    ]',
                  '[   =]',
                  '[  ==]',
                  '[ ===]',
                  '[====]',
                  '[=== ]',
                  '[==  ]',
                  '[=   ]',
                  '[    ]');
    for @bounce {
        print "\b" x 6;
        print $_;
        sleep 0.066;
    }
}

sub spin() is export {
    # one loop of the spin animation
    # overwrites itself and does not end with a new line
    my @spin = <| / - \\>;
    for @spin {
        print "\b";
        print $_;
        sleep 0.08;
    }
}

sub progress(Num $percent is copy) is export {
    # Takes a floating point number and displays a progress bar for that percent
    $percent = 0e0 if $percent < 0e0;
    $percent = 100e0 if $percent > 100e0;
    my $percent-string = sprintf '%.2f', $percent;
    my $bar-length = $percent.Int * 71 div 100;
    my $blank-space = 71 - $bar-length;
    print '[' ~
          '=' x $bar-length ~
          ' ' x $blank-space ~
          ']' ~
          $percent-string ~
          '%';
}
