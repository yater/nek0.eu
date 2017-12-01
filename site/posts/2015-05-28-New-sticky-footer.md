---
title: New sticky footer
author: nek0
tags: english, programming, meta
description: new method for sticky footer
---

Hello again.

A friend of mine, who is active in web-development, pointed out, that my method for creating a sticky foooter is a bit obsolete and showed me the proper CSS3 way to do it, which I would like to share.

First you need to prepare your site for the footer, which in the simplest terms may look like this:

```html
<html>
	<head> some info </head>
	<body class="site">
		<div class="wrapper">
			<header> Your header here </header>
			<article> Content here </article>
		</div>
		<footer> Your awesome sticky footer </footer>
	<body>
</html>
```

You simply wrap your entire content apart from your footer inside a `div`.

Next we're going to look on your css rules.

The `site` class needs a little setup:

```css
.site {
	display: flex;
	min-height: 100vh;
	flex-direction: column;
}
```

This rules put your whole site in a so called flexbox, which in our case expands vertically by setting the `flex-direction`. By doing so, wee need to specify the height of the flexbox, in our case `100vh`, which is the complete height of the viewport.

Next is the setup of the wrapper:

```css
.wrapper {
	flex: 1;
}
```

This is it!

Now your wrapper should be docked always on the bottom of your page or at the bottom of your content, when your content gets longer than your viewport.

The great advantage of this method over my old setup is, that you don't need to know the height of your footer, it will fit in automagically.
