# PXE Monster

Utility to manage PXE files via web service call

If you dont want a huge PXE server like Foreman or Cobbler you can just run this little docker container to allow web calls in post kick start to remove pxelinux.cfg files so on next boot the pxelinux.cfg/default (where you can chain boot the hard drive) will be used.


## Problem this solves

When setting up my home lab for OpenStack I wanted a way I could rebuild all the hosts without touching them.  The issue is I used [consumer grade hosts](http://www.amazon.com/Gigabyte-i3-4010U-Barebones-Thickness-GB-BXi3H-4010/dp/B00I05NH9S?ie=UTF8&psc=1&redirect=true&ref_=oh_aui_detailpage_o08_s01) which do not have an IPMI interface.  They do have a PXE boot option and can be set to PXE boot on every boot.  

To accomplish my goal I set the hosts to PXE boot on every boot.   This way the host will PXE boot every time.  I then set up the PXE server up with a pxelinux.cfg/default file that will chain load the local hard drive.   

I can use PXE Monster to create a pxelinux.cfg file set to the hex value of the ip address of the host that on first reboot will start the OS install.  Then by adding a post install curl call to PXE Monster as a post OS install call I can remove the ip hex file forcing the next boot to chain load via the pxelinux.cfg/default.

The defult file should look something liek this:

```
default local

LABEL local
     MENU LABEL (local)
     MENU DEFAULT
     LOCALBOOT 0

```

This offers a REST based way to set up for a build then simply reboot the target host.   This gives me 99% of the functionality of a IPMI enabled host at 1/10 the price.


## Design

Pxe Monister will run as a docker container where you use the -v option to mount the local pxelinux folder under /pxelinux.cfg like this

```
-v /Users/cbitte000/Dev/pxemonster/spec/pxelinux.cfg:/pxelinxu.cfg
```

It is assumed you will set up your dhcp server to boot a given mac to the same ip address.  All the pxelinux.cfg files will be based on ip address ([as hex](http://www.syslinux.org/wiki/index.php?title=PXELINUX#Configuration)) not mac.  


## Usage

```
docker pull cbitter78/pxemonister
docker run --rm -ti -p 8080:80 -v /var/lib/pxelinux/pxelinux.cfg:/pxelinxu.cfg hub.docker.com/cbitter78/pxemonister:0.0.1-0

```

*NOTE:* Adjuest the localtion of your pxelinxu.cfg folder and the tag verion of the docker container. 

This will start pxemonister listing on your host on port 8080 and it will manage the local folder of /var/lib/pxelinux/pxelinux.cfg

## Config

A pxemonister.yml file must exits itn the mounted pxelinux.cfg folder.  It should look like this

```
---
- ip: 10.0.0.2
  pxe_template: ubuntu_1404.erb
  kickstart_url: http://192.168.1.1/ubuntu_1404/ubuntu.ks
- ip: 10.0.0.3
  pxe_template: ubuntu_1404.erb
  kickstart_url: http://192.168.1.1/ubuntu_1404/ubuntu.ks

```

Each elemet in the yaml array must have the ip, and pxe_template keys.  Entire hash is passed to the pxe_template ERB.  You can feel free to add extta key / values to be used in the ERB that creates the pxelinux.cfg file per ip.

The referanced pxe_template erb file must also exist in the same folder.


## Example

Take a look at the spec/pxelinux.cfg folder for an example of how you should set yours up.


# License (MIT)

Copyright (c) 2016 Charles Bitter 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.