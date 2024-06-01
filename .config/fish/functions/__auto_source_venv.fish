function __auto_source_venv --description 'Activate/Deactivate virtualenv on directory change' --on-variable PWD
    status is-command-substitution; and return

    # Check if we are inside a git directory
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
    else
        set gitdir "."
    end

    # If venv is not activated or a different venv is activated and venv exists.
    if test "$VIRTUAL_ENV" != "$gitdir/.venv" -a -e "$gitdir/.venv/bin/activate.fish"
        if type -q deactivate
            deactivate
        end
        # If venv activated but the current (git) dir has no venv.
    else if test -n "$VIRTUAL_ENV" -a ! -d "$gitdir/.venv" && type -q deactivate
        deactivate
    end
end
