source /usr/share/cachyos-fish-config/cachyos-config.fish

atuin init fish | source
set --universal fish_history null

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

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

