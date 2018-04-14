---
title: Devlog: Progress with "Tracer"
author: nek0
tags: english programming devlog
description: The progress of nearly a month
---

Hi. This is the second post in my ongoing devlog for my game "Tracer". About a
month ago I posted my initial breakthrough, where I could build a floor of the
building the player will be infiltrating. A lot changed since then.

The floors still exist, but are not as colourful as they used to be. The floor
is now uniformly white, because I have no proper texture for the floor, but I
added some furniture. For now it's just tables and some cardboard boxes, but
there will be more. There is also sanity checking when placing furniture.
Everything that needs to be accessed is reachable.

I reworked the collision system, which used to be tile based. This was good for
the beginning and easy to implement, but I soon realized, that I needed
something more complex. So instead of checking if a tile can be walked upon,
there are now boundaries within a tile, based upon the object existing on that
tile, where the player can't walk. This took me a whole lot of time getting it
to work properly. I had several instances, where the player could glitch through
walls under certain circumstances.

My biggest breakthrough though I finished just today. I have laid the foundation
for NPCs. For now they don't have any real appearance, they are just displayed
as red dots (the player is also just a cyan coloured dot). For now they just
walk around randomly between tables, where they stay some random time. Again I
fell, that the Entity Component System is a very powerful tool here. I suspect
that my former game projects failed partly because of the lack of this tool.

This is how it looks now:

![](/images/2018-04-14_preview.png)

Unfortunately you don't get to see the dots moving on a still image, but you can
get an impression.

seeya!
