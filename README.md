# wdnote

wdnote is a Zsh plugin that prints a local file, titled `.wdnote`, if present upon changing directories.

This is the branch for use with [Prezto](https://github.com/sorin-ionescu/prezto). For use with [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh), see that branch.

Print note:
```
wdnote
```

Ignore current working directory's wdnote until resumed:
```
wdnote stop
```

Resume printing note:
```
wdnote show
```

List ignored directories:
```
wdnote list
```

Clean up wdnote's storage by removing nonexistent directories from the ignore list:
```
wdnote clean
```

List commands:
```
wdnote help
```

## Installation

```
mkdir -p $ZPREZTODIR/contrib
git submodule add --force https://github.com/sevenhearted/wdnote $ZPREZTODIR/contrib/wdnote
```

Load the module in your `.zpreztorc`.
