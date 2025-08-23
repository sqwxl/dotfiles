function __auto_source_venv --description 'Activate/Deactivate virtualenv on directory change' --on-variable PWD
    status is-command-substitution; and return 0

    set dir (pwd)
    set gitdir
    set venv

    git rev-parse --is-inside-work-tree &>/dev/null; and set gitdir (git rev-parse --show-toplevel)

    if test -d "$dir/.venv"
        set venv "$dir/.venv"
    else if test -d "$gitdir/.venv"
        set venv "$gitdir/.venv"
    end

    if test -z "$venv"; and type -q deactivate
        deactivate
        return 0
    end

    if test "$VIRTUAL_ENV" != "$venv" -a -e "$venv/bin/activate.fish"
        type -q deactivate; and deactivate

        source "$venv/bin/activate.fish"
        return 0
    end

end
