---
title: "Devlog: Making a game"
author: nek0
tags: english, programming, devlog
description: What I've been up to in the past month
---

Hi folks. I have good news. I am making a game.

After tinkering a lot on my game engine i thought it would be nice to have some
"real result", to be able to present the product of my endeavours. I plan to
make a talk at our local hacker symposium
"[Datenspuren](https://datenspuren.de)" and maybe even at 35C3. As a showcase
I want to present a game that is more than just a simple clone of an existing
game. I already have that. No. I want an original game.

What I came up with is a game, where you play as an intruder infiltrating a
company with your main task being getting a copy of their database. But you
have to path your way through their multi-floor building seeking clues and data
traces how to access the next floor and ultimately the server room.

For this I am starting a devlog, to show my progress as I keep on developing the
game.

So far I have my engine [affection](https://github.com/nek0/affection) as my
foundation, for drawing I use
[NanoVG-bindings](https://github.com/cocreature/nanovg-hs) and as something new
to me, I am using an entity-component-system called
[ecstasy](https://github.com/isovector/ecstasy). For now I have spent the last
month or so figuring out, how to procedurally generate sane floors for the
building and how to use the entity-component-system. So far, the whole thing
looks like this:

![](/images/2018-02-27_preview.png)

Pretty neat, isn't it?

That's all for now. See you soon!
