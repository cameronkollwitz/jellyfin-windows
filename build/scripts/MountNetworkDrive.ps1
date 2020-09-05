# Mounts a Network Drive to the Container
# PROTIP: Use a freakin' service account!
Invoke-Command -ScriptBlock {
  NET USE * NET USE * \\NAS\Media /USER:KOLLWITZ\CIFSServiceAccount SAPassword1!
}

# Mount Network Drive to C:\Media so Jellyfin can see it
# It is assumed that the first UNC path that is the Media volume
New-Item -ItemType SymbolicLink -Path "C:\Media" -Target "Z:"
