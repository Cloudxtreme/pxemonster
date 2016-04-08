# pxe monster

Utility to manage PXE files via web service call

If you dont want a huge PXE server like Foreman or Cobbler you can just run this little process to allow web calls in post kick start to remove pxelinux.cfg/mac files so on next boot the pxelinux.cfg/default (where you can chain boot the hard drive) will be used.