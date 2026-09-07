alias ls="ls --color=auto"
alias grep="grep --color=auto"

PROMPT="[%n@%m %1~]%(!.#.$) "

if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR = "/run/user/$(id -u)"
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  export DBUS_SESSION_BUS_ADDRESS = "unix:path=${XDG_RUNTIME_DIR}/bus"
fi

autoload -U compinit && compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list ""

unsetopt extendedglob
unsetopt nomatch
setopt no_clobber

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
