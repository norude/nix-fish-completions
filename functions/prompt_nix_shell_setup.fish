function prompt_nix_shell_precmd
    if test -n "$IN_NIX_SHELL"; or test -n "$IN_NIX_RUN"
        set -l NIX_SHELL_NAME ""
        if test -n "$IN_WHICH_NIX_SHELL"
            set NIX_SHELL_NAME ": $IN_WHICH_NIX_SHELL"
        end
        set -l NAME
        if test -n "$IN_NIX_SHELL"
            set NAME "nix-shell"
        else
            set NAME "nix-run"
        end

        echo -n (set_color brblack)'['(set_color yellow)"$NAME$NIX_SHELL_NAME"(set_color brblack)']'(set_color normal)' '

    end
    # if [[ $PROMPT != *"$NIX_PROMPT"* ]] then
      # PROMPT="$NIX_PROMPT $PROMPT"
    #
end

function prompt_nix_shell_setup
    functions --copy fish_prompt __nix_shell_previous_prompt # if prompt_nix_shell_setup is called twice, this will fail
    function fish_prompt
        # call the previous prompt first to not disturb $status
        set -l prompt "$(__nix_shell_previous_prompt)"
        prompt_nix_shell_precmd
        echo -n $prompt
    end
end

# Add this to your config.fish AFTER your prompt defintion
# if you want the prompt prefixed with `[nix-shell]`
# when you're in a nix-shell environment.
# prompt_nix_shell_setup
