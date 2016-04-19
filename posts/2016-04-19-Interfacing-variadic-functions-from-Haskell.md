---
title: Interfacing variadic functions from Haskell
author: nek0
tags: english, programming
description: Some findings I made while playing with the Haskell FFI
---

I confess I am a Haskell afficionado. Whenever I program something for pleasure, I usually prefer this
language because of its elegance.

Currently I am working on Haskell bindings to the [GEGL](http://www.gegl.org/) library. The motivation
behind this my desire to dabble in Game development and I have the need for a library to draw on SDL
Surfaces. I am obviously not really a fan of the easy solutions and I try to learn new things. Like using
the Haskell FFI.

While writing the bindings I encountere the problem, that GEGL exposes variadic functions in its header
which I need to interface. This poses a serious Problem for Haskell because the number of function
arguments has to be constant. There is simply no way defining a function without knowing how many
arguments it has and of what type each argument is. This stays true even for my solution. The only reason
my solution works is that I can limit the cases how to interface these variadic functions to a managable
amount.

To build my bindings I do not use the standard FFI of haskell, but the Haskell library
[inline-c](http://hackage.haskell.org/package/inline-c) to call the C functions directly without using
rigid bindings. This is achieved in inline-c by wrapping the function call into a QuasiQuoter. As I said
earlier, this still requires you to write a QuasiQuoter for every case this function gets called, but you
don't have to clutter your code with `foreign import ccall` declarations.

For limiting your cases I recommend using a sum type as a function argument. A sum type is a type which
has multiple constructors. You can have a constructor for each case you need to interface and distinguish
between them using Haskells patter matching. You can see an example on hpw to make all this
[in my bindings](https://github.com/nek0/gegl/blob/master/src/GEGL/FFI/Node.hs#L59).
