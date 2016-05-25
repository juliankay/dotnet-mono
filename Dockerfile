FROM ubuntu:trusty

# install mono
# http://www.mono-project.com/docs/getting-started/install/linux/#debian-ubuntu-and-derivatives

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list \
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