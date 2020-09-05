# Jellyfin for Windows Containers

Jellyfin Media Server in a Windows Container.

A Windows Server implementation of the Jellyfin Media Server.

This project is largely **experimental** at this time and no stability is guaranteed!

## Requirements

* Windows device (Windows 10 Pro Insider (Fast) is used for development)
* Windows Subsystem for Linux 2 (WSL2)
* Docker Engine 19.0+
  * Utilizing Docker Desktop (Edge Edition) makes it pretty simple!

## How to Run

With a `bind` mount:

```PowerShell
docker run -itd --name jellyfin \
  -p 8096:8096 \
  -v "C:\Users\Administrator\AppData\Local\jellyfin:C:\Users\ContainerAdministrator\AppData\Local\jellyfin" \
  cameronkollwitz/jellyfin-windows:10.6.4
```

~~With a `volume` mount~~:

**NOTE:** This type of `volume` mount **DOES NOT WORK AT THIS TIME!**

```PowerShell
docker run -itd --name jellyfin \
  -p 8096:8096 \
  -v "appdata:C:\Users\ContainerAdministrator\AppData\Local\jellyfin" \
  -v "\\192.168.1.128\Media:C:\Media" # NOTE: THIS TYPE OF VOLUME DOES NOT WORK AT THIS TIME!!!
  cameronkollwitz/jellyfin-windows:10.6.4
```

## How to Build

1. Clone the repository
2. `Set-Location` to the repository directory
3. Execute: `docker build .`
4. Once finished building, you can now launch the container with the ID that is supplied.

## Data Persistence

You can bind bind the following locations in order to persist configuration, cache, metadata, etc. for the service.

Recommended Directories to Persist:

* `C:\Users\ContainerAdministrator\AppData\Local\jellyfin\cache`
* `C:\Users\ContainerAdministrator\AppData\Local\jellyfin\config`
* `C:\Users\ContainerAdministrator\AppData\Local\jellyfin\metadata`
* `C:\Users\ContainerAdministrator\AppData\Local\jellyfin\transcodes` (OPTIONAL)

Application Directory:

*Alternatively, mount the applications folder itself to persist ALL data.*

This is the ideal scenario the project is working toward.

* `C:\Users\ContainerAdministrator\AppData\Local\jellyfin`

## Bind Mounts

*Havin' issues with this one right now. Feel free to create a PR if you have ideas!*

Right now there appears to be a bug with the Windows image itself that does not allow you to tack on a `command` to run when you launch the container and/or stack with `docker-compose -up`.

This means that adding commands such as `NET USE * \\UNC\Path\To\Media /USER:UserName PASSWORD` will **NOT** work and the container will fail to start and crash with output similar to

```PowerShell
# PLACEHOLDER
# OUTPUT WILL GO HERE
```

### Workaround

While this does not help with automatically re-mounting whenever the container starts, you *can* still mount from PowerShell.

Connect to the container via PowerShell:

```PowerShell
docker exec -it CONTAINER_ID powershell.exe
```

Once connected, you can execute the command to mount the network path. Make sure you use a Service Account for network access!

```PowerShell
PS C:\> NET USE * \\UNC\Path\To\Media /USER:DOMAIN\Username PASSWORD
# OUTPUT

The command completed successfully.
```

## Notes

* Docker Hub does not autobuild Windows-based images.
* The image must be built locally and then *pushed* to the Docker Public Registry!

## Additional Information

* [Persistent Storage](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/persistent-storage)
