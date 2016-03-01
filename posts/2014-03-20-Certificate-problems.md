---
title: Certificate problems
author: nek0
tags: meta, projects 
description: oncoming problems with ssl certification
---

Hi folks.

As I just recently learned the debian maintainers want to discntinue the distribution of the [CACert](http://cacert.org) root certificate with their package `ca-certificates`. More details [here](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=718434).

This is particularly bad for me, as my certificates are all from CACert, for example even the certificate for the https connection. So when you come from a Debian-based system and see a certificate issue while you connect to my site, please trust this certificate, it will be the same as it ever was.

I really hope that CACert passes its oncoming audit so that the Debian maintainers will trust the root certificate of CACert again
