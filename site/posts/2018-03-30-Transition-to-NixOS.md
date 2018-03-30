---
title: Transition to NixOS
author: nek0
tags: english, administration, programming
description: My transition to NixOS
---

Just recently I made a transition, I was thinking of for quite some time. What
I'm speaking of is my transition to [NixOS][nixos].

Two days ago I just installed NixOS on my laptop out of the blue. Now I'm trying
to get my programming projects to build and work again. On may way to accomplish
this, I learned a lot about the system and its configuration.

Overall I must say, that I am quite pleased with the outcome. It is a fairly
usable system, which holds some cool advantages for me as a Haskell developer
over my old Debian system setup. Te biggest one is, That I can scrap all cabal
sandboxes from all my projects and hand the management of the right dependency
versions over to Nix.

What I want to share is a small snippet of a nix expression, that lets you
include local dependencies to your Haskell project's nix shell (like you would
do with `cabal sandbox add-source`.

First you need to create a nix shell configuration. There is a handy tool called
`cabal2nix` which you can install simply by invoking
`nix-env -iA nixos.cabal2nix`. This is the main work horse for converting any
Haskell package to nix and it does its job very well.

To build your Nix shell configuration you call `cabal2nix --shell . > shell.nix`
from your project directory. This generates the file `shell.nix` for you. Check
it for any errors. If you want to use a local package, you can add its
definition to the `shell.nix` file. To get the definition of that package, you
can again use `cabal2nix`. Simply invoke `cabal2nix file://<path to Package>` and
copy the resulting block into the `let` block of your existing `shell.nix`
like this:

```
<packageName> = with haskellPackages; callPackage (
  <packageDefinition>
  ) {};
```

Where `<packageName>` is the variable name for the package inside this Nix
expression. `<packagDefinition>` is the package definition of the local package
we just obtained from `cabal2nix`. Then delete the original package name form
the arguments of the `f` function in the let block of the Nix expression.
Finally align everything to look nicely, and save the file. To see an example of
that, you can look at the
[Nix expression of my latest game project][gamenix].

To test your setup, just invoke `nix-shell shell.nix` and watch the system build
a temporary environment for your project and give you a shell to it, if
everything went well. Now all dependencies of your project, including your local
ones are installed in this environment, so you only need to invoke
`cabal build`.

I hope You find this snippet of my Nix experience helpful, it sure took me some
time to find out.

[nixos]: https://nixos.org
[gamenix]: https://github.com/nek0/tracer/blob/master/shell.nix
