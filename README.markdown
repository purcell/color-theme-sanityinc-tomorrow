An Emacs color-theme version of Chris Kempson's "Tomorrow" themes.

The themes work with both the built-in theming support in recent
Emacsen, *and* via the traditional `color-theme.el` add-on library in
older versions, so use whichever you prefer.

## Installation ##

If you're all set up to use [marmalade-repo.org](http://marmalade-repo.org)
(highly recommended!), simply

    M-x package-install RET color-theme-sanityinc-tomorrow RET

Otherwise, ensure sure a directory containing these files is on your `load-path`.

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

See https://github.com/ChrisKempson/Tomorrow-Theme for more info.


<hr>

[![](http://api.coderwall.com/purcell/endorsecount.png)](http://coderwall.com/purcell)

[![](http://www.linkedin.com/img/webpromo/btn_liprofile_blue_80x15.png)](http://uk.linkedin.com/in/stevepurcell)
