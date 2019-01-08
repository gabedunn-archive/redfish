# name: redfish

function _prompt_whoami -d "Display user@host if on a SSH session"
  # if variable SSH_TTY is set, add (user@host) to the prompt
  if set -q SSH_TTY
    printf '(%s@%s) ' (whoami) (hostname)
  end
end

function _git_branch_name -d "Return the git branch name"
  # return either branch name or nothing
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_dirty -d "Return '*' if the git repo is dirty"
  # save dirty status to variable
  set -l dirty (command git status -s --ignore-submodules=dirty)

  # if dirty, add '*' to prompt
  if test -n "$dirty"
    printf '*'
  end
end

function _git_display -d "Display the git branch & status"
  # if current directory is a git repo, add branch name to prompt
  if [ (_git_branch_name) ]
    set_color green
    printf ':%s%s' (_git_branch_name) (_git_dirty)
    set_color blue
  end
end

function fish_prompt
  # save previous exit code
  set -l exit_code $status

  # add stlylistic symbol to prompt
  set_color -o red
  printf 'λ '
  set_color normal

  # run function to display ssh user if in ssh
  set_color cyan
  printf '%s' (_prompt_whoami)

  # display base of current directory and git information if applicable
  set_color blue
  printf '{ %s%s }\n' (basename (pwd | sed "s|^$HOME|~|")) (_git_display)

  # add stylistic symbol for prompt
  set_color red
  printf '» '

  # reset colours
  set_color normal
end
