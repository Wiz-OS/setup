# =============================================================================
#  __      __________   ______
# /  \    /  \_____  \ /  __  \
# \   \/\/   //  ____/ >      <
#  \        //       \/   --   \
#   \__/\  / \_______ \______  /
#        \/          \/      \/
# config.fish --- config for fish
# Copyright (c) 2021 Sourajyoti Basak
# Author: Sourajyoti Basak < wiz28@protonmail.com >
# URL: https://github.com/wizard-28/dotfiles/
# License: MIT
# =============================================================================

fish_vi_cursor

# =============================================================================
# Functions
# =============================================================================
# git sync
function gsync
	git reset --hard HEAD~1
	git push -f
	git pull upstream $argv --rebase
	git push
end

# Jump around in code bases
function dev
	set work_folders $HOME/dotfiles/ /media/pop-os/S\ BASAK/code
	set file (fdfind --hidden --exclude ".git" --type f . $work_folders | fzf) && \
	cd (dirname "$file") && \
	nvim "$file" && \
	commandline -f repaint
end

# qrcode
function qrcode
          set input "$argv"
          [ -z "$input" ] && local input="@/dev/stdin"
          curl -d "$input" https://qrcode.show
end
# =============================================================================

# =============================================================================
# Aliases
# =============================================================================
alias l="exa --icons -F"
alias la="exa --icons -aF"
alias ll="exa --icons -Flah"
alias bcat="batcat"
# =============================================================================

# =============================================================================
# Key bindings
# =============================================================================
function fish_user_key_bindings
	bind --mode insert \co 'dev'
end
# =============================================================================

# =============================================================================
# Startup commands
# =============================================================================
starship init fish | source
# =============================================================================
