---
title: Comment service
author: nek0
tags: programming, projects
description: I am writing my own commenting service
---

As I stated earlier, I want to add a commenting service to my blog. I could use already existing Software, like [Disqus](http://disqus.com/) or as self hosted service the [Isso](http://posativ.org/isso/) commenting service. But lastly I decided to write my own commenting service.

I chose to do so, because my blog is generated by [Hakyll](http://jaspervdj.be/hakyll/), a static site generator written in [Haskell](http://www.haskell.org/haskellwiki/Haskell), I wanted my site to stay in the realm of this programming language.

Since there is no such commenting service implemented in Haskell yet, I have to write my own. I chose the [Yesod](http://www.yesodweb.com/) web framework as foundation for my project. It already has basic functionality, but because I have not implemented spam protection and moderation yet, I do not recommend using it outside of testing purposes. You can check it out at my git repository at Github [here](https://github.com/nek0/yacs).