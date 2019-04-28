#!/bin/sh -e

EMACS="${EMACS:=emacs}"

"$EMACS" -Q -batch \
         --eval "(setq byte-compile-error-on-warn t)" \
         -f batch-byte-compile \
         ./*.el
