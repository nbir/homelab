# OpenMediaVault

## Shared Folders

```
nb-nas-test-01          # for SMB/CIFS test
nb-nas-test-02          # for NFS test

nb-nas-k8s-01           # for Kubernetes use
```

## Instructions

1. Run the OpenMediaVault preinstall script to set up persistent ethernet connection. Then restart host.
    ```
    wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/preinstall | bash
    shutdown -r now
    ```

2. Run the OpenMediaVault install script. Once completed, the script will restart host.
    ```
    wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install | bash
    ```

3. Log into OpenMediaVault UI on http://<HOST-IP-ADDRESS> (username: admin, password openmediavault). (Port forwarding is configured).

3. Enable widgets under Dashboard.

4. Erase disk under Storage > Disks if needed. Add a filesystem under Storage > File Systems. Click "+", select Type EXT4, select the disk, then click Save. Apply pending changes to mount this filesystem.

### Enable NFS

1. Enable NFS under Services > NFS > Settings, click Enabled and click Save.

2. Create a shared folder under Storage > Shared Folders.

3. Create a NFS share under Services > NFS > Shared. 

### Test Mount a NFS Shared Folder

1. Create a mount directory and mount from NFS server.
    ```
    mkdir /<mount-directory>
    mount -t nfs <nfs-server>:/export/<share-name> /<mount-directory>
    ```

2. Unmount directory.
    ```
    umount /<mount-directory>
    ```

## Reference

- https://docs.openmediavault.org/en/stable/index.html
- [Installing OpenMediaVault to a Raspberry Pi](https://pimylifeup.com/raspberry-pi-openmediavault/)
- https://github.com/openmediavault/openmediavault-k8s-recipes
- [Setting Up an OpenMediaVault Home Server with Docker, Plex, Ubooquity, and WireGuard](https://benjamintseng.com/2023/07/setting-up-an-openmediavault-home-server-with-docker-plex-ubooquity-and-wireguard/)
- [Part II: Building a Raspberry Pi NAS with OpenMediaVault: A Step-by-Step Configuration Guide](https://medium.com/@james.prakash/part-ii-building-a-raspberry-pi-nas-with-openmediavault-a-step-by-step-configuration-guide-1a177a6b1dce)
