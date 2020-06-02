# wdnote

wdnote is a Zsh plugin that prints a local file, titled `.wdnote`, if present upon changing directories.

Print note:
```zsh
wdnote
```

Ignore current working directory's wdnote until resumed:
```zsh
wdnote stop
```

Resume printing note:
```zsh
wdnote show
```

List ignored directories:
```zsh
wdnote list
```

Clean up wdnote's storage by removing nonexistent directories from the ignore list:
```zsh
wdnote clean
```

List commands:
```zsh
wdnote help
```

## [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) installation

Option 1:
```zsh
git clone "https://github.com/Vesdii/zsh-wdnote" "$ZSH_CUSTOM/plugins/wdnote"
```

Option 2:
```zsh
curl --create-dirs -o "$ZSH_CUSTOM/plugins/wdnote/wdnote.plugin.zsh" "https://raw.githubusercontent.com/Vesdii/zsh-wdnote/master/wdnote.plugin.zsh"
```

Add `wdnote` to the `plugins` array in `.zshrc`.
