function fish_title
  printf '%s@%s: %s' (whoami) (hostname) (pwd | sed "s|^$HOME|~|")
end
