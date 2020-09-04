# Jellyfin for Windows Containers

(EXPERIMENTAL) Jellyfin Media Server in Windows Server Container

## How to Run

Not available on Docker Hub (yet)

```PowerShell
docker run -itd --name jellyfin -p 8096:8096 -p 8920:8920 -p 1900:1900 \
  -v "C:\Users\Administrator\AppData\Local\jellyfin:C:\Users\ContainerAdministrator\AppData\Local\jellyfin" \
  -v "C:\path\to\media:C:/media" \
  cameronkollwitz/jellyfin-windows:10.6.4
```

## How to Build

TBW.
