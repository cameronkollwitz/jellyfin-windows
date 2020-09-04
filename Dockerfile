# Windows Server Core 2004 (10.0.19041.450)
FROM mcr.microsoft.com/windows/servercore:2004

# Additional Options - but not used at the moment
#FROM mcr.microsoft.com/windows/servercore:ltsc2019
#FROM windows/servercore/insider

# Jellyfin Version
ENV JELLYFIN_VERSION 10.6.4

# Copy files
COPY Windows/System32/* C:/Windows/System32/

# Download and extract the latest stable portable version
RUN cd C:\ && curl -fSLo jellyfin.zip https://repo.jellyfin.org/releases/server/windows/versions/stable/combined/%JELLYFIN_VERSION%/jellyfin_%JELLYFIN_VERSION%.zip && tar -zxvf jellyfin.zip && mkdir C:\jellyfin && move jellyfin_%JELLYFIN_VERSION% C:\jellyfin\system && del /F /Q jellyfin.zip

# Expose default ports
EXPOSE 8096/tcp 8920/tcp 1900/udp

# Optional UDP
#EXPOSE 7359/udp

# Define the volume
VOLUME [ "C:/Users/ContainerAdministrator/AppData/Local/jellyfin" ]

# Set working directory
WORKDIR C:/jellyfin/system

# Start the service
CMD ["jellyfin.exe" , "--service" ]
