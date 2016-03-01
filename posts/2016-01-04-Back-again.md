---
title: Back again
author: nek0
tags: english, meta, administration
description: sorry for the recent outage
---

First of all I wish you all a pleasant new year 2016 or YOLD 3182.

I'm terribly sorry for the long outage. There were some Problems with the server my services run on. The lesson learned: Reboot your servers regularly. At least after every new kernel upgrade.

As the server was completely down and had to be reinstalled, I took the chance to make some changes to my configuration. From now on this site supports the HTTP/2.0 protocol. It is still a little shaky, but i think I will figure it out.

Another change I made was the change of my certificate issuer. I switched to [letsencrypt][le], so you, the visitors, don't need to bother with certificate imports or exceptions. This was no easy decision to make, because I personally like [CACert][cc] more and I haven't heard too good things about the letsencrypt client. So I generated my certificates manually through [gethttpsforfree][get].

Unfortunately my image gallery eidolon could not be resurrected yet, because the database has not been resurrected yet. You have to hang in there a little longer. sorry.

[le]: https://letsencrypt.org/
[cc]: http://www.cacert.org/
[get]: https://gethttpsforfree.com/
