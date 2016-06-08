mkdir /Users/garytan/Documents/output
export TOOLCHAIN=/Users/garytan/Desktop/android-sdk-macosx/android-toolchain
export SYSROOT=$TOOLCHAIN/sysroot
export ARCH=armv7
#export CROSS_COMPILE=arm-linux-androideabi
export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++
export AR=arm-linux-androideabi-ar
export AS=arm-linux-androideabi-as
export LD=arm-linux-androideabi-ld
export RANLIB=arm-linux-androideabi-ranlib
export NM=arm-linux-androideabi-nm
export STRIP=arm-linux-androideabi-strip
export CHOST=arm-linux-androideabi
export CPPFLAGS=-std=c++11
cd /Users/garytan/Documents/
curl -O http://zlib.net/zlib-1.2.8.tar.gz 
tar -xzf zlib-1.2.8.tar.gz 
mv zlib-1.2.8 zlib
cd zlib 
./configure --static 
make
ls -hs  
cp libz.a /Users/garytan/Documents/output/
export CPPFLAGS="-mthumb -mfloat-abi=softfp -mfpu=vfp -march=$ARCH  -DANDROID"
cd /Users/garytan/Documents/
#openssl
curl -O https://www.openssl.org/source/old/1.0.2/openssl-1.0.2c.tar.gz
tar -xvf openssl-1.0.2c.tar.gz 
ls 
cd openssl-1.0.2c
./Configure android-armv7 no-asm no-shared --static --with-zlib-include=/Users/garytan/Documents/zlib/include --with-zlib-lib=/Users/garytan/Documents/zlib/lib 
make build_crypto build_ssl -j 4 
ls  
cp libcrypto.a /Users/garytan/Documents/output/
cp libssl.a /Users/garytan/Documents/output/
cd /Users/garytan/Documents/
cp -r openssl-1.0.2c /Users/garytan/Documents/output/openssl
CFLAGS="-v -DANDROID --sysroot=$SYSROOT -mandroid -march=$ARCH -mfloat-abi=softfp -mfpu=vfp -mthumb -DCURL_STATICLIB"
CPPFLAGS＝"$CPPFLAGS $CFLAGS -L/Users/garytan/Documents/openssl-1.0.2c/include"
LDFLAGS="-L${TOOLCHAIN}/include -march=$ARCH -Wl,--fix-cortex-a8 -L/Users/garytan/Documents/openssl-1.0.2c"
#curl
curl -O https://curl.haxx.se/download/curl-7.43.0.tar.gz
tar -xvf curl-7.43.0.tar.gz
cd curl-7.43.0
./configure --host=arm-linux-androideabi --disable-shared --enable-static --disable-dependency-tracking --with-zlib=/Users/garytan/Documents/zlib --with-ssl=/Users/garytan/Documents/openssl-1.0.2c --without-ca-bundle --without-ca-path --enable-ipv6 --enable-http --enable-ftp --disable-file --disable-ldap --disable-ldaps --disable-rtsp --disable-proxy --disable-dict --disable-telnet --disable-tftp --disable-pop3 --disable-imap --disable-smtp --disable-gopher --disable-sspi --disable-manual --target=arm-linux-androideabi --build=x86_64-unknown-linux-gnu --prefix=/opt/curlssl || cat config.log
cd curl-7.43.0
make
ls lib/.libs/
cp lib/.libs/libcurl.a /Users/garytan/Documents/output
ls -hs /Android/output
cd /Users/garytan/Documents/
cp -r curl-7.43.0 /Users/garytan/Documents/output/curl
#libz
cd /Users/garytan/Documents/
curl -O http://www.nih.at/libzip/libzip-0.11.2.tar.gz
tar -xzf libzip-0.11.2.tar.gz
mv libzip-0.11.2 libzip
cd libzip
./configure --help
./configure --enable-static --host=arm-linux-androideabi --target=arm-linux-androideabi
make
ls -hs lib
cp lib/.libs/libzip.a /Users/garytan/Documents/output
mkdir /Users/garytan/Documents/output/ziplib 
cp lib/*.c /Users/garytan/Documents/output/ziplib
cp lib/*.h /Users/garytan/Documents/output/ziplib
cp config.h /Users/garytan/Documents/output/ziplib