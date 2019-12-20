use v6.c;

unit module Terminal::Spinners:ver<1.5.0>:auth<github:ryn1x>;

class Spinner is export {
    has $.type        = 'classic';
    has $.speed       = 0.08;
    has $!index       = 0;
    has @!classic     = <| / - \\>;
    has @!bounce      = ('[=   ]', '[==  ]', '[=== ]', '[ ===]', '[  ==]',
                         '[   =]', '[    ]', '[   =]', '[  ==]', '[ ===]',
                         '[====]', '[=== ]', '[==  ]', '[=   ]', '[    ]');
    has @!bounce2     = ('( ●    )', '(  ●   )', '(   ●  )', '(    ● )',
                         '(     ●)', '(    ● )', '(   ●  )', '(  ●   )',
                         '( ●    )', '(●     )');
    has @!dots        = <⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏>;
    has @!dots2       = <⢄ ⢂ ⢁ ⡁ ⡈ ⡐ ⡠>;
    has @!dots3       = <⠈ ⠐ ⠠ ⢀ ⡀ ⠄ ⠂ ⠁>;
    has @!three-dots  = <<'.  ' '.. ' '...'>>;
    has @!three-dots2 = <<'.  ' '.. ' '...' ' ..' '  .' '   '>>;
    has @!bar         = <<▁  ▃  ▄  ▅  ▆  ▇  ▆  ▅  ▄  ▃  ▁  ' '>>;
    has @!bar2        = <<▏  ▎  ▍  ▌  ▊  ▉  ▊  ▋  ▌  ▍  ▎  ' '>>;
    has %!types       = classic     => @!classic,
                        bounce      => @!bounce,
                        bounce2     => @!bounce2,
                        dots        => @!dots,
                        dots2       => @!dots2,
                        dots3       => @!dots3,
                        three-dots  => @!three-dots,
                        three-dots2 => @!three-dots2,
                        bar         => @!bar,
                        bar2        => @!bar2;

    method next(Bool :no-overwrite(:$now) = False, Bool :no-print(:$nop) = False) {
        # returns a string of the next spinner frame
        # prints the next frame of the spinner animation
        # prints over the previous frame
        # :now stops from printing over the previous frame
        # :nop stops from printing to the screen

        my $frame;
        $frame ~= "\b" x %!types{$.type}[0].chars unless $now;
        $frame ~= %!types{$.type}[$!index];
        unless $nop {
            print $frame;
            sleep $!speed;
        }
        $!index = ($!index + 1) % %!types{$.type}.elems;
        return $frame;
    }

    method await(Promise $promise, Bool :no-overwrite(:$now) = False) {
        # awaits for a promise to return with a spinner animation
        # returns the result of the promise
        # :now stops from printing over the previous frame

        until $promise.status {
            self.next: :now($now);
        }
        say '';
        return $promise.result;
    }
}

class Bar is export {
    has $.type = 'hash';
    has $.length = 80;
    has @!hash = <[ # . ]>;
    has @!hash-dash = <[ # - ]>;
    has @!equals = <<[ = ' ' ]>>;
    has @!bar = <<'' █ ░ ''>>;
    has %!types = hash => @!hash,
                  hash-dash => @!hash-dash,
                  equals => @!equals,
                  bar => @!bar;

    method show($percent is copy, Bool :no-overwrite(:$now) = False, Bool :no-print(:$nop) = False) {
        # takes a Rat, Num, Int, Str... and shows a progress bar for that percent
        # prints over the previous progress bar
        # :now stops from printing over the previous frame
        # :nop stops from printing to the screen

        $percent = 0 if $percent < 0;
        $percent = 100 if $percent > 100;
        my $percent-string = sprintf '%.2f', $percent;
        my $num-end-chars = (%!types{$!type}[0] ~ %!types{$!type}[0]).chars;
        my $bar-length = $percent.Int * ($!length - 7 - $num-end-chars) div 100;
        my $blank-space = ($!length - 7 - $num-end-chars) - $bar-length;
        my $pad = '100.00'.chars - $percent-string.chars;
        my $bar;
        $bar ~= "\b" x $.length unless $now;
        $bar ~= %!types{$!type}[0] ~
                %!types{$!type}[1] x $bar-length ~
                %!types{$!type}[2] x $blank-space ~
                %!types{$!type}[3] ~
                ' ' x $pad ~
                $percent-string ~
                '%';
        print $bar unless $nop;
        return $bar;
    }
}
