# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
MAC_DEBMOD_USER="sudosaturn"
MAC_DEBMOD_PASS="asdc"
# Set name of the theme to load - disabled for Starship
ZSH_THEME=""
OLLAMA_HOST="127.0.0.1:11434"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew zsh-interactive-cd docker nvm)

source $ZSH/oh-my-zsh.sh

# Aliases
alias envx="envx tui"
alias cd="z"
alias cont="lazycontainer"
alias fix="sh ~/fix.sh"
alias python2=python3
alias python=python3
alias fuckzoom='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kris-anderson/remove-zoom-macos/master/remove_zoom_macos.sh)"'
alias dok="lazydocker"
alias gut="lazygit"
# Environment variables
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/Users/sudosaturn/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Lazy load completions directory
fpath=(~/.zsh/completions $fpath)

# Lazy load Rust completions only when rustup is used
_load_rustup_completions() {
    if [[ ! -f ~/.zsh/completions/rustup_completions.zsh ]]; then
        return
    fi
    source ~/.zsh/completions/rustup_completions.zsh
    unfunction _load_rustup_completions
}

# Lazy load llama completions only when llama commands are used
_load_llama_completions() {
    if [[ ! -f ~/.zsh/completions/llama_completions.zsh ]]; then
        return
    fi
    source ~/.zsh/completions/llama_completions.zsh
    unfunction _load_llama_completions
}

# Set up lazy loading for rustup
if command -v rustup &>/dev/null; then
    rustup() {
        _load_rustup_completions
        command rustup "$@"
    }
fi

# Set up lazy loading for llama commands
for cmd in llama-cli llama-server llama-bench; do
    if command -v $cmd &>/dev/null; then
        eval "$cmd() { _load_llama_completions; command $cmd \"\$@\"; }"
    fi
done

# Cargo environment (load only if cargo exists)
[[ -f ~/.cargo/env ]] && source ~/.cargo/env

# Bun completions (load only if bun exists)

[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# NVM (load only if directory exists)
# Ngrok completions (lazy load)
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi


alias l='eza -al --icons --group-directories-first'
export PATH="$PATH:$HOME/.local/bin"
eval "$(zoxide init zsh)"
# Initialize Starship prompt
eval "$(starship init zsh)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

alias composer="/Applications/Adam/server/php/bin/php /Applications/Adam/server/tools/composer"

eval "$(/Users/sudosaturn/.local/bin/mise activate zsh)" # added by https://mise.run/zsh
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
eval "$(tv init zsh)"
alias spotif="spotify_player"
alias fman="yazi"
alias ll="eza -a --icons --group-directories-first"

alias tree="tree -aC"
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export STARSHIP_LOG="error"
# Run neofetch during shell init, then clear
neofetch && sleep 2 && clear
