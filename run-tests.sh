#!/bin/sh -e

EMACS="${EMACS:=emacs}"

"$EMACS" -Q -batch \
         --eval "(progn (setq byte-compile-error-on-warn t) (push default-directory load-path))" \
         -f batch-byte-compile \
         ./*.el
