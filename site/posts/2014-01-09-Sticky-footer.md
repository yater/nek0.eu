---
title: Sticky footer
author: nek0
tags: english, programming, meta
description: code snippet
---

Here is a simple recipe for the sticky footer that is used on this site. As this site runs on HTML5 it might not work on all browsers (Sorry, Microsoft).

first you need to define in your css or add to your existing rules:

```css
html {  
	height: 100%;  
}  
body {  
	height: 100%;  
}
```

additionally you need a wrapper class for your content. You need to adjust the negative margin value to your footer height. The value given here is only an example. Actually this will require some tinkering.

```css
.wrapper {  
	min-height: 100%;  
	height: auto !important;  
	height: 100%;  
	margin: 0 -65px;
}
```

now you need to wrap your site content in a div with the wrapper class.

If something is messed up, it is most likely because of paddings or margins. Take special care, that `body` and `html` have none of them.

The according html file might look something like this:

```html
<html>
	<head> some info </head>
	<body>
		<div class="wrapper">
			<header> your header here <header>
			<article> content here </article>
		</div>
		<footer> your awesome sticky footer</footer>
	</body>
</html>
```

I hope this is helpful for your website, if you were looking for a solution.
