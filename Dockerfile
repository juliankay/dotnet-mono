FROM ubuntu:trusty

# install mono
# http://www.mono-project.com/docs/getting-started/install/linux/#debian-ubuntu-and-derivatives-beta-channel

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian beta main" > /etc/apt/sources.list.d/mono-xamarin-beta.list \
    && apt-get -qq update \
    && apt-get -qqy install mono-devel
    
# install dotnet
# https://www.microsoft.com/net/core#ubuntu
# apt-transport-https is required

RUN apt-get -qqy install apt-transport-https \
    && apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \
    && echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list \
    && apt-get -qq update \
    && apt-get -qqy install dotnet-dev-1.0.0-preview1-002702

# install libuv for Kestrel from source code (binary is not in wheezy and one in jessie is still too old)
# combining this with the uninstall and purge will save us the space of the build tools in the image
RUN LIBUV_VERSION=1.4.2 \
	&& apt-get -qq update \
	&& apt-get -qqy install autoconf automake build-essential libtool curl \
	&& curl -sSL https://github.com/libuv/libuv/archive/v${LIBUV_VERSION}.tar.gz | tar zxfv - -C /usr/local/src \
	&& cd /usr/local/src/libuv-$LIBUV_VERSION \
	&& sh autogen.sh && ./configure && make && make install \
	&& rm -rf /usr/local/src/libuv-$LIBUV_VERSION \
	&& ldconfig \
	&& apt-get -y purge autoconf automake build-essential libtool \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/*
