function fish_right_prompt
  # save evit code to variable
  set -l exit_code $status

  # show current directory (with ~)
  set_color blue
  printf '[%s]' (pwd | sed "s|^$HOME|~|")

  # if command failed, set colour to red. otherwise, to green
  if test $exit_code -ne 0
    set_color f00
  else
    set_color 0f0
  end

  # show status code of previous command
  printf '[%d]' $exit_code

  # show date [hour:minute]
  set_color cyan
  printf '[%s]' (date +%H:%M)

  # reset colours
  set_color normal
end
