/*
gcc netflix.c -o netflix
sudo chown root:root netflix
sudo chmod 4755 netflix
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
   setuid( 0 );
   system( "/bin/env -i HOME=/home/ylixir TERM=$TERM DISPLAY=$DISPLAY chroot --userspec=ylixir:ylixir /mnt/debian /usr/bin/google-chrome --app=https://www.netflix.com" );

   return 0;
}

