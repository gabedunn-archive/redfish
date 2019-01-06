function fish_right_prompt
  set -l exit_code $status

  set_color blue
  printf '[%s]' (pwd | sed "s|^$HOME|~|")
  if test $exit_code -ne 0
    set_color f00
  else
    set_color 0f0
  end
  printf '[%d]' $exit_code
  set_color cyan
  printf '[%s]' (date +%H:%M)
  set_color normal
end