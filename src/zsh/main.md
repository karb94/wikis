% zsh

## Prompt expansion
You can concatenate strings buy just writing them one next to the other.
k

## Word splitting doesn't work by default like bash (and it shouldn't)
By default, zsh does not have that behaviour: the variable remains intact.
(This is not a bug! See below.) The option `SH_WORD_SPLIT` exists to provide
compatibility. For example:
```
var="foo bar"
args() { echo $#; }
args $var
```
produces the output `1`. But if the word splitting option is
activated with `setopt shwordsplit` the same function produces thee output `2`.
