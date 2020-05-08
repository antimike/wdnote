# wdnote
wdnote is a Zsh plugin that prints a local file, titled `.wdnote`, if present upon changing directories.

You can suppress the wdnote in any number of specific directories for a given amount of time.

Using a description compatible with the `--date` option of [GNU date](https://www.gnu.org/software/coreutils/manual/html_node/Examples-of-date.html), ignore wdnote in current working directory for given duration or future date:

**(BROKEN)**
```zsh
wdnote stop 3 weeks 2 days 1 hour
wdnote stop October 10 2020 3 AM
```

Stop showing until resumed:
```zsh
wdnote stop
```

Resume printing note:
```zsh
wdnote resume
```

Print note:
```zsh
wdnote
```

Show help:
```zsh
wdnote help
```

## [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) installation
```zsh
curl --create-dirs -o "$ZSH_CUSTOM/plugins/wdnote/wdnote.plugin.zsh" "https://raw.githubusercontent.com/Vesdii/zsh-wdnote/master/wdnote.plugin.zsh"
```
