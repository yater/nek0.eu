---
title: Profiling in Haskell
author: nek0
tags: programming, english
description: How to perform profiling on your Haskell projects
---

On of my projects is a game engine called "Affection". Its design is loosely
based on the game engine "Löve" for Lua.

Because I have been doing it a lot recently in this project, I would like to
make public the method of profiling I use.

## Prerequisites

first of all, you will need the profiling libraries for Haskell, which in Debian
you can find in the `ghc-prof` package.

Next you need to enable profiling in your build environment. You can do this
either globally or per-package. If you want to enable it globally, you just need
to add

```Cabal
profiling: True
```

to your `~/.cabal/config` file.

If you want to enable it per-package, you need to add the same line to a
`cabal.config` in your projects root directory (The same directory your
`*.cabal` file is located.

When enabling profiling, it might happen, that you need to reinstall a whole
lot of packages. Sandboxing your project might be a good idea.

## Compiling

Recompiling your projects with profiling options should be easy. Just invoke
`cabal build`.

## Profiling

After your build succeeded, you can start profiling your executables by

```Bash
path/to/executable +RTS -hc
```

Your executable will run as expected, you can try it out and everything. When
your application terminates, it produces an file ending with `.hp`, containing
your profiling information. Its content is rather cryptic, but that doesn't
matter. There are tools even for that. You can try running

```Bash
hp2ps -c executable.hp
```

where `executable` is the name of your executable. This produces a `.ps` file,
a simple postscript file, that you can open with your PDF-viewer. You will see
a graph showing memory allocation per function, which might lead you to memory
leaks or similar problems.

If you want to profile your executable by datatype memory allocation, just run
the profiling command (the one with the `+RTS`) and write `-hy` instead of `-hc`
.

I hope this helps you out hunting your bugs, it sure helped me a lot.
