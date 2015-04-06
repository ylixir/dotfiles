/*
gcc debian.c -o debian
sudo chown root:root debian
sudo chmod 4755 debian
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
   setuid( 0 );
   system( "/bin/env -i HOME=/home/ylixir TERM=$TERM DISPLAY=$DISPLAY chroot --userspec=ylixir:ylixir /mnt/debian bash -l" );

   return 0;
}

