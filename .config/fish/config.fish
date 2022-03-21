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

if status --is-interactive
    # =============================================================================
    # Startup commands
    # =============================================================================
    starship init fish | source &
    treefetch --bonsai &
    zoxide init fish | source &
    # =============================================================================

    fish_vi_cursor
    export PATH="/home/pop-os/.local/bin:$PATH"

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

    function gprune
        set force false
        switch $argv
            case -f
                set force true
        end
        for branch in (git for-each-ref --format='%(refname:short)' refs/heads) do
            # find configured upstream, if any
            set remote (git config --get branch.$branch.remote) || continue
            # # if tracking local branch, skip
            if [ "$remote" = . ]
                continue
            end
            # if the upstream commit resolves, skip
            set ucommit (git rev-parse "$branch@{u}" 2> /dev/null) && continue
            # upstream is invalid - remove local branch, or print removal
            $force && git branch -D $branch || echo "git branch -D $branch"
        end
    end


    # Jump around in code bases
    function dev
        set work_folders $HOME/dotfiles/ /media/pop-os/SBASAK/code
        set file (fdfind --hidden --exclude ".git" --type f . $work_folders | fzf --preview "bat --color=always --style=numbers --line-range=:500 {}") && cd (dirname "$file") && nvim "$file" && commandline -f repaint
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
        bind --mode insert \co dev
    end
    # =============================================================================
end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"
