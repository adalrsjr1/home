if [[ $TERM_PROGRAM != "vscode" ]]; then
    if [[ -z "$TMUX" ]]; then
        tmux has -session -t=0 2>/dev/null
        if [[ $? -ne 0 ]]; then
            TMUX='' tmux new-session -d -s 0
        fi

        if [[ -z "$TMUX" ]]; then
            tmux attach -t 0
        else
            tmux switch-client -t 0
        fi
    fi
fi
