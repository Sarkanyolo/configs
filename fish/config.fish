source /usr/share/cachyos-fish-config/cachyos-config.fish

atuin init fish | source
set --universal fish_history null

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
end

alias hx='helix'
alias rg='rg --smart-case'
alias rgh='rg --smart-case --hidden'
alias rgall='rg --smart-case --hidden --no-ignore'
alias py='python'
alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate --all'
alias md='mkdir -p'
alias df='df -h'
alias free='free -h'
alias ports='ss -tulpn'

set -gx EDITOR helix
set -gx VISUAL helix
set -gx SUDO_EDITOR helix
set -gx BROWSER firefox
set -gx PAGER less
set -gx EXPO_EDITOR code
set -gx ANDROID_SDK_ROOT /data/fejleszt/android
fish_add_path $ANDROID_SDK_ROOOT/emulator
fish_add_path $ANDROID_SDK_ROOT/platform-tools
fish_add_path $ANDROID_SDK_ROOT/cmdline-tools/latest/bin
fish_add_path ~/.local/bin ~/bin ~/.cargo/bin
