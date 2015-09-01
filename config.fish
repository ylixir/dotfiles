#set PATH ~/bin $PATH /usr/local/sbin /sbin /usr/sbin
set PATH ~/bin /usr/local/bin /bin /usr/bin /usr/local/sbin /sbin /usr/sbin /opt/texlive/2015/bin/x86_64-linux /usr/lib/jvm/oracle-jre/bin
set JAVA_HOME /usr/lib/jvm/oracle-jre

# OPAM configuration
#. /home/ylixir/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

set LANG fr_FR.UTF-8

set -x CHROME_FLAGS "--ppapi-flash-path=/usr/lib/chromium-pepper-flash/libpepflashplayer.so --ppapi-flash-version=17.0.0.134"

set -x GPGKEY 29A032C3

set -x PAGER less

ssh_agent_start
