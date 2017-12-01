---
title: Desktop forwarding via X using Xephyr
author: nek0
tags: english, administration
description: This is a Tutorial hos to forward a whole Desktop system via X using Xephyr.
---

Hello again folks. Tonight I was in an adventurous mood and wanted to see, if I can forward a desktop session from my home computer to my laptop. I had distinct interest in OpenGL applications, since my laptop is only minimally capable of it.

Before I dive into the more technical depths I would like to conclude my findings here: Generally it is possible to forward a desktop session including a window manager, but not GL applications (yet). In general this method is a possible replacement for classical [VNC](http://de.wikipedia.org/wiki/Virtual_Network_Computing) setups.

Before you can start, there are some prerequisites that must be met:

First you need the software [Xephyr](http://www.freedesktop.org/wiki/Software/Xephyr/) on your client system (which is the System, where you want to receive your session and work on it). To install it grab the package `xserver-xephyr` with the package manager of your choice. I am assuming a [Debian](https://www.debian.org/) system here, so it might be possible, that the configuration files are located elsewhere on other GNU/Linux flavours.

Secondly there are some configurations to be made on the host system (the system you want to access remotely). You need to enable X forwarding in your SSH server in `/etc/ssh/sshd_config` by stating:

```bash
X11Forwarding yes
```

After that you are ready to give it a first shot. Fire up a terminal of your choice on your client and start up Xephyr like this:

```bash
Xephyr :1 -screen 800x600 -resizeable &
```

Mark the capital X at the beginning. This command means: start Xephyr as display `:1`, `-screen` sets the resolution and thus the size of the emerging window. Finally `-resizeable` makes the window resizeable in contrast to its normal behaviour. The last `&` puts the process in the background.

After completing this you should see a new window, which is completely black. This means everything is, as it is meant to be. You have just created a new blank display within your existing X session.

Now it's time to make the connection to your host system. This is done by:

```bash
DISPLAY=:1 ssh -Y <user>@<host>
```

Translation: set the display environment variable to `:1` and start a ssh connection with the host. The `-Y` opens a trusted X forwarding connection. Due to the setting of the display variable the X forwarding connects to your Xephyr session, which is what we want.

Now you can start up any window manager in the ssh console, preferably something lighweight like [awesome](http://awesome.naquadah.org/).
