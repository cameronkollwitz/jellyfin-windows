# Windows Server Core 2004 (10.0.19041.450)
FROM mcr.microsoft.com/windows/servercore:2004

LABEL Maintainer="Cameron Kollwitz <cameron@kollwitz.us>"
LABEL Description="Jellyfin Media Player in Windows Container"
LABEL Repository="https://hub.docker.com/r/cameronkollwitz/jellyfin-windows"
LABEL Source="https://github.com/cameronkollwitz/jellyfin-windows"
LABEL Version="1.0"

# Jellyfin Version
ENV JELLYFIN_VERSION 10.6.4

# Copy files for Windows Build 20206+
COPY build/Windows/System32/20206/* C:/Windows/System32/

# Download and extract the latest stable portable version
RUN cd C:\ && curl -fSLo jellyfin.zip https://repo.jellyfin.org/releases/server/windows/versions/stable/combined/%JELLYFIN_VERSION%/jellyfin_%JELLYFIN_VERSION%.zip && tar -zxvf jellyfin.zip && mkdir C:\Jellyfin && move jellyfin_%JELLYFIN_VERSION% C:\Jellyfin\App && del /F /Q jellyfin.zip && mkdir C:\Jellyfin\AppData && mkdir C:\Media

# HTTP, HTTPS, UPNP
EXPOSE 8096/tcp 8920/tcp 1900/udp

# DNLA Server Discovery (UDP)
#EXPOSE 7359/udp

# Define Docker Volumes
VOLUME [ "C:/Jellyfin/AppData"]
VOLUME [ "C:/Users/ContainerAdministrator/AppData/Local/jellyfin" ]

# Set working directory
WORKDIR C:/Jellyfin/App

# Start the service
CMD ["jellyfin.exe" , "--service" ]