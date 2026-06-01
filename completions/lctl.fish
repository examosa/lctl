# completions/lctl.fish

function __lctl_agents
    for file in ~/Library/LaunchAgents/*.plist
        set --local label (path basename --no-extension -- $file)
        path extension -- $label
        echo $label
    end
end

# subcommands and descriptions
set --local cmds \
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
    set --local parts (string split ':' $entry)
    complete --command lctl --no-files --arguments $parts[1] --description $parts[2]
end

# agent completions for second argument (skip for listdisabled)
complete --command lctl --condition 'not __fish_seen_subcommand_from listdisabled' --arguments '(__lctl_agents)' --description 'agent'
