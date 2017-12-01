---
title: Daemonize a Yesod application systemd style
author: nek0
tags: english, meta, programming
description: How to daemonize a Yesod web application in systemd
---

Hello again. With exam season finally over I finally managed to upgrade my server system and thus ending up with systemd.

I wasn't convinced initially, that it was for the better, but after handling the matter, I found the whole systemd ecosystem quite helpful. Creating your own service files is something really nice.

Since I'm surely not the only one using systemd for running Yesod applications I want to reiterate my previous tutorial on daemonizing a Yesod application, but this time with systemd.

So let's create the file `my-yesod-app.service` in the directory `/etc/systemd/service`

The typical systemd unit or service file is divided into three sections called `[Unit]`, `[Install]` and `[Service]`. The first section contains basic information about the service for the system and the user, notably the description of the service and the conditions of startup. Basically this section could look like this:

```
[Unit]
Description=My Yesod webapp
After=nginx.service
```

In this example I am assuming, that you use nginx as reverse proxy to your webapp.
This would be also the place to define your dependency on a certain database service.

The `[Install]` section contains information about the installation of the service. In our case it contains only one line, which defines, that our service will be a dependency of `multi-user.target`, which means that the service will be started when the server gets into the multi-user stage.

```
[Install]
WantedBy=multi-user.target
```

The last section contains information about the executable itself and the environment it shall run in. in our case we define the working directory and the user, which shall run the service and finally define the exact command for starting your webapp.

```
[Service]
WorkingDirectory=/absolute/path/to/directory
User=user
ExecStart=/absolute/path/to/executable config/settings.yml
```

Note that the paths **must** be absolute.

After finishing the file, you need to reload the Systemd daemon with `systemctl daemon-reload`, enable the automatic startup of your webapp service with `systemctl enable my-yesod-app` and finally start it with `systemctl start my-yesod-app`.

So much for the explanation. I hope this turns out to be helpful for others. At the end you will find the complete service file for delicious copypasta.

```
[Unit]
Description=My Yesod webapp
After=nginx.service

[Install]
WantedBy=multi-user.target

[Service]
WorkingDirectory=/absolute/path/to/directory
User=user
ExecStart=/absolute/path/to/executable config/settings.yml
```
