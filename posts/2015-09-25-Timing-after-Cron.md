---
title: Timing after Cron
author: nek0
tags: english, administration
description: Cron replacement for avantgardists
---

Suddenly my Cron stopped working. It was simply gone. Without warning.

With Cron simply disappearing my daily report about the visitors of my blog was gone.

I had two options:

* tedious debugging of Cron
* finding an alternative

After trying the first with no success at all, I tried to find an alternative. A friend showed me that Systemd had timer capabilities, which i could use for my problem. After some experimentation I would like to make a tutorial for Systemd timers.

Some explanation aforehand: Systemd timers are more complex than a cronjob but don't cover all functionalities, that Cron has. For Example: You have to write two files to create one Systemd timer opposed to a single line in the crontab.

To create a Systemd timer, You need a serivce file and a timer file. I already covered how to write a service file in my [Yesod Systemd tutorial][tut], but I will cover it here again, since the service files needed for timers are simpler.

Let's assume you want to create a timer for a job called … `job`. First you create as root the file `job.service` in `/etc/systemd/service` with the content:

```
[Unit]
Description=MyScript

[Service]
Type=oneshot
ExecStart=/full/path/to/script
User=user

[Install]
WantedBy=timers.target
```

The `[Unit]` section is pretty self-explanatory, so I will skip it. The `[Service]` section defines how to run our timed service. Don't be confused about the term "service". Systemd has a very broad definition of a "service". In this example we define, that your service will run just once and stop after running. in `ExecStart` is the absolute path to our executable script. `User` defines the user, whoch will run the script. This is optional, but if not given, the user will be root. The last section, the `[Install]` section just defines, that we want to start our service when all other timers get ready.

After creating the service file, we create a timer file called `job.timer` in the same directory as the service file. But first, we need to determine, what kind of timer you need. There are two kinds. First, there is the "monotonic timer", which determines its time to execute from how long the system is running. Then there is the "realtime timer", which determines its time to run from the system clock. The sekond kind is the one more similar to the behaviour of Cron, so we will generate one. The content of the file is as follows:

```
[Unit]
Description=Runs script every hour

[Timer]
OnCalendar=hourly
Persistent=true
```

I will skip again the `[Unit]` part. The `[Timer]` part is the most interesting one. in `OnCalendar` You define when to start your service. for example: a daily execution on 0:20 would be `*-*-* 00:20:00`. For more information on the time codes call `man systemd.time`. Finally the `Persistent` flag sets, what should happen, when the service *should have* run,but the system was offline. When true, the timer will run at the next possible occasion.

To start the timer, you need to call `systemctl enable job.timer` and `systemctl start job.timer`. Do not forget the `.timer` suffix.

This should be it. If I have forgotten something, please tell me in the comments.

[tut]: https://nek0.eu/posts/2015-08-28-Daemonize-a-Yesod-application-systemd-style.html
