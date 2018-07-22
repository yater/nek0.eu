---
title: "Devlog: Interactable objects"
author: nek0
tags:
- english
- programming
- "devlog: tracer"
description: A new view on my progress so far
---

Hi folks. Sorry I haven't updated in tha past 2 months. I was busy at work and
with everything else. But that didnÄt keep me from making any progress. I got
animations up and running, so the player and the NPCs are no longer just dots,
but they have real bodies.

I also now have loading screens, which were a little
trickier than I thought in the beginning. My problems boiled down to the fact,
that if I have another thread, which wants to do some actions with OpenGL, it
needs to have its own context and context sharing has to be enabled.

My biggest breakthrough I achieved just today: Interactable objects. Until now
you could move around the map and test out collision between the player and his
surroundings, but not more. Now you can move up to any copier and activate it
with a right click when you stand right in front of it and look in the right
direction. For now this just changes the animation, that is played, but it's a
start. Here is a small screencap I made of the whole process:

<video controls="true">
<source src="/vids/2018-07-22.webm" type="video/webm" />
</video>

The copier itself is also an interesting. because it is animated, it does not
reside in the Matrix where all the walls, tables and boxes are. It resides like
allother animated things (e.g.: the player and the NPCs) inside the Entity
Component System, but it still has collision boundaries, which are respected by
the player and the NPCs. That took me some time to figure out, how to do this.

I am also preparing a possibility to have the game's solution generated
procedurally. Graph theory for the win!

I already have submitted my talk to the ["Datenspuren" event][ds] and hope it
will get accepted.

See you (hopefully) soon.

[ds]: https://datenspuren.de/2018
