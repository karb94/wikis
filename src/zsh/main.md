% zsh

## Prompt expansion
* For a general explanation on how to set up the prompt see
[Prompt Expansion](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html)
in the zsh documentation.
* To insert new line characters in the prompt see [FAQ 3.13](http://zsh.sourceforge.net/FAQ/zshfaq03.html)
of the zsh documentation.
* To add colors to prompt see [ansi escape codes](../terminal/ansi.html). Colors can
be added by autoloading and executing the `colors` function. *Note*: ansi escape
codes are more portable.
* For zsh to interpret special characters (like `\n`) and escape codes they must
be quoted by `$'` and `'`. Example: `$'\n'`. Read the [Quoting](http://zsh.sourceforge.net/Doc/Release/Shell-Grammar.html#Quoting)
section in the zsh documentation.

Example prompt:
```zsh
PS1=$'\n%{\e[1m%}%{\e[38;5;6m%}%n:%{\e[38;5;2m%}%~/\n%{\e[0m%}$ '
```

## Word splitting doesn't work by default like bash (and it shouldn't)
By default, zsh does not have that behaviour: the variable remains intact.
(This is not a bug! See below.) The option `SH_WORD_SPLIT` exists to provide
compatibility. For example:
```zsh
var="foo bar"
args() { echo $#; }
args $var
```
produces the output `1`. But if the word splitting option is
activated with `setopt shwordsplit` the same function produces thee output `2`.
Unless you need strict sh/ksh compatibility, you should ask yourself whether
you really want this behaviour, as it can produce unexpected effects for
variables with entirely innocuous embedded spaces. This can cause horrendous
quoting problems when invoking scripts from other shells. The natural way to
produce word-splitting behaviour in zsh is via arrays. For example:
```zsh
set -A array one two three twenty
# or
array=(one two three twenty)

args $array # output: 4
```
