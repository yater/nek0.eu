---
title: How to use OTF fonts with pdflatex
author: nek0
tags: english, writing, programming
description: A small howto for importing OTF fonts
---

In the last days I had an interesting Problem to solve, which involved
LaTeX, OTF font files and a special set of requirements. I needed to import and
use the OTF fonts in a LaTeX document and this document needed to be compiled
through pdflatex.

First off: If you need to use OTF fonts in LaTeX documents, you can simply
switch to XeLaTeX or LuaLaTeX, like I did in the first place. Both of these
environments support the package `fontspec`, which makes using fonts installed
in your system extremely easy. So if you can, switch the environment.

If you can't switch the environment, don't want to, feel a little adventurous or
even want to feel some of the innards of LaTeX you can choose the path I am
about to show.

Before you can start, you need to install the [LCDF typetools][lcdf], which is
a set of tools for manipulating the font definitions of LaTeX. Most GNU/Linux
distributions have them in their repositories, Mac users can install them
through homebrew and even Windows binaries are available on the website.
Additionally make sure, that you use `updmap` in system mode and have root
privileges.

To create the font mappings from the OTF, you simply run

```bash
sudo otftotfm -a <fontfile> --vendor <vendor> --typeface <typeface> -e texnansx
```
Where you replace the items in the angle brackets. This not only produces the
mappings, but also places them in the right directory. (If `otftotfm` complains
because of `updmap`, run the `updmap` commands in the error messages as
`updmap-sys`.)

Before you can actually use the Font, you have to write your own font
definition. A small template for this follows, which should be saved as
`T1<typeface>.df`
```latex
\ProvidesFile{T1<fontname>.fd}
[YYYY/mm/dd foobar]
\DeclareFontFamily{T1}{<fontname>}{}
\DeclareFontShape{T1}{<fontname>}{m}{n} {<-> <fontface> } {}
\endinput
```
Here you can define `<fontname>` as you wish, the other elements in angle
brackets correspond to the box above.

To actually use it, you can call
```latex
\renewcommand*{\familydefault}{<fontname>}
```
from your document to change the font in the whole document, assuming the
`T1<fontname>.fd` is in your project folder, or call
```latex
Lorem ipsum {\fontfamily{<fontname>}\fontseries{m}\fontshape{n}
\selectfont dolor sit} amet
```
to change the font only for "dolor sit" in this example.

There are tons of other options how to handle fonts in LaTeX, but this is the
most convenient one I found.

[lcdf]: http://www.lcdf.org/type/#typetools
