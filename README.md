# Jellyfin for Windows Containers

(EXPERIMENTAL) Jellyfin Media Server in Windows Server Container

## How to Run

Not available on Docker Hub (yet)

**NOTE**: Exposed ports are mapped to the 30000 range!

```PowerShell
docker run -itd --name jellyfin -p 38096:8096 -p 38920:8920 -p 31900:1900 \
  -v "C:\Users\Administrator\AppData\Local\jellyfin:C:\Users\ContainerAdministrator\AppData\Local\jellyfin" \
  -v "C:\path\to\media:C:/media" \
  cameronkollwitz/jellyfin-windows:10.6.4
```

## How to Build

TBW.
