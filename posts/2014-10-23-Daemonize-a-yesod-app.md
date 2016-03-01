---
title: Daemonize a Yesod application
author: nek0
tags: english, meta, programming 
description: Found a way to daemonize my commenting service
---

**If you want to create a systemd service file, look [here][systemd]**

As you might know I have written my own commenting service, which up until recently I had to start manually in a [screen](https://www.gnu.org/software/screen/) session. Then I decided to write my own init-script.

I have to admit, that I am no experienced sysadmin or something like that, but just a random guy with a strange love (or addiction) to computers. So this is my first time doing this.

For managing the starting and stopping of the service I chose to use the start-stop-daemon shipped with the system on my server. Additionally I used the skeleton file for init-scripts, which you can find in `/etc/init.d/skeleton`.

After consulting the manpage of start-stop-daemon I came up with the following command for starting the commenting service:

```bash
start-stop-daemon --start -b -u nek0 --chuid nek0 --name yacs --exec ./yacs -d /home/nek0/www/yacs-run/ \
-- config/settings.yml > /var/log/yacs.log

```

What this actually means: The first option ist pretty self explanatory. `-b` starts the service in the background. `-u` and `--chuid` ensure, that the service runs as a user, not as root. I chose my own user here, but you can also use `nobody` if you like. The name of the service is specified by `--name`. `-d` specifies the working directory of the service you want to start and finally `--exec` is the path to the executable, in this case relative to the working directory. Everything after the final double-dashes are arguments passed to the executable itself.

for stopping the whole thing I use the following command:

```bash
start-stop-daemon --stop -u nek0 --name yacs
```

This is even simpler than the above and is really self explanatory after all the information you got above.

the whole init-script looks like this:

```bash
#! /bin/sh
### BEGIN INIT INFO
# Provides:          yacs
# Required-Start:    $nginx
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Start YACS commenting service
# Description:       start YACS commenting service
### END INIT INFO

case "$1" in
  start)
        logger starting YACS
        start-stop-daemon --start -b -u nek0 --chuid nek0 --name yacs --exec ./yacs -d /home/nek0/www/yacs-run/ \
        -- config/settings.yml > /var/log/yacs.log
        ;;
  stop)
        logger stopping YACS
        start-stop-daemon --stop -u nek0 --name yacs 
        ;;
  restart)
        logger restarting YACS
        start-stop-daemon --stop -u nek0 --name yacs
        start-stop-daemon --start -b -u nek0 --chuid nek0 --name yacs --exec ./yacs -d /home/nek0/www/yacs-run/ \
        -- conifg/settings.yml > /var/log/yacs.log
        ;;
  status)
        # No-op
        ;;
  *)
        echo "Usage: yacs {start|stop|restart}" >&2
        exit 3
        ;;
esac
```
I hope this is helpful for others. If something is unclear, you can always leave a comment now ^^

[systemd]:https://nek0.eu/posts/2015-08-28-Damonize-a-Yesod-application-systemd-style.html
