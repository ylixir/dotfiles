# code for darwin
set -l cleanpath
# make sure nix paths are in the front
for v in $PATH
  if echo $v | grep [./]nix > /dev/null
    set cleanpath $cleanpath $v
  end
end
# put the non nix paths on the end and remove duplicates
for v in $PATH
  if ! contains -- $v $cleanpath
    set cleanpath $cleanpath $v
  end
end

set -x PATH $cleanpath
set -x EDITOR nvim
set -x VISUAL nvim
setenv SSH_ENV $HOME/.ssh/environment

function fish_user_key_bindings
  fzf_key_bindings
end

function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge ^ /dev/null
  end
end

alias vi=nvim
alias vim=nvim
