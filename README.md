# Terminal::Spinners
Simple spinners and progress bars for Perl 6.

## Install
```bash
zef install Terminal::Spinners
```

## Usage
Classic Spinner ```|/-\```
```perl
my $spinner = Spinner.new;                        # a new default (classic) spinner 
my $promise = Promise.start: { sleep 2; 40 + 2 }; # promise of your long running process  
my $result  = $spinner.await: $promise;           # await returns the promise result
```
-or-
```perl
my $classic = Spinner.new;   # a new default (classic) spinner 
my $promise = start sleep 2; # promise of your long running process
until $promise.status {
    $classic.next;           # prints the next spinner frame
}
```

Hash Progress Bar ```[##########..........]50.00%```
```perl
my $hash-bar = Bar.new;            # defaults to the hash progress bar
$hash-bar.show: 0;                 # print a 0% progress bar
for 1 .. 3000 {
    my $percent = $_ / 3000 * 100; # calculate a percentage
    sleep 0.0002;                  # do iterative work here
    $hash-bar.show: $percent;      # print the progress bar and percent
}
```

## More options
For spinners you can set the speed:
```perl
my $spinner = Spinner.new: speed => 0; # speed in seconds
# defaults to 0.08. this provides smooth animation for use as in the example above.
# 0 seconds can be useful if you want to print the next frame each time an action occurs.
``` 
And change the type of spinner:
```perl
my $spinner = Spinner.new: type => 'bounce';
```
Choose from these types:
<pre>
classic     | / - \
bounce      [=   ] [==  ] [=== ] [ ===] [  ==] [   =] [    ] [   =] [  ==] [ ===] [====] [=== ] [==  ] [=   ] [    ]
bounce2     ( ●    ) (  ●   ) (   ●  ) (    ● ) (     ●) (    ● ) (   ●  ) (  ●   ) ( ●    ) (●     )
dots        ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏
dots2       ⢄ ⢂ ⢁ ⡁ ⡈ ⡐ ⡠
dots3       ⠈ ⠐ ⠠ ⢀ ⡀ ⠄ ⠂ ⠁
three-dots  .  .. ...
three-dots2 .  .. ... ..  .
bar         ▁  ▃  ▄  ▅  ▆  ▇  ▆  ▅  ▄  ▃  ▁
bar2        ▏  ▎  ▍  ▌  ▊  ▉  ▊  ▋  ▌  ▍  ▎
</pre>

For bars you can change the length:
```perl
my $bar = Bar.new: length => 50;
```
And you can change the type:
```perl
my $bar = Bar.new: type => 'equals';
```
Choose from these types:
<pre>
hash   [##########..........]50.00%
equals [==========          ]50.00%
</pre>

## Adverbs

```:no-overwrite``` or ```:now```:

Suppresses overwriting the previous spinner/bar. Works with ```next()```, ```await()```, and ```show()``` methods. Particularly useful on Windows where the formatting is not as expected when printing in combination with other text.

```:no-print``` or ```:nop```:

Suppresses printing and also skips any animation delays. Works with the ```next()``` and ```show()``` methods, which also return the spinner-frame or progress-bar, respectively, as a string.

## Copyright
Copyright (c) 2018, ryn1x

## License
Terminal::Spinners is released under the Artistic License 2.0.
