# completions/lctl.fish

function __lctl_agents
    for f in $HOME/Library/LaunchAgents/*.plist
        if test -e $f
            set full (basename $f)
            set full (string replace -r '\.plist$' '' $full)
            set short (string replace -r '^[^.]*\.[^.]*\.' '' $full)
            echo $short
            echo $full
        end
    end
end

# subcommands and descriptions
set -l cmds \
"cat:Print plist file contents" \
"edit:Edit plist file in $EDITOR" \
"file:Show file" \
"listdisabled:List disabled agents" \
"log:Show log" \
"logfiles:Show log files" \
"reload:Reload agent" \
"tail:Tail log" \
"bootout:Boot out agent" \
"bootstrap:Bootstrap agent" \
"disable:Disable agent" \
"enable:Enable agent" \
"kickstart:Kickstart agent" \
"kill:Kill agent" \
"list:List agents" \
"print:Print information"

for entry in $cmds
    set -l parts (string split ':' $entry)
    complete -c lctl -f -a $parts[1] -d $parts[2]
end

# agent completions for second argument (skip for listdisabled)
complete -c lctl -n 'not __fish_seen_subcommand_from listdisabled' -a '(__lctl_agents)' -d 'agent'
