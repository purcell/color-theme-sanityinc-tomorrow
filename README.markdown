[![Melpa Status](http://melpa.org/packages/color-theme-sanityinc-tomorrow-badge.svg)](http://melpa.org/#/color-theme-sanityinc-tomorrow)
[![Build Status](https://github.com/purcell/color-theme-sanityinc-tomorrow/actions/workflows/test.yml/badge.svg)](https://github.com/purcell/color-theme-sanityinc-tomorrow/actions/workflows/test.yml)
[![Melpa Stable Status](http://stable.melpa.org/packages/color-theme-sanityinc-tomorrow-badge.svg)](http://stable.melpa.org/#/color-theme-sanityinc-tomorrow)
<a href="https://www.patreon.com/sanityinc"><img alt="Support me" src="https://img.shields.io/badge/Support%20Me-%F0%9F%92%97-ff69b4.svg"></a>

An Emacs version of
[Chris Kempson's "Tomorrow" themes](https://github.com/ChrisKempson/Tomorrow-Theme),
with much more extensive face definitions than the "official" Emacs
variant.

The themes work with both the built-in theming support in recent
Emacsen, *and* via the traditional `color-theme.el` add-on library in
older versions, so use whichever you prefer.

## Installation ##

If you're all set up to use [Marmalade](http://marmalade-repo.org) or
[MELPA](http://melpa.org/) (highly recommended!), simply

    M-x package-install RET color-theme-sanityinc-tomorrow RET

If you use [el-get](https://github.com/dimitri/el-get/), simply add
this to your packages list:

    color-theme-sanityinc-tomorrow

Otherwise, ensure a directory containing these files is on your `load-path`.

If you're using an Emacs version older than 23.x, you'll also need to
install `color-theme.el`.

## Usage ##

    (require 'color-theme-sanityinc-tomorrow)

    M-x color-theme-sanityinc-tomorrow-day
    M-x color-theme-sanityinc-tomorrow-night
    M-x color-theme-sanityinc-tomorrow-blue
    M-x color-theme-sanityinc-tomorrow-bright
    M-x color-theme-sanityinc-tomorrow-eighties

In newer Emacs versions, just require the library as above, then

    M-x customize-themes

<hr>

Author links:

[💝 Support this project and my other Open Source work](https://www.patreon.com/sanityinc)

[💼 LinkedIn profile](https://uk.linkedin.com/in/stevepurcell)

[✍ sanityinc.com](http://www.sanityinc.com/)

[🐦 @sanityinc](https://twitter.com/sanityinc)
