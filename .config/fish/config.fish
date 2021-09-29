#fastfetch

fish_vi_cursor

# git sync
function gsync
	git reset --hard HEAD~1
	git push -f
	git pull upstream $argv --rebase
	git push
end

# qrcode
function qrcode
          set input "$argv"
          [ -z "$input" ] && local input="@/dev/stdin"
          curl -d "$input" https://qrcode.show
end

# Aliases
alias l="exa --icons -F"
alias la="exa --icons -aF"
alias ll="exa --icons -Flah"
alias bcat="batcat"

starship init fish | source
