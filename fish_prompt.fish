# name: redfish

function _prompt_whoami -d "Display user@host if on a SSH session"
  if set -q SSH_TTY
    printf '(%s@%s) ' (whoami) (hostname)
  end
end

function _git_branch_name -d "Return the git branch name"
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty -d "Return whether the git repo is dirty"
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _git_display -d "Display the git branch & status"
  if [ (_git_branch_name) ]
    set_color green
    if [ (_is_git_dirty) ]
      printf ':%s*' (_git_branch_name)
    else
      printf ':%s' (_git_branch_name)
    end
    set_color blue
  end
end

function fish_prompt
  set -l exit_code $status

  set_color -o red
  printf 'λ '

  set_color cyan
  printf '%s' (_prompt_whoami)

  set_color blue
  printf '{ %s%s }\n' (basename (pwd)) (_git_display)

  set_color red
  printf '» '

  set_color normal
end