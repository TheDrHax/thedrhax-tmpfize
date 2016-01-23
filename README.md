# thedrhax-tmpfize
Copy any directory to RAM (tmpfs) and automatically synchronize it with HDD.

Selected directory will be copied to tmpfs and replaced with symlink. Backup of directory will be created and placed in the same path to avoid data loss (backup will be restored automatically on next mount).

## Dependencies
* rsync
* realpath

## Installation
This is a standalone script which doesn't need installation to work but it can be installed into system for easier access.

At the moment, there are three ways to install this script:

### 1. Build .deb package
Dependencies:
* fakeroot

You can build .deb package using Makefile:
```
make deb
```
And then install it with ```dpkg```:
```
sudo dpkg -i thedrhax-tmpfize-*.deb
```

### 2. Install using Makefile
You can copy tmpfize into /usr/bin using Makefile:
```sudo make install```

Also you can uninstall tmpfize with ```sudo make uninstall```

### 3. Install from my APT repository
```
echo "deb http://local.thedrhax.us.to/apt/stable/ /" | sudo tee "/etc/apt/sources.list.d/thedrhax.list"
wget -O- http://local.thedrhax.us.to/apt/TheDrHax.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install thedrhax-tmpfize
```

## Usage
Command accepts one argument (path of directory that should be moved to tmpfs).

```
tmpfize [-hrvpu] [-t interval] SOURCE_DIR[.tar.gz] -- [COMMAND]
```

Options:

```
Technical:
 -h		        - Show help page.
 -v		        - Show info messages.

Mount Settings:
 SOURCE_DIR	    - Path or name of directory that will be moved to tmpfs.

 -t interval	- Synchronize interval in seconds (default: 30, 0 to disable).
		  
 -p       		- Do not delete directory from tmpfs after unmounting.
		  
 -r		        - Mount read only. Any changes in a tmpfs copy will not be
		          saved after unmounting. [DANGEROUS]

Execute scripts:
 COMMAND	    - Execute this command after moving directory to tmpfs.
	              When command is finished, directory will be moved back.

Mount control:
 -u		        - Unmount directory.
```

### Examples

* Mount and unmount existing directory
```bash
# mount
tmpfize directory_name

# unmount
tmpfize -u directory_name
```

* Mount directory with disabled synchronization (directory will be synced after unmount)

```bash
tmpfize -t 0 directory_name
```

* Mount read-only directory (all changes will be lost after unmount)
```bash
tmpfize -r directory_name
```

* Start a custom script after mounting
```bash
tmpfize directory_name -- script_name
```

* Mounting a .tar.gz archive (since v1.3.0): archive will be unpacked to tmpfs and packed back after unmount
```bash
tmpfize directory_name.tar.gz
```
