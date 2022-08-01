function v
  if test -d $argv[1]
    ls -l $argv
  else
    vim $argv
  end
end
