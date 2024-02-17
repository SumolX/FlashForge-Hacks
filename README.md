# FlashForge-Hacks
This project contains a set of scripts trying to provide additional features and functionality not implemented by the official firmware.

1. Adds and SSH `dropbear` service to your printer
2. Updates the `root` password to `FlashForge`

# ATTENTION (PROCEED AT YOUR OWN RISK)
While this installer package will add a SSH Server to your printer and modify the root password to `flashforge` it does this by modifying the `auto_run.sh` script file which is used by the printer to manages updates and execute your printer's official software.

There is ALWAYS a POSSIBILITY that an error could occur during installation and thus I am not responsible nor am I liable for rendering your printer useless.  While I did place some safeguards in order to prevent this from happening, PROCEED AT YOUR OWN RISK!

Lastly, since the Adventurer 4 runs busybox, this also means your are running with ROOT PRIVILEGES and have the ability to BRICK your printer again am I not responsible nor am I liable for any damages that YOU may incur by using this software!

# About Firmware
I have only tested against the Adventurer4-2.2.4-2.3-20230216 and the files used by this installer are based on the contents of the official firmware.  I have heavily modified the `flashforge_init.sh` script in order to install the SSH `dropbear` service and reused their `play` application to generate the upgrade completion tones.  The original official firmware files used can be found within the `Firmware` directory.

# Installation
* Copy all contents from the SSH directory and place them in the root of the USB flash disk.
* Power OFF printer and insert USB flash disk.
* Power ON printer and wait until the `FlashForge` upgrade complete tone has played.
* Power OFF printer and remove USB flash disk.
* Power ON printer and use your favorite SSH client to access the filesystem remotely!