---
title: Mailserver
author: nek0
tags: english, programming
description: My own mailserver
---

Some time ago a few friends and I rented a root server, each of us maintaining one or more services on it. Since i gathered some experience in the field my part is to maintain the mailserver. This way we have a decentralized mail service at our hand, that is not so easily spied upon.

For running the mailservice I chose the combination of Postfix and Dovecot with SASL managed by Dovecot. To configure everything i really recommend the [Dovecot wiki](http://wiki2.dovecot.org/StartSeite) as well as the [Postfix documentation](http://www.postfix.org/documentation.html). When installing from Debian repositories you get a simple working configuration out if the box.

If you want to learn to do this by yourself, just install these services and tinker with them. Thats the best approach I can recommend, though maybe not the simplest.
