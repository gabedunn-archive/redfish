function fish_title
  # save current command to variable
  set -l current_command $argv[1]

  # if there is no current command, show 'user@host: pwd' (with ~), otherwise show current command
  if test -z "$current_command"
    printf '%s@%s: %s' (whoami) (hostname) (pwd | sed "s|^$HOME|~|")
  else
    printf '%s' $current_command
  end
end
