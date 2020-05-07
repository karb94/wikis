% zsh

## Prompt expansion
* For a general explanation on how to set up the prompt see
[Prompt Expansion](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html)
in the zsh documentation.
* To insert new line characters in the prompt see [FAQ 3.13](http://zsh.sourceforge.net/FAQ/zshfaq03.html)
of the zsh documentation.

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

## Ansi escape codes
The list of the first 16 colors is usually set to match the desired colorscheme
(see [Gruvbox](https://github.com/morhetz/gruvbox) as an example) via your
terminal configuration file. After you have changed those (or any) colors in
your terminal configuration the ansi color codes will refer to those colors. To
access those colors you can use an [ansi escape code](https://en.wikipedia.org/wiki/ANSI_escape_code):

```
\e[38;5;1m     # Color defined as color 1 in the terminal configuration
\e[38;5;4m     # Color defined as color 4 in the terminal configuration
\e[1m          # Bold font
\e[m           # Resets all attributes (colors, type of font etc.)
\e[0m          # Same as \e[m
```
These codes are universal so they should be used over any shell specific
variables for portability.
