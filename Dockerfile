FROM ubuntu:trusty

# install mono
# http://www.mono-project.com/docs/getting-started/install/linux/#debian-ubuntu-and-derivatives-beta-channel
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian beta main" > /etc/apt/sources.list.d/mono-xamarin-beta.list \
    && apt-get -qq update \
    && apt-get -qqy install mono-devel
    
# https://www.microsoft.com/net/core#ubuntu
# apt-transport-https is required
RUN apt-get -qqy install apt-transport-https

# install dotnet
RUN  echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list \
        && apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \
        && apt-get update \
        && apt-get -y install dotnet-dev-1.0.0-preview2-003121 \
