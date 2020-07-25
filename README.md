# wdnote

wdnote is a Zsh plugin that prints a local file, titled `.wdnote`, if present upon changing directories.

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

## [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) installation

```
git clone https://github.com/Vesdii/wdnote $ZSH_CUSTOM/plugins
```

Add `wdnote` to the `plugins` array in your `.zshrc`.
