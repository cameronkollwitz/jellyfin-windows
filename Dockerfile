FROM mcr.microsoft.com/windows/nanoserver:2004-amd64

# Windows Server Core 2004 (10.0.19041.450)
#FROM mcr.microsoft.com/windows/servercore:2004
# Additional Options - but not used at the moment
#FROM mcr.microsoft.com/windows/servercore:ltsc2019
#FROM windows/servercore/insider

LABEL Maintainer="Cameron Kollwitz <cameron@kollwitz.us>"
LABEL Description="Jellyfin Media Player in Windows Container"
LABEL Repository="https://hub.docker.com/r/cameronkollwitz/jellyfin-windows"
LABEL Source="https://github.com/cameronkollwitz/jellyfin-windows"
LABEL Version="1.0"

# Jellyfin Version
ENV JELLYFIN_VERSION 10.6.4

# Copy files for Windows Build 17763
#COPY build/windows/system32/17763/* C:/Windows/System32/

# Copy files for Windows Build 20206+
COPY build/windows/system32/20206/* C:/Windows/System32/

# Create new directories
RUN mkdir C:\Media && mkdir C:\Scripts && mkdir C:\Temp

# Download and extract the latest stable portable version
RUN cd C:\ && curl -fSLo jellyfin.zip https://repo.jellyfin.org/releases/server/windows/versions/stable/combined/%JELLYFIN_VERSION%/jellyfin_%JELLYFIN_VERSION%.zip && tar -zxvf jellyfin.zip && mkdir C:\jellyfin && move jellyfin_%JELLYFIN_VERSION% C:\jellyfin\system && del /F /Q jellyfin.zip

# HTTP, HTTPS, UPNP
EXPOSE 8096/tcp 8920/tcp 1900/udp
# DNLA Server Discovery (UDP)
#EXPOSE 7359/udp

# Define Volumes
VOLUME [ "C:/Users/ContainerAdministrator/AppData/Local/jellyfin" ]
#VOLUME [ "C:/Jellyfin/AppData" ]
#VOLUME [ "C:/Media" ]
#VOLUME [ "C:/Scripts" ]
#VOLUME [ "C:/Temp" ]

# Set working directory
WORKDIR C:/jellyfin/system

# Start the service
CMD ["jellyfin.exe" , "--service" ]
