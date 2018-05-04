# tso-playbook

This is multiple plabook roles for creating user, deleting user, installing software, deleting software, list software, LVM, etc.


## Remove Logical Volume
1 - unmount<br>
2 - fschange (resizefs=yes)<br>
3 - lvresize (size=smaller-disk force=yes)<br>
4 - vgreduce<br>

## Troubleshooting missing physical volume
1 - fdisk-list (pv=sdb output=pv-ok)<br>
2 - pvdisplay (pv=sdb output=missing-pv)<br>
3 - reboot server (or check with support if there is an alternative without reboot)<br>
4 - when you create pv or vg or lv, force option=yes.<br>
# tso-playbook
