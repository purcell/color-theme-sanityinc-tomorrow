;;; color-theme-sanityinc-tomorrow.el --- A version of Chris Kempson's "tomorrow" themes

;; Copyright (C) 2012-2017 Steve Purcell

;; Author: Steve Purcell <steve@sanityinc.com>
;; Keywords: faces themes
;; Homepage: http://github.com/purcell/color-theme-sanityinc-tomorrow
;; Version: 0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; These five color themes are designed for use with Emacs' built-in
;; theme support in Emacs 24. However, they also work with older Emacs
;; versions, in which case color-theme.el is required.

;; Usage:

;; If your Emacs has the `load-theme' command, you can use it to
;; activate one of these themes programatically, or use
;; `customize-themes' to select a theme interactively.

;; Alternatively, or in older Emacs versions, use one of the provided
;; wrapper commands to activate a theme:

;;     M-x color-theme-sanityinc-tomorrow-day
;;     M-x color-theme-sanityinc-tomorrow-night
;;     M-x color-theme-sanityinc-tomorrow-blue
;;     M-x color-theme-sanityinc-tomorrow-bright
;;     M-x color-theme-sanityinc-tomorrow-eighties
;;
;;; Credit:

;; Colour selection by Chris Kempson:
;; https://github.com/ChrisKempson/Tomorrow-Theme

;;; Code:

(require 'color)

(eval-when-compile (require 'ansi-color))
(declare-function color-theme-install "color-theme")

(defun sanityinc-tomorrow--interpolate (hex1 hex2 gradations which)
  (let ((c1 (color-name-to-rgb hex1))
        (c2 (color-name-to-rgb hex2)))
    (apply 'color-rgb-to-hex (nth which (color-gradient c1 c2 gradations)))))

(defun sanityinc-tomorrow--alt-background (background highlight)
  "Calculate the alt-background color by blending BACKGROUND and HIGHLIGHT.
This cannot be done at runtime because its output is dependent
upon the display characteristics of the frame in which it is
executed."
  (sanityinc-tomorrow--interpolate background highlight 7 3))

(defconst color-theme-sanityinc-tomorrow-colors
  '((night . ((background . "#1d1f21")
              (alt-background . "#22a224a427a7")
              (current-line . "#282a2e")
              (selection . "#373b41")
              (foreground . "#c5c8c6")
              (comment . "#969896")
              (red . "#cc6666")
              (orange . "#de935f")
              (yellow . "#f0c674")
              (green . "#b5bd68")
              (aqua . "#8abeb7")
              (blue . "#81a2be")
              (purple . "#b294bb")))
    (day . ((background . "#ffffff")
            (alt-background . "#f7f7f7f7f7f7")
            (current-line . "#efefef")
            (selection . "#d6d6d6")
            (foreground . "#4d4d4c")
            (comment . "#8e908c")
            (red . "#c82829")
            (orange . "#f5871f")
            (yellow . "#eab700")
            (green . "#718c00")
            (aqua . "#3e999f")
            (blue . "#4271ae")
            (purple . "#8959a8")))
    (eighties . ((background . "#2d2d2d")
                 (alt-background . "#333333333333")
                 (current-line . "#393939")
                 (selection . "#515151")
                 (foreground . "#cccccc")
                 (comment . "#999999")
                 (red . "#f2777a")
                 (orange . "#f99157")
                 (yellow . "#ffcc66")
                 (green . "#99cc99")
                 (aqua . "#66cccc")
                 (blue . "#6699cc")
                 (purple . "#cc99cc")))
    (blue . ((background . "#002451")
             (alt-background . "#00002c2c5fdf")
             (current-line . "#00346e")
             (selection . "#003f8e")
             (foreground . "#ffffff")
             (comment . "#7285b7")
             (red . "#ff9da4")
             (orange . "#ffc58f")
             (yellow . "#ffeead")
             (green . "#d1f1a9")
             (aqua . "#99ffff")
             (blue . "#bbdaff")
             (purple . "#ebbbff")))
    (bright . ((background . "#000000")
               (alt-background . "#151515151515")
               (current-line . "#2a2a2a")
               (selection . "#424242")
               (foreground . "#eaeaea")
               (comment . "#969896")
               (red . "#d54e53")
               (orange . "#e78c45")
               (yellow . "#e7c547")
               (green . "#b9ca4a")
               (aqua . "#70c0b1")
               (blue . "#7aa6da")
               (purple . "#c397d8")))))



(defmacro color-theme-sanityinc-tomorrow--with-colors (mode &rest body)
  "Execute `BODY' in a scope with variables bound to the various tomorrow colors.

Also sets background-mode to either 'light or 'dark, for use in
setting `frame-background-mode'.

`MODE' should be set to either 'day, 'night, 'eighties, 'blue or 'bright."
  `(let* ((colors (or (cdr (assoc ,mode color-theme-sanityinc-tomorrow-colors))
                      (error "no such theme flavor")))
          (background   (cdr (assoc 'background colors)))
          (contrast-bg  (cdr (assoc 'selection colors)))
          (highlight    (cdr (assoc 'current-line colors)))
          (low-contrast-bg (cdr (assoc 'alt-background colors)))
          (foreground   (cdr (assoc 'foreground colors)))
          (comment      (cdr (assoc 'comment colors)))
          (red          (cdr (assoc 'red colors)))
          (orange       (cdr (assoc 'orange colors)))
          (yellow       (cdr (assoc 'yellow colors)))
          (green        (cdr (assoc 'green colors)))
          (aqua         (cdr (assoc 'aqua colors)))
          (blue         (cdr (assoc 'blue colors)))
          (purple       (cdr (assoc 'purple colors)))
          (class '((class color) (min-colors 89)))
          (background-mode (if (eq ,mode 'day) 'light 'dark)))
     ,@body))

(defmacro color-theme-sanityinc-tomorrow--face-specs ()
  "Return a backquote which defines a list of face specs.

It expects to be evaluated in a scope in which the various color
names to which it refers are bound."
  (quote
   (mapcar
    (lambda (entry)
      (list (car entry) `((,class ,@(cdr entry)))))
    `(;; Standard font lock faces
      (default (:foreground ,foreground :background ,background))
      (bold (:weight bold))
      (bold-italic (:slant italic :weight bold))
      (underline (:underline t))
      (italic (:slant italic))
      (font-lock-builtin-face (:foreground ,purple))
      (font-lock-comment-delimiter-face (:foreground ,comment :slant italic))
      (font-lock-comment-face (:foreground ,comment :slant italic))
      (font-lock-constant-face (:foreground ,blue))
      (font-lock-doc-face (:foreground ,purple))
      (font-lock-doc-string-face (:foreground ,yellow))
      (font-lock-function-name-face (:foreground ,orange))
      (font-lock-keyword-face (:foreground ,green))
      (font-lock-negation-char-face (:foreground ,blue))
      (font-lock-preprocessor-face (:foreground ,purple))
      (font-lock-regexp-grouping-backslash (:foreground ,yellow))
      (font-lock-regexp-grouping-construct (:foreground ,purple))
      (font-lock-string-face (:foreground ,aqua))
      (font-lock-type-face (:foreground ,blue))
      (font-lock-variable-name-face (:foreground ,yellow))
      (font-lock-warning-face (:weight bold :foreground ,red))
      (shadow (:foreground ,comment))
      (success (:foreground ,green))
      (error (:foreground ,red))
      (warning (:foreground ,orange))
      (tooltip (:foreground ,yellow :background ,background :inverse-video t))

      ;; Emacs interface
      (cursor (:background ,red))
      (fringe (:background ,low-contrast-bg :foreground ,comment))
      (linum (:background ,low-contrast-bg :foreground ,comment :italic nil :underline nil))
      (line-number (:background ,low-contrast-bg :foreground ,comment))
      (line-number-current-line (:inherit line-number :foreground ,foreground :weight bold))
      (fill-column-indicator (:foreground ,contrast-bg :weight normal :slant normal
                                          :underline nil :overline nil :strike-through nil
                                          :box nil :inverse-video nil :stipple nil))
      (vertical-border (:foreground ,contrast-bg))
      (border (:background ,contrast-bg :foreground ,highlight))
      (highlight (:inverse-video nil :background ,highlight))
      (mode-line (:foreground ,foreground :background ,contrast-bg :weight normal
                              :box (:line-width 1 :color ,contrast-bg)))
      (mode-line-buffer-id (:foreground ,purple :background nil))
      (mode-line-inactive (:inherit mode-line
                                    :foreground ,comment
                                    :background ,highlight
                                    :weight normal))
      (mode-line-emphasis (:foreground ,foreground :slant italic))
      (mode-line-highlight (:foreground ,purple :box nil :weight bold))
      (minibuffer-prompt (:foreground ,blue))
      (region (:background ,contrast-bg :inverse-video nil :extend t))
      (secondary-selection (:background ,highlight :extend t))

      (header-line (:inherit mode-line-inactive :foreground ,aqua :background nil))

      ;; search
      (match (:foreground ,blue :background ,background :inverse-video t))
      (isearch (:foreground ,yellow :background ,background :inverse-video t))
      (lazy-highlight (:foreground ,aqua :background ,background :inverse-video t))
      (isearch-fail (:background ,background :inherit font-lock-warning-face :inverse-video t))

      (link (:foreground nil :underline t))
      (widget-button (:underline t))
      (widget-field (:background ,contrast-bg :box (:line-width 1 :color ,foreground)))

      ;; ansi-term (built-in)
      (term (:foreground nil :background nil :inherit default))
      (term-color-black (:foreground ,background :background ,background))
      (term-color-red (:foreground ,red :background ,red))
      (term-color-green (:foreground ,green :background ,green))
      (term-color-yellow (:foreground ,yellow :background ,yellow))
      (term-color-blue (:foreground ,blue :background ,blue))
      (term-color-magenta (:foreground ,purple :background ,purple))
      (term-color-cyan (:foreground ,aqua :background ,aqua))
      (term-color-white (:foreground ,foreground :background ,foreground))

      ;; antlr-mode (built-in)
      (antlr-keyword (:inherit font-lock-keyword-face))
      (antlr-syntax (:inherit font-lock-constant-face))
      (antlr-ruledef (:inherit font-lock-function-name-face))
      (antlr-ruleref (:inherit font-lock-type-face))
      (antlr-tokendef (:inherit font-lock-function-name-face))
      (antlr-tokenref (:inherit font-lock-type-face))
      (antlr-literal (:inherit font-lock-constant-face))

      ;; calendar (built-in)
      (diary (:foreground ,yellow))
      (holiday (:foreground ,background :background ,orange))

      ;; Compilation (built-in)
      (compilation-column-number (:foreground ,yellow))
      (compilation-line-number (:foreground ,yellow))
      (compilation-message-face (:foreground ,blue))
      (compilation-mode-line-exit (:foreground ,green))
      (compilation-mode-line-fail (:foreground ,red))
      (compilation-mode-line-run (:foreground ,blue))

      ;; completion display (built-in)
      (completions-annotations (:foreground ,comment :slant italic))
      (completions-common-part (:foreground ,blue))
      (completions-first-difference (:foreground ,orange :weight bold))

      ;; custom (built-in)
      (custom-variable-tag (:foreground ,blue))
      (custom-group-tag (:foreground ,blue))
      (custom-state (:foreground ,green))

      ;; diff-mode (built-in)
      (diff-added (:foreground ,green :extend t))
      (diff-changed (:foreground ,blue))
      (diff-removed (:foreground ,orange :extend t))
      (diff-header (:foreground ,aqua :background nil :extend t))
      (diff-file-header (:foreground ,blue :background nil :extend t))
      (diff-hunk-header (:foreground ,purple))
      (diff-indicator-added (:inherit diff-added))
      (diff-indicator-changed (:inherit diff-changed))
      (diff-indicator-removed (:inherit diff-removed))
      (diff-refine-added (:foreground ,aqua))
      (diff-refine-changed (:foreground ,yellow))
      (diff-refine-removed (:foreground ,red))

      ;; ediff (built-in)
      (ediff-current-diff-A (:foreground ,comment :background ,highlight :extend t))
      (ediff-current-diff-Ancestor (:foreground ,aqua :background ,highlight))
      (ediff-current-diff-B (:foreground ,comment :background ,highlight :extend t))
      (ediff-current-diff-C (:foreground ,comment :background ,highlight :extend t))
      (ediff-even-diff-A (:foreground ,blue :background ,contrast-bg :extend t))
      (ediff-even-diff-Ancestor (:foreground ,purple :background ,highlight))
      (ediff-even-diff-B (:foreground ,blue :background ,contrast-bg :extend t))
      (ediff-even-diff-C (:foreground ,blue :background ,contrast-bg :extend t))
      (ediff-fine-diff-A (:foreground ,green :background ,contrast-bg))
      (ediff-fine-diff-Ancestor (:foreground ,yellow :background ,highlight))
      (ediff-fine-diff-B (:foreground ,green :background ,contrast-bg))
      (ediff-fine-diff-C (:foreground ,green :background ,contrast-bg))
      (ediff-odd-diff-A (:foreground ,orange :background ,contrast-bg :extend t))
      (ediff-odd-diff-Ancestor (:foreground ,red :background ,highlight))
      (ediff-odd-diff-B (:foreground ,orange :background ,contrast-bg :extend t))
      (ediff-odd-diff-C (:foreground ,orange :background ,contrast-bg :extend t))

      ;; ElDoc (built-in)
      (eldoc-highlight-function-argument (:foreground ,green :weight bold))

      ;; ERC (built-in)
      (erc-direct-msg-face (:foreground ,orange))
      (erc-error-face (:foreground ,red))
      (erc-header-face (:foreground ,foreground :background ,highlight))
      (erc-input-face (:foreground ,green))
      (erc-keyword-face (:foreground ,yellow))
      (erc-current-nick-face (:foreground ,green))
      (erc-my-nick-face (:foreground ,green))
      (erc-nick-default-face (:weight normal :foreground ,purple))
      (erc-nick-msg-face (:weight normal :foreground ,yellow))
      (erc-notice-face (:foreground ,comment))
      (erc-pal-face (:foreground ,orange))
      (erc-prompt-face (:foreground ,blue))
      (erc-timestamp-face (:foreground ,aqua))
      (erc-keyword-face (:foreground ,green))

      ;; ERT (built-in)
      (ert-test-result-unexpected (:inherit error))
      (ert-test-result-expected (:inherit success))

      ;; eshell (built-in)
      (eshell-prompt (:foreground ,yellow :weight bold))
      (eshell-ls-archive (:foreground ,blue))
      (eshell-ls-backup (:foreground ,comment))
      (eshell-ls-clutter (:foreground ,orange :weight bold))
      (eshell-ls-directory :foreground ,blue :weight bold)
      (eshell-ls-executable (:foreground ,yellow :weight bold))
      (eshell-ls-missing (:foreground ,red :weight bold))
      (eshell-ls-product (:foreground ,green))
      (eshell-ls-readonly (:foreground ,red))
      (eshell-ls-special (:foreground ,purple :weight bold))
      (eshell-ls-symlink (:foreground ,aqua :weight bold))
      (eshell-ls-unreadable (:foreground ,comment))

      ;; Flycheck (built-in)
      (flycheck-error (:underline (:style wave :color ,red)))
      (flycheck-info (:underline (:style wave :color ,aqua)))
      (flycheck-warning (:underline (:style wave :color ,orange)))
      (flycheck-fringe-error (:foreground ,red))
      (flycheck-fringe-info (:foreground ,aqua))
      (flycheck-fringe-warning (:foreground ,orange))
      (flycheck-color-mode-line-error-face (:foreground ,red))
      (flycheck-color-mode-line-warning-face (:foreground ,orange))
      (flycheck-color-mode-line-info-face (:foreground ,aqua))
      (flycheck-color-mode-line-running-face (:foreground ,comment))
      (flycheck-color-mode-line-success-face (:foreground ,green))

      ;; Flymake (built-in)
      (flymake-error (:underline (:style wave :color ,red)))
      (flymake-note (:underline (:style wave :color ,aqua)))
      (flymake-warning (:underline (:style wave :color ,orange)))

      ;; Flyspell (built-in)
      (flyspell-incorrect (:underline (:style wave :color ,red)))

      ;; Gnus (built-in)
      (gnus-button (:inherit link :foreground nil))
      (gnus-emphasis-highlight-words (:foreground ,yellow :background ,highlight))
      (gnus-header-content (:inherit message-header-other))
      (gnus-header-from (:inherit message-header-other-face :weight bold :foreground ,orange))
      (gnus-header-name (:inherit message-header-name))
      (gnus-header-newsgroups (:foreground ,yellow :slant italic))
      (gnus-header-subject (:inherit message-header-subject))
      (gnus-x-face (:foreground ,background :background ,foreground))
      (gnus-signature (:inherit font-lock-comment-face))

      (mm-uu-extract (:foreground ,green :background ,highlight))

      (gnus-cite-1 (:foreground ,blue))
      (gnus-cite-2 (:foreground ,purple))
      (gnus-cite-3 (:foreground ,aqua))
      (gnus-cite-4 (:foreground ,yellow))
      (gnus-cite-5 (:foreground ,orange))
      (gnus-cite-6 (:foreground ,blue))
      (gnus-cite-7 (:foreground ,purple))
      (gnus-cite-8 (:foreground ,aqua))
      (gnus-cite-9 (:foreground ,red))
      (gnus-cite-10 (:foreground ,comment))
      (gnus-cite-11 (:foreground ,contrast-bg))

      (gnus-group-mail-1 (:foreground ,blue :weight normal))
      (gnus-group-mail-1-empty (:inherit gnus-group-mail-1 :foreground ,comment))
      (gnus-group-mail-2 (:foreground ,purple :weight normal))
      (gnus-group-mail-2-empty (:inherit gnus-group-mail-2 :foreground ,comment))
      (gnus-group-mail-3 (:foreground ,aqua :weight normal))
      (gnus-group-mail-3-empty (:inherit gnus-group-mail-3 :foreground ,comment))
      (gnus-group-mail-4 (:foreground ,yellow :weight normal))
      (gnus-group-mail-4-empty (:inherit gnus-group-mail-4 :foreground ,comment))
      (gnus-group-mail-5 (:foreground ,orange :weight normal))
      (gnus-group-mail-5-empty (:inherit gnus-group-mail-5 :foreground ,comment))
      (gnus-group-mail-6 (:foreground ,blue :weight normal))
      (gnus-group-mail-6-empty (:inherit gnus-group-mail-6 :foreground ,comment))
      (gnus-group-mail-low (:foreground ,comment))
      (gnus-group-mail-low-empty (:foreground ,comment))

      (gnus-group-news-1 (:foreground ,blue :weight normal))
      (gnus-group-news-1-empty (:inherit gnus-group-news-1 :foreground ,comment))
      (gnus-group-news-2 (:foreground ,purple :weight normal))
      (gnus-group-news-2-empty (:inherit gnus-group-news-2 :foreground ,comment))
      (gnus-group-news-3 (:foreground ,aqua :weight normal))
      (gnus-group-news-3-empty (:inherit gnus-group-news-3 :foreground ,comment))
      (gnus-group-news-4 (:foreground ,yellow :weight normal))
      (gnus-group-news-4-empty (:inherit gnus-group-news-4 :foreground ,comment))
      (gnus-group-news-5 (:foreground ,orange :weight normal))
      (gnus-group-news-5-empty (:inherit gnus-group-news-5 :foreground ,comment))
      (gnus-group-news-6 (:foreground ,blue :weight normal))
      (gnus-group-news-6-empty (:inherit gnus-group-news-6 :foreground ,comment))

      (gnus-server-agent (:foreground ,aqua :weight bold))
      (gnus-server-closed (:foreground ,comment :slant italic))
      (gnus-server-cloud (:foreground ,orange :weight bold))
      (gnus-server-denied (:foreground ,red :weight bold))
      (gnus-server-offline (:foreground ,blue :weight bold))
      (gnus-server-opened (:foreground ,green :weight bold))

      (gnus-splash (:foreground ,aqua))

      (gnus-summary-cancelled (:foreground ,red :background nil :weight normal))
      (gnus-summary-high-ancient (:foreground ,green :weight normal))
      (gnus-summary-high-read (:foreground ,green :weight normal))
      (gnus-summary-high-ticked (:foreground ,orange :weight normal))
      (gnus-summary-high-undownloaded (:foreground ,foreground :weight bold))
      (gnus-summary-high-unread (:foreground ,yellow :weight normal))

      (gnus-summary-low-ancient (:foreground ,comment :weight normal))
      (gnus-summary-low-read (:foreground ,comment :weight normal))
      (gnus-summary-low-ticked (:foreground ,comment :slant italic))
      (gnus-summary-low-undownloaded (:foreground ,foreground :slant italic))
      (gnus-summary-low-unread (:foreground ,comment :weight normal))

      (gnus-summary-normal-ancient (:foreground ,aqua :weight normal))
      (gnus-summary-normal-read (:foreground ,foreground :weight normal))
      (gnus-summary-normal-ticked (:foreground ,orange :weight normal))
      (gnus-summary-normal-undownloaded (:foreground ,foreground))
      (gnus-summary-normal-unread (:foreground ,blue :weight normal))

      ;; grep (built-in)
      (grep-context-face (:foreground ,comment))
      (grep-error-face (:foreground ,red :weight bold :underline t))
      (grep-hit-face (:foreground ,blue))
      (grep-match-face (:foreground nil :background nil :inherit match))

      ;; hi-lock (built-in)
      (hi-black-hb (:weight bold))
      (hi-blue (:foreground ,background :background ,blue))
      (hi-blue-b (:foreground ,blue :weight bold))
      (hi-green (:foreground ,background :background ,green))
      (hi-green-b (:foreground ,green :weight bold))
      (hi-pink (:foreground ,background :background ,aqua))
      (hi-red-b (:foreground ,red :weight bold))
      (hi-yellow (:foreground ,background :background ,yellow))

      ;; icomplete (built-in)
      (icomplete-first-match (:foreground ,green :weight bold))

      ;; IDO (built-in)
      (ido-subdir (:foreground ,purple))
      (ido-first-match (:foreground ,orange))
      (ido-only-match (:foreground ,green))
      (ido-indicator (:foreground ,red :background ,background))
      (ido-virtual (:foreground ,comment))

      ;; info (built-in)
      (Info-quoted (:inherit font-lock-constant-face))
      (info-index-match (:inherit isearch))
      (info-menu-header (:foreground ,green :weight bold :height 1.4))
      (info-menu-star (:foreground ,yellow))
      (info-node (:foreground ,green :weight bold :slant italic))
      (info-title-1 (:weight bold :height 1.4))
      (info-title-2 (:weight bold :height 1.2))
      (info-title-3 (:weight bold :foreground ,orange))
      (info-title-4 (:weight bold :foreground ,purple))
      (info-xref-visited (:foreground ,comment :underline t))

      ;; kaocha-runner
      (kaocha-runner-error-face (:foreground ,red))
      (kaocha-runner-success-face (:foreground ,green))
      (kaocha-runner-warning-face (:foreground ,yellow))

      ;; Message-mode (built-in)
      (message-header-other (:foreground nil :background nil :weight normal))
      (message-header-subject (:inherit message-header-other :weight bold :foreground ,yellow))
      (message-header-to (:inherit message-header-other :weight bold :foreground ,orange))
      (message-header-cc (:inherit message-header-to :foreground nil))
      (message-header-name (:foreground ,blue :background nil))
      (message-header-newsgroups (:foreground ,aqua :background nil :slant normal))
      (message-separator (:foreground ,purple))

      ;; nxml (built-in)
      (nxml-name-face (:foreground unspecified :inherit font-lock-constant-face))
      (nxml-attribute-local-name-face (:foreground unspecified :inherit font-lock-variable-name-face))
      (nxml-ref-face (:foreground unspecified :inherit font-lock-preprocessor-face))
      (nxml-delimiter-face (:foreground unspecified :inherit font-lock-keyword-face))
      (nxml-delimited-data-face (:foreground unspecified :inherit font-lock-string-face))
      (rng-error-face (:underline ,red))

      ;; org-mode (built-in)
      (org-agenda-structure (:foreground ,purple))
      (org-agenda-current-time (:foreground ,yellow))
      (org-agenda-date (:foreground ,blue :underline nil))
      (org-agenda-done (:foreground ,green))
      (org-agenda-dimmed-todo-face (:foreground ,comment))
      (org-block (:background ,low-contrast-bg))
      (org-block-begin-line (:background ,background :foreground ,comment :slant italic))
      (org-block-end-line (:background ,background :foreground ,comment :slant italic))
      (org-code (:foreground ,yellow))
      (org-column (:background ,contrast-bg))
      (org-column-title (:inherit org-column :weight bold :underline t))
      (org-date (:foreground ,blue :underline t))
      (org-date-selected (:foreground ,aqua :inverse-video t))
      (org-document-info (:foreground ,aqua))
      (org-document-info-keyword (:foreground ,green))
      (org-document-title (:weight bold :foreground ,orange :height 1.4))
      (org-done (:foreground ,green))
      (org-ellipsis (:foreground ,comment))
      (org-footnote (:foreground ,aqua))
      (org-formula (:foreground ,red))
      (org-hide (:foreground ,background :background ,background))
      (org-habit-alert-face (:foreground ,background :background ,yellow))
      (org-habit-alert-future-face (:foreground ,background :background ,orange))
      (org-habit-clear-face (:foreground ,background :background ,comment))
      (org-habit-clear-future-face (:foreground ,background :background ,purple))
      (org-habit-overdue-face (:foreground ,background :background ,blue))
      (org-habit-overdue-future-face (:foreground ,background :background ,red))
      (org-habit-ready-face (:foreground ,background :background ,aqua))
      (org-habit-ready-future-face (:foreground ,background :background ,green))
      (org-link (:foreground ,blue :underline t))
      (org-mode-line-clock-overrun (:inherit mode-line :background ,red))
      (org-scheduled (:foreground ,green))
      (org-scheduled-previously (:foreground ,aqua))
      (org-scheduled-today (:foreground ,green))
      (org-special-keyword (:foreground ,orange))
      (org-table (:foreground ,purple))
      (org-time-grid (:foreground ,yellow))
      (org-todo (:foreground ,red))
      (org-upcoming-deadline (:foreground ,orange))
      (org-warning (:weight bold :foreground ,red))

      ;; Outline (built-in)
      (outline-1 (:inherit nil :foreground ,blue))
      (outline-2 (:inherit nil :foreground ,purple))
      (outline-3 (:inherit nil :foreground ,aqua))
      (outline-4 (:inherit nil :foreground ,yellow))
      (outline-5 (:inherit nil :foreground ,orange))
      (outline-6 (:inherit nil :foreground ,blue))
      (outline-7 (:inherit nil :foreground ,purple))
      (outline-8 (:inherit nil :foreground ,aqua))
      (outline-9 (:inherit nil :foreground ,yellow))

      ;; outline-minor-faces
      (outline-minor-0 (:weight bold :background ,low-contrast-bg))
      (outline-minor-1 (:inherit (outline-minor-0 outline-1)))

      ;; Parenthesis matching (built-in)
      (show-paren-match (:background ,purple :foreground ,background))
      (show-paren-mismatch (:background ,red :foreground ,background))

      ;; rcirc (built-in)
      (rcirc-bright-nick (:foreground ,yellow))
      (rcirc-dim-nick (:foreground ,comment))
      (rcirc-keyword (:foreground ,green))
      (rcirc-my-nick (:foreground ,green))
      (rcirc-nick-in-message (:foreground ,yellow))
      (rcirc-nick-in-message-full-line (:foreground ,orange))
      (rcirc-other-nick (:foreground ,purple))
      (rcirc-prompt (:foreground ,blue))
      (rcirc-server (:foreground ,green))
      (rcirc-timestamp (:foreground ,aqua))

      ;; re-builder (built-in)
      (reb-match-0 (:foreground ,background :background ,aqua))
      (reb-match-1 (:foreground ,background :background ,yellow))
      (reb-match-2 (:foreground ,background :background ,orange))
      (reb-match-3 (:foreground ,background :background ,blue))

      ;; ruler-mode (built-in)
      (ruler-mode-column-number (:foreground ,foreground :background ,highlight))
      (ruler-mode-comment-column (:foreground ,comment :background ,contrast-bg))
      (ruler-mode-current-column (:foreground ,yellow :background ,contrast-bg :weight bold))
      (ruler-mode-default (:foreground ,comment :background ,highlight))
      (ruler-mode-fill-column (:foreground ,red :background ,contrast-bg))
      (ruler-mode-fringes (:foreground ,green :background ,contrast-bg))
      (ruler-mode-goal-column (:foreground ,red :background ,contrast-bg))
      (ruler-mode-margins (:foreground ,orange :background ,contrast-bg))
      (ruler-mode-pad (:foreground ,background :background ,comment))
      (ruler-mode-tab-stop (:foreground ,blue :background ,contrast-bg))

      ;; sh-script (built-in)
      (sh-heredoc (:foreground nil :inherit font-lock-string-face :weight normal))
      (sh-quoted-exec (:foreground nil :inherit font-lock-preprocessor-face))

      ;; Speedbar (built-in)
      (speedbar-button-face (:foreground ,green))
      (speedbar-directory-face (:foreground ,orange))
      (speedbar-file-face (:foreground ,aqua))
      (speedbar-highlight-face (:inherit highlight))
      (speedbar-selected-face (:foreground ,red :underline t))
      (speedbar-separator-face (:foreground ,background :background ,blue :overline ,background))
      (speedbar-tag-face (:foreground ,yellow))
      (vhdl-speedbar-architecture-face (:foreground ,blue))
      (vhdl-speedbar-architecture-selected-face (:foreground ,blue :underline t))
      (vhdl-speedbar-configuration-face (:foreground ,green))
      (vhdl-speedbar-configuration-selected-face (:foreground ,green :underline t))
      (vhdl-speedbar-entity-face (:foreground ,orange))
      (vhdl-speedbar-entity-selected-face (:foreground ,orange :underline t))
      (vhdl-speedbar-instantiation-face (:foreground ,yellow))
      (vhdl-speedbar-instantiation-selected-face (:foreground ,yellow :underline t))
      (vhdl-speedbar-library-face (:foreground ,purple))
      (vhdl-speedbar-package-face (:foreground ,aqua))
      (vhdl-speedbar-package-selected-face (:foreground ,aqua :underline t))
      (vhdl-speedbar-subprogram-face (:foreground ,green))

      ;; tab-bar (built-in)
      (tab-bar (:height 1.2 :foreground ,comment :background ,highlight))
      (tab-bar-tab (:background ,contrast-bg
                                :foreground ,purple
                                :inverse-video nil
                                :box (:line-width 1 :style released-button)))
      (tab-bar-tab-inactive (:inherit tab-bar-tab
                                      :background ,comment
                                      :foreground ,highlight
                                      :inverse-video t))

      ;; tab-line (built-in)
      (tab-line (:foreground ,comment :background ,highlight))
      (tab-line-close-highlight (:foreground ,red))
      (tab-line-tab (:background ,contrast-bg
                                 :foreground ,purple
                                 :inverse-video nil
                                 :box (:line-width 1 :style released-button)))
      (tab-line-tab-inactive (:inherit tab-line-tab
                                       :background ,comment
                                       :foreground ,highlight
                                       :inverse-video t))

      ;; which-function (built-in)
      (which-func (:foreground ,blue :background nil :weight bold))

      ;; whitespace (built-in)
      (whitespace-big-indent (:background ,red :foreground ,contrast-bg))
      (whitespace-empty (:background ,yellow :foreground ,orange))
      (whitespace-hspace (:background ,contrast-bg :foreground ,comment))
      (whitespace-indentation (:background ,contrast-bg :foreground ,comment))
      (whitespace-line (:background ,contrast-bg :foreground ,orange))
      (whitespace-newline (:background ,contrast-bg :foreground ,comment))
      (whitespace-space (:background ,contrast-bg :foreground ,comment))
      (whitespace-space-after-tab (:background ,contrast-bg :foreground ,yellow))
      (whitespace-space-before-tab (:background ,contrast-bg :foreground ,orange))
      (whitespace-tab (:background ,contrast-bg :foreground ,comment))
      (whitespace-trailing (:background ,orange :foreground ,contrast-bg))
      (trailing-whitespace (:inherit whitespace-trailing))

      ;; window-divider (built-in)
      (window-divider (:foreground ,comment))
      (window-divider-first-pixel (:foreground ,contrast-bg))
      (window-divider-last-pixel (:foreground ,contrast-bg))

      ;; ace-window
      (aw-background-face (:foreground ,contrast-bg))
      (aw-leading-char-face (:foreground ,yellow))

      ;; Anzu
      (anzu-mode-line (:foreground ,orange))
      (anzu-mode-line-no-match (:foreground ,red))
      (anzu-replace-highlight (:inherit lazy-highlight))
      (anzu-replace-to (:inherit isearch))
      (anzu-match-1 (:foreground ,yellow ))
      (anzu-match-2 (:foreground ,orange))
      (anzu-match-3 (:foreground ,blue))

      ;; auctex
      (font-latex-bold-face (:foreground ,green :weight bold))
      (font-latex-doctex-documentation-face (:inherit highlight))
      (font-latex-italic-face (:foreground ,green :slant italic))
      (font-latex-math-face (:foreground ,purple))
      (font-latex-script-char-face (:foreground ,red))
      (font-latex-sectioning-0-face (:foreground ,yellow :weight bold :height 1.2))
      (font-latex-sectioning-1-face (:foreground ,yellow :weight bold :height 1.2))
      (font-latex-sectioning-2-face (:foreground ,yellow :weight bold :height 1.2))
      (font-latex-sectioning-3-face (:foreground ,yellow :weight bold :height 1.2))
      (font-latex-sectioning-4-face (:foreground ,yellow :weight bold :height 1.2))
      (font-latex-sectioning-5-face (:foreground ,yellow :weight bold))
      (font-latex-sedate-face (:foreground ,orange))
      (font-latex-slide-title-face (:foreground ,blue :weight bold :height 1.2))
      (font-latex-string-face (:inherit font-lock-string-face))
      (font-latex-verbatim-face (:inherit font-lock-string-face))
      (font-latex-warning-face (:inherit warning))
      ;; TeX-fold
      (TeX-fold-folded-face (:foreground ,purple))
      (TeX-fold-unfolded-face (:inherit highlight))

      ;; avy
      (avy-background-face (:foreground ,contrast-bg))
      (avy-lead-face (:foreground ,background :background ,yellow))
      (avy-lead-face-0 (:foreground ,background :background ,blue))
      (avy-lead-face-1 (:foreground ,background :background ,aqua))
      (avy-lead-face-2 (:foreground ,background :background ,orange))

      ;; bm
      (bm-face (:background ,contrast-bg :foreground ,foreground :extend t))
      (bm-persistent-face (:background ,blue :foreground ,background :extend t))

      ;; bookmark+
      (bmkp-*-mark (:foreground ,background :background ,yellow))
      (bmkp->-mark (:foreground ,yellow))
      (bmkp-D-mark (:foreground ,background :background ,red))
      (bmkp-X-mark (:foreground ,red))
      (bmkp-a-mark (:background ,red))
      (bmkp-bad-bookmark (:foreground ,background :background ,yellow))
      (bmkp-bookmark-file (:foreground ,purple :background ,contrast-bg))
      (bmkp-bookmark-list (:background ,contrast-bg))
      (bmkp-buffer (:foreground ,blue))
      (bmkp-desktop (:foreground ,background :background ,purple))
      (bmkp-file-handler (:background ,red))
      (bmkp-function (:foreground ,green))
      (bmkp-gnus (:foreground ,orange))
      (bmkp-heading (:foreground ,yellow))
      (bmkp-info (:foreground ,aqua))
      (bmkp-light-autonamed (:foreground ,aqua :background ,highlight))
      (bmkp-light-autonamed-region (:foreground ,red :background ,highlight))
      (bmkp-light-fringe-autonamed (:foreground ,contrast-bg :background ,purple))
      (bmkp-light-fringe-non-autonamed (:foreground ,contrast-bg :background ,green))
      (bmkp-light-mark (:foreground ,background :background ,aqua))
      (bmkp-light-non-autonamed (:foreground ,purple :background ,highlight))
      (bmkp-light-non-autonamed-region (:foreground ,orange :background ,highlight))
      (bmkp-local-directory (:foreground ,background :background ,purple))
      (bmkp-local-file-with-region (:foreground ,yellow))
      (bmkp-local-file-without-region (:foreground ,comment))
      (bmkp-man (:foreground ,purple))
      (bmkp-no-jump (:foreground ,comment))
      (bmkp-no-local (:foreground ,yellow))
      (bmkp-non-file (:foreground ,green))
      (bmkp-remote-file (:foreground ,orange))
      (bmkp-sequence (:foreground ,blue))
      (bmkp-su-or-sudo (:foreground ,red))
      (bmkp-t-mark (:foreground ,purple))
      (bmkp-url (:foreground ,blue :underline t))
      (bmkp-variable-list (:foreground ,green))

      ;; CIDER
      (cider-debug-code-overlay-face (:background ,contrast-bg))
      (cider-deprecated-face (:foreground ,contrast-bg :background ,yellow))
      (cider-enlightened-face (:inherit cider-result-overlay-face :box (:color ,orange :line-width -1)))
      (cider-enlightened-local-face (:weight bold :foreground ,orange))
      (cider-error-highlight-face (:underline (:style wave :color ,red) :inherit unspecified))
      (cider-fringe-good-face (:foreground ,green))
      (cider-instrumented-face (:box (:color ,red :line-width -1)))
      (cider-result-overlay-face (:background ,contrast-bg :box (:line-width -1 :color ,yellow)))
      (cider-test-error-face (:foreground ,contrast-bg :background ,orange))
      (cider-test-failure-face (:foreground ,contrast-bg :background ,red))
      (cider-test-success-face (:foreground ,contrast-bg :background ,green))
      (cider-traced-face (:box ,aqua :line-width -1))
      (cider-warning-highlight-face (:underline (:style wave :color ,yellow) :inherit unspecified))

      ;; Circe
      (circe-fool-face (:foreground ,comment))
      (circe-highlight-nick-face (:foreground ,orange))
      (circe-my-message-face (:foreground ,green))
      (circe-prompt-face (:foreground ,blue))
      (circe-server-face (:foreground ,green))
      (circe-topic-diff-new-face (:foreground ,blue))
      (circe-topic-diff-removed-face (:foreground ,red))

      ;; For Brian Carper's extended clojure syntax table
      (clojure-keyword (:foreground ,yellow))
      (clojure-parens (:foreground ,foreground))
      (clojure-braces (:foreground ,green))
      (clojure-brackets (:foreground ,yellow))
      (clojure-double-quote (:foreground ,aqua :background nil))
      (clojure-special (:foreground ,blue))
      (clojure-java-call (:foreground ,purple))

      ;; Clojure errors
      (clojure-test-failure-face (:background nil :inherit flymake-warnline))
      (clojure-test-error-face (:background nil :inherit flymake-errline))
      (clojure-test-success-face (:background nil :foreground nil :underline ,green))

      ;; coffee-mode
      (coffee-mode-class-name (:foreground ,orange :weight bold))
      (coffee-mode-function-param (:foreground ,purple))

      ;; company
      (company-preview (:foreground ,comment :background ,contrast-bg))
      (company-preview-common (:inherit company-preview :foreground ,red))
      (company-preview-search (:inherit company-preview :foreground ,blue))
      (company-tooltip (:background ,contrast-bg))
      (company-tooltip-selection (:foreground ,comment :inverse-video t))
      (company-tooltip-common (:inherit company-tooltip :foreground ,red))
      (company-tooltip-common-selection (:inherit company-tooltip-selection :foreground ,red))
      (company-tooltip-search (:inherit company-tooltip :foreground ,blue))
      (company-tooltip-annotation (:inherit company-tooltip :foreground ,green))
      (company-tooltip-annotation-selection (:inherit company-tooltip-selection :foreground ,green))
      (company-scrollbar-bg (:inherit 'company-tooltip :background ,highlight))
      (company-scrollbar-fg (:background ,contrast-bg))
      (company-echo-common (:inherit company-echo :foreground ,red))

      ;; counsel-css
      (counsel-css-selector-depth-face-1 (:foreground ,yellow))
      (counsel-css-selector-depth-face-2 (:foreground ,orange))
      (counsel-css-selector-depth-face-3 (:foreground ,green))
      (counsel-css-selector-depth-face-4 (:foreground ,aqua))
      (counsel-css-selector-depth-face-5 (:foreground ,blue))
      (counsel-css-selector-depth-face-6 (:foreground ,purple))

      ;; csv-mode
      (csv-separator-face (:foreground ,orange))

      ;; debbugs
      (debbugs-gnu-done (:foreground ,comment))
      (debbugs-gnu-forwarded (:foreground ,yellow))
      (debbugs-gnu-handled (:foreground ,green))
      (debbugs-gnu-new (:foreground ,red))
      (debbugs-gnu-pending (:foreground ,blue))
      (debbugs-gnu-stale-1 (:foreground ,orange))
      (debbugs-gnu-stale-2 (:foreground ,green))
      (debbugs-gnu-stale-3 (:foreground ,purple))
      (debbugs-gnu-stale-4 (:foreground ,aqua))
      (debbugs-gnu-stale-5 (:foreground ,foreground))
      (debbugs-gnu-tagged (:foreground ,red))

      ;; define-it
      (define-it-headline-face (:foreground ,blue :bold t))
      (define-it-pop-tip-color (:foreground ,comment :background ,contrast-bg))
      (define-it-sense-number-face (:foreground ,purple :bold t))
      (define-it-type-face (:foreground ,aqua))
      (define-it-var-face (:foreground ,orange :bold t))

      ;; diff-hl
      (diff-hl-insert (:foreground ,background :background ,green))
      (diff-hl-change (:foreground ,background :background ,blue))
      (diff-hl-delete (:foreground ,background :background ,red))

      ;; dired-async
      (dired-async-failures (:inherit error))
      (dired-async-message (:inherit success))
      (dired-async-mode-message (:inherit warning))

      ;; diredfl
      (diredfl-compressed-file-suffix (:foreground ,blue))
      (diredfl-compressed-file-name (:foreground ,blue))
      (diredfl-deletion (:inherit error :inverse-video t))
      (diredfl-deletion-file-name (:inherit error))
      (diredfl-date-time (:foreground ,blue))
      (diredfl-dir-heading (:foreground ,green :weight bold))
      (diredfl-dir-name (:foreground ,aqua))
      (diredfl-dir-priv (:foreground ,aqua :background nil))
      (diredfl-exec-priv (:foreground ,orange :background nil))
      (diredfl-executable-tag (:foreground ,red :background nil))
      (diredfl-file-name (:foreground ,yellow))
      (diredfl-file-suffix (:foreground ,green))
      (diredfl-flag-mark (:foreground ,green :inverse-video t))
      (diredfl-flag-mark-line (:background nil :inherit highlight))
      (diredfl-ignored-file-name (:foreground ,comment))
      (diredfl-link-priv (:background nil :foreground ,purple))
      (diredfl-mode-line-flagged (:foreground ,red))
      (diredfl-mode-line-marked (:foreground ,green))
      (diredfl-no-priv (:background nil))
      (diredfl-number (:foreground ,yellow))
      (diredfl-other-priv (:background nil :foreground ,purple))
      (diredfl-rare-priv (:foreground ,red :background nil))
      (diredfl-read-priv (:foreground ,green :background nil))
      (diredfl-symlink (:foreground ,purple))
      (diredfl-write-priv (:foreground ,yellow :background nil))

      ;; dired+
      (diredp-compressed-file-suffix (:inherit diredfl-compressed-file-suffix))
      (diredp-compressed-file-name (:inherit diredfl-compressed-file-name))
      (diredp-deletion (:inherit diredfl-deletion))
      (diredp-deletion-file-name (:inherit diredfl-deletion-file-name))
      (diredp-date-time (:inherit diredfl-date-time))
      (diredp-dir-heading (:inherit diredfl-dir-heading))
      (diredp-dir-name (:inherit diredfl-dir-name))
      (diredp-dir-priv (:inherit diredfl-dir-priv))
      (diredp-exec-priv (:inherit diredfl-exec-priv))
      (diredp-executable-tag (:inherit diredfl-executable-tag))
      (diredp-file-name (:inherit diredfl-file-name))
      (diredp-file-suffix (:inherit diredfl-file-suffix))
      (diredp-flag-mark (:inherit diredfl-flag-mark))
      (diredp-flag-mark-line (:inherit diredfl-flag-mark-line))
      (diredp-ignored-file-name (:inherit diredfl-ignored-file-name))
      (diredp-link-priv (:inherit diredfl-link-priv))
      (diredp-mode-line-flagged (:inherit diredfl-mode-line-flagged))
      (diredp-mode-line-marked (:inherit diredfl-mode-line-marked))
      (diredp-no-priv (:inherit diredfl-no-priv))
      (diredp-number (:inherit diredfl-number))
      (diredp-other-priv (:inherit diredfl-other-priv))
      (diredp-rare-priv (:inherit diredfl-rare-priv))
      (diredp-read-priv (:inherit diredfl-read-priv))
      (diredp-symlink (:inherit diredfl-symlink))
      (diredp-write-priv (:inherit diredfl-write-priv))

      ;; dired-narrow
      (dired-narrow-blink (:foreground ,background :background ,yellow))

      ;; e2wm
      (e2wm:face-history-list-normal (:foreground ,foreground :background ,background))
      (e2wm:face-history-list-select1 (:foreground ,aqua :background ,background))
      (e2wm:face-history-list-select2 (:foreground ,yellow :background ,background))

      ;; EDTS errors
      (edts-face-warning-line (:background nil :inherit flymake-warnline))
      (edts-face-warning-mode-line (:background nil :foreground ,orange :weight bold))
      (edts-face-error-line (:background nil :inherit flymake-errline))
      (edts-face-error-mode-line (:background nil :foreground ,red :weight bold))

      ;; Elfeed
      (elfeed-log-debug-level-face (:foreground ,comment))
      (elfeed-log-error-level-face (:inherit error))
      (elfeed-log-info-level-face (:inherit success))
      (elfeed-log-warn-level-face (:inherit warning))
      (elfeed-search-date-face (:foreground ,blue))
      (elfeed-search-feed-face (:foreground ,yellow))
      (elfeed-search-tag-face (:foreground ,comment))
      (elfeed-search-title-face (:foreground ,comment))
      (elfeed-search-unread-count-face (:foreground ,yellow))
      (elfeed-search-unread-title-face (:foreground ,foreground :weight bold))

      ;; EMMS
      (emms-browser-artist-face (:foreground ,purple))
      (emms-browser-album-face (:foreground ,aqua))
      (emms-browser-track-face (:foreground ,yellow))
      (emms-browser-year/genre-face (:foreground ,blue))
      (emms-playlist-selected-face (:inverse-video t))
      (emms-playlist-track-face (:foreground ,yellow))

      ;; eyebrowse
      (eyebrowse-mode-line-active (:foreground ,orange :weight bold))
      (eyebrowse-mode-line-delimiters (:foreground ,purple))
      (eyebrowse-mode-line-inactive (:foreground ,comment))
      (eyebrowse-mode-line-separator (:foreground ,purple))

      ;; flx-ido
      (flx-highlight-face (:inherit nil :foreground ,yellow :weight bold :underline nil))

      ;; fold-this
      (fold-this-overlay (:foreground ,green))

      ;; git-gutter (git-gutter-fringe inherits from git-gutter)
      (git-gutter:separator (:foreground ,aqua :weight bold))
      (git-gutter:modified (:foreground ,purple :weight bold))
      (git-gutter:added (:foreground ,green :weight bold))
      (git-gutter:deleted (:foreground ,red :weight bold))
      (git-gutter:unchanged (:background ,yellow))

      ;; git-gutter+ (git-gutter-fringe+ inherits from git-gutter+)
      (git-gutter+-separator (:foreground ,aqua :weight bold))
      (git-gutter+-modified (:foreground ,purple :weight bold))
      (git-gutter+-added (:foreground ,green :weight bold))
      (git-gutter+-deleted (:foreground ,red :weight bold))
      (git-gutter+-unchanged (:background ,yellow))

      ;; git-timemachine
      (git-timemachine-minibuffer-author-face (:foreground ,purple))
      (git-timemachine-minibuffer-detail-face (:foreground ,green))

      ;; guide-key
      (guide-key/prefix-command-face (:foreground ,blue))
      (guide-key/highlight-command-face (:foreground ,green))
      (guide-key/key-face (:foreground ,comment))

      ;; helm
      (helm-M-x-key (:foreground ,orange :underline t))
      (helm-bookmark-addressbook (:foreground ,red))
      (helm-bookmark-file (:foreground ,aqua))
      (helm-bookmark-file-not-found (:foreground ,background))
      (helm-bookmark-gnus (:foreground ,purple))
      (helm-bookmark-info (:foreground ,green))
      (helm-bookmark-man (:foreground ,orange))
      (helm-bookmark-w3m (:foreground ,yellow))
      (helm-buffer-archive (:foreground ,yellow))
      (helm-buffer-directory (:foreground ,blue))
      (helm-buffer-not-saved (:foreground ,orange))
      (helm-buffer-process (:foreground ,aqua))
      (helm-buffer-saved-out (:inherit warning))
      (helm-buffer-size (:foreground ,yellow))
      (helm-candidate-number (:foreground ,green))
      (helm-comint-prompts-buffer-name (:foreground ,green))
      (helm-comint-prompts-promptidx (:foreground ,aqua))
      (helm-delete-async-message (:foreground ,yellow))
      (helm-eshell-prompts-buffer-name (:foreground ,green))
      (helm-eshell-prompts-promptidx (:foreground ,aqua))
      (helm-etags-file (:foreground ,yellow :underline t))
      (helm-ff-denied (:foreground ,background :background ,red))
      (helm-ff-directory (:foreground ,aqua))
      (helm-ff-dotted-directory (:foreground ,comment))
      (helm-ff-dotted-symlink-directory (:foreground ,comment))
      (helm-ff-executable (:foreground ,green))
      (helm-ff-invalid-symlink (:foreground ,background :background ,red))
      (helm-ff-pipe (:foreground ,yellow :background ,background))
      (helm-ff-prefix (:foreground ,background :background ,yellow))
      (helm-ff-socket (:foreground ,purple))
      (helm-ff-suid (:foreground ,background :background ,red))
      (helm-grep-file (:foreground ,purple :underline t))
      (helm-grep-finish (:foreground ,green))
      (helm-grep-lineno (:foreground ,orange))
      (helm-grep-match (:inherit match))
      (helm-header-line-left-margin (:foreground ,background :background ,yellow))
      (helm-lisp-completion-info (:foreground ,red))
      (helm-lisp-show-completion (:background ,contrast-bg))
      (helm-locate-finish (:foreground ,green))
      (helm-match (:inherit match))
      (helm-moccur-buffer (:foreground ,aqua :underline t))
      (helm-mode-prefix (:foreground ,background :background ,red))
      (helm-prefarg (:foreground ,red))
      (helm-resume-need-update (:background ,red))
      (helm-selection (:inherit highlight :extend t))
      (helm-selection-line (:inherit highlight :extend t))
      (helm-separator (:foreground ,purple))
      (helm-source-header (:weight bold :foreground ,orange))
      (helm-time-zone-current (:foreground ,green))
      (helm-time-zone-home (:foreground ,red))
      (helm-ucs-char (:foreground ,yellow))
      (helm-visible-mark (:foreground ,blue))

      ;; helm-ls-git
      (helm-ls-git-added-copied-face (:foreground ,green))
      (helm-ls-git-added-modified-face (:foreground ,yellow))
      (helm-ls-git-conflict-face (:foreground ,red))
      (helm-ls-git-deleted-and-staged-face (:foreground ,purple))
      (helm-ls-git-deleted-not-staged-face (:foreground ,comment))
      (helm-ls-git-modified-and-staged-face (:foreground ,green))
      (helm-ls-git-modified-not-staged-face (:foreground ,yellow))
      (helm-ls-git-renamed-modified-face (:foreground ,blue))
      (helm-ls-git-untracked-face (:foreground ,aqua))

      ;; helm-rg
      (helm-rg-active-arg-face (:foreground ,green))
      (helm-rg-base-rg-cmd-face (:foreground ,foreground))
      (helm-rg-colon-separator-ripgrep-output-face (:foreground ,foreground))
      (helm-rg-directory-cmd-face (:foreground ,orange))
      (helm-rg-directory-header-face (:foreground ,foreground :extend t))
      (helm-rg-error-message (:foreground ,red))
      (helm-rg-extra-arg-face (:foreground ,yellow))
      (helm-rg-file-match-face (:foreground ,aqua :underline t))
      (helm-rg-inactive-arg-face (:foreground ,comment))
      (helm-rg-line-number-match-face (:foreground ,orange :underline t))
      (helm-rg-match-text-face (:foreground ,background :background ,blue))
      (helm-rg-preview-line-highlight (:foreground ,green))
      (helm-rg-title-face (:foreground ,purple))

      ;; helm-switch-shell
      (helm-switch-shell-new-shell-face (:foreground ,background :background ,purple))

      ;; hl-sexp
      (hl-sexp-face (:background ,contrast-bg))

      ;; highlight-80+
      (highlight-80+ (:background ,contrast-bg))

      ;; highlight-symbol
      (highlight-symbol-face (:inherit highlight))

      ;; Hydra
      (hydra-face-blue (:foreground ,blue))
      (hydra-face-teal (:foreground ,aqua))
      (hydra-face-pink (:foreground ,purple))
      (hydra-face-red (:foreground ,red))
      ;; this is unfortunate, but we have no color close to amaranth in
      ;; our palette
      (hydra-face-amaranth (:foreground ,orange))

      ;; info+
      (info-command-ref-item (:foreground ,green :background ,highlight))
      (info-constant-ref-item (:foreground ,purple :background ,highlight))
      (info-double-quoted-name (:inherit font-lock-comment-face))
      (info-file (:foreground ,yellow :background ,highlight))
      (info-function-ref-item (:inherit font-lock-function-name-face :background ,highlight))
      (info-macro-ref-item (:foreground ,orange :background ,highlight))
      (info-menu (:foreground ,green))
      (info-quoted-name (:inherit font-lock-constant-face))
      (info-reference-item (:background ,highlight))
      (info-single-quote (:inherit font-lock-keyword-face))
      (info-special-form-ref-item (:foreground ,orange :background ,highlight))
      (info-string (:inherit font-lock-string-face))
      (info-syntax-class-item (:foreground ,blue :background ,highlight))
      (info-user-option-ref-item (:foreground ,red :background ,highlight))
      (info-variable-ref-item (:inherit font-lock-variable-name-face :background ,highlight))
      (info-xref-bookmarked (:foreground ,purple))

      ;; Ivy
      (ivy-action (:foreground ,purple))
      (ivy-confirm-face (:foreground ,green))
      (ivy-current-match (:inherit isearch))
      (ivy-cursor (:background ,contrast-bg))
      (ivy-match-required-face (:foreground ,red :background ,background))
      (ivy-remote (:foreground ,orange))
      (ivy-subdir (:foreground ,purple))
      (ivy-virtual (:foreground ,comment))
      (ivy-minibuffer-match-face-1 (:foreground ,aqua))
      (ivy-minibuffer-match-face-2 (:foreground ,yellow))
      (ivy-minibuffer-match-face-3 (:foreground ,blue))
      (ivy-minibuffer-match-face-4 (:foreground ,orange))

      ;; Jabber
      (jabber-chat-prompt-local (:foreground ,yellow))
      (jabber-chat-prompt-foreign (:foreground ,orange))
      (jabber-chat-prompt-system (:foreground ,yellow :weight bold))
      (jabber-chat-text-local (:foreground ,yellow))
      (jabber-chat-text-foreign (:foreground ,orange))
      (jabber-chat-text-error (:foreground ,red))

      (jabber-roster-user-online (:foreground ,green))
      (jabber-roster-user-xa :foreground ,comment)
      (jabber-roster-user-dnd :foreground ,yellow)
      (jabber-roster-user-away (:foreground ,orange))
      (jabber-roster-user-chatty (:foreground ,purple))
      (jabber-roster-user-error (:foreground ,red))
      (jabber-roster-user-offline (:foreground ,comment))

      (jabber-rare-time-face (:foreground ,comment))
      (jabber-activity-face (:foreground ,purple))
      (jabber-activity-personal-face (:foreground ,aqua))

      ;; Cperl
      (cperl-array-face (:foreground ,blue :weight bold))
      (cperl-hash-face (:foreground ,red :slant italic))
      (cperl-nonoverridable-face (:foreground ,purple))

      ;; js2-mode
      (js2-warning (:underline ,orange))
      (js2-error (:foreground nil :underline ,red))
      (js2-external-variable (:foreground ,purple))
      (js2-function-param (:foreground ,blue))
      (js2-instance-member (:foreground ,blue))
      (js2-private-function-call (:foreground ,red))
      ;; js2-mode additional attributes for better syntax highlight in javascript
      (js2-jsdoc-tag (:foreground ,aqua))
      (js2-jsdoc-type (:foreground ,orange))
      (js2-jsdoc-value (:foreground ,orange))
      (js2-function-call (:foreground ,green))
      (js2-object-property (:foreground ,orange))
      (js2-private-member (:foreground ,purple))
      (js2-jsdoc-html-tag-name (:foreground ,orange))
      (js2-jsdoc-html-tag-delimiter (:foreground ,orange))

      ;; js3-mode
      (js3-warning-face (:underline ,orange))
      (js3-error-face (:foreground nil :underline ,red))
      (js3-external-variable-face (:foreground ,purple))
      (js3-function-param-face (:foreground ,blue))
      (js3-jsdoc-tag-face (:foreground ,orange))
      (js3-jsdoc-type-face (:foreground ,aqua))
      (js3-jsdoc-value-face (:foreground ,yellow))
      (js3-jsdoc-html-tag-name-face (:foreground ,blue))
      (js3-jsdoc-html-tag-delimiter-face (:foreground ,green))
      (js3-instance-member-face (:foreground ,blue))
      (js3-private-function-call-face (:foreground ,red))

      ;; Ledger-mode
      (ledger-font-comment-face (:inherit font-lock-comment-face))
      (ledger-font-occur-narrowed-face (:inherit font-lock-comment-face :invisible t))
      (ledger-font-occur-xact-face (:inherit highlight))
      (ledger-font-payee-cleared-face (:foreground ,green))
      (ledger-font-payee-uncleared-face (:foreground ,aqua))
      (ledger-font-posting-date-face (:foreground ,orange))
      (ledger-font-posting-amount-face (:foreground ,foreground))
      (ledger-font-posting-account-cleared-face (:foreground ,blue))
      (ledger-font-posting-account-face (:foreground ,purple))
      (ledger-font-posting-account-pending-face (:foreground ,yellow))
      (ledger-font-xact-highlight-face (:inherit highlight))
      (ledger-occur-narrowed-face (:inherit font-lock-comment-face :invisible t))
      (ledger-occur-xact-face (:inherit highlight))

      ;; Lispy
      (lispy-command-name-face (:inherit font-lock-function-name-face :background ,highlight))
      (lispy-cursor-face (:foreground ,background :background ,foreground))
      (lispy-face-hint (:foreground ,green :background ,contrast-bg))

      ;; macrostep
      (macrostep-expansion-highlight-face (:inherit highlight :foreground nil))

      ;; Magit
      (magit-bisect-bad (:foreground ,red))
      (magit-bisect-good (:foreground ,green))
      (magit-bisect-skip (:foreground ,orange))
      (magit-blame-date (:foreground ,red))
      (magit-blame-heading (:foreground ,orange :background ,highlight :extend t))
      (magit-branch-current (:foreground ,blue))
      (magit-branch-local (:foreground ,aqua))
      (magit-branch-remote (:foreground ,green))
      (magit-cherry-equivalent (:foreground ,purple))
      (magit-cherry-unmatched (:foreground ,aqua))
      (magit-diff-added (:foreground ,green :extend t))
      (magit-diff-added-highlight (:foreground ,green :background ,highlight :extend t))
      (magit-diff-base (:foreground ,background :background ,orange :extend t))
      (magit-diff-base-highlight (:foreground ,orange :background ,highlight :extend t))
      (magit-diff-context (:foreground ,comment :extend t))
      (magit-diff-context-highlight (:foreground ,comment :background ,highlight :extend t))
      (magit-diff-file-heading (:foreground ,foreground :extend t))
      (magit-diff-file-heading-highlight (:background ,contrast-bg :weight bold :extend t))
      (magit-diff-file-heading-selection (:foreground ,orange :background ,highlight :extend t))
      (magit-diff-hunk-heading (:foreground ,foreground :background ,contrast-bg :extend t))
      (magit-diff-hunk-heading-highlight (:background ,contrast-bg :extend t))
      (magit-diff-lines-heading (:foreground ,yellow :background ,red :extend t))
      (magit-diff-removed (:foreground ,orange :extend t))
      (magit-diff-removed-highlight (:foreground ,orange :background ,highlight :extend t))
      (magit-diffstat-added (:foreground ,green))
      (magit-diffstat-removed (:foreground ,orange))
      (magit-dimmed (:foreground ,comment))
      (magit-filename (:foreground ,purple))
      (magit-hash (:foreground ,comment))
      (magit-header-line (:inherit nil :weight bold))
      (magit-log-author (:foreground ,orange))
      (magit-log-date (:foreground ,blue))
      (magit-log-graph (:foreground ,comment))
      (magit-mode-line-process (:foreground ,orange))
      (magit-mode-line-process-error (:foreground ,red))
      (magit-process-ng (:inherit error))
      (magit-process-ok (:inherit success))
      (magit-reflog-amend (:foreground ,purple))
      (magit-reflog-checkout (:foreground ,blue))
      (magit-reflog-cherry-pick (:foreground ,green))
      (magit-reflog-commit (:foreground ,green))
      (magit-reflog-merge (:foreground ,green))
      (magit-reflog-other (:foreground ,aqua))
      (magit-reflog-rebase (:foreground ,purple))
      (magit-reflog-remote (:foreground ,aqua))
      (magit-reflog-reset (:inherit error))
      (magit-refname (:foreground ,comment))
      (magit-section-heading (:foreground ,yellow :weight bold :extend t))
      (magit-section-heading-selection (:foreground ,orange :weight bold :extend t))
      (magit-section-highlight (:background ,highlight :weight bold :extend t))
      (magit-sequence-drop (:foreground ,red))
      (magit-sequence-head (:foreground ,blue))
      (magit-sequence-part (:foreground ,orange))
      (magit-sequence-stop (:foreground ,green))
      (magit-signature-bad (:inherit error))
      (magit-signature-error (:inherit error))
      (magit-signature-expired (:foreground ,orange))
      (magit-signature-good (:inherit success))
      (magit-signature-revoked (:foreground ,purple))
      (magit-signature-untrusted (:foreground ,aqua))
      (magit-tag (:foreground ,yellow))

      ;; mark-multiple
      (mm/master-face (:inherit region :foreground nil :background nil))
      (mm/mirror-face (:inherit region :foreground nil :background nil))

      ;; markdown
      (markdown-url-face (:inherit link))
      (markdown-link-face (:foreground ,blue :underline t))
      (markdown-code-face (:inherit fixed-pitch :background ,background :foreground ,purple))
      (markdown-inline-code-face (:inherit markdown-code-face))

      ;; markup
      (markup-code-face (:inherit fixed-pitch :background ,background :foreground ,purple))
      (markup-complex-replacement-face (:background ,background))
      (markup-error-face (:foreground ,red :background ,background :weight bold))
      (markup-gen-face (:foreground ,blue))
      (markup-list-face (:foreground nil :background nil))
      (markup-meta-face (:foreground ,comment))
      (markup-meta-hide-face (:foreground ,comment))
      (markup-reference-face (:inherit link))
      (markup-secondary-text-face (:foreground ,comment))
      (markup-title-0-face (:foreground ,blue :weight bold :height 1.4))
      (markup-title-1-face (:foreground ,purple :weight bold :height 1.2))
      (markup-title-2-face (:foreground ,orange :weight bold))
      (markup-title-3-face (:foreground ,green :weight bold))
      (markup-title-4-face (:foreground ,blue :weight bold))
      (markup-title-5-face (:foreground ,purple :weight bold))
      (markup-typewriter-face (:inherit shadow))
      (markup-verbatim-face (:inherit shadow :background ,background))

      ;; mu4e
      (mu4e-header-highlight-face (:underline nil :inherit region))
      (mu4e-header-marks-face (:underline nil :foreground ,yellow))
      (mu4e-flagged-face (:foreground ,orange :inherit nil))
      (mu4e-replied-face (:foreground ,blue :inherit nil))
      (mu4e-unread-face (:foreground ,yellow :inherit nil))
      (mu4e-cited-1-face (:foreground ,blue :slant normal))
      (mu4e-cited-2-face (:foreground ,purple :slant normal))
      (mu4e-cited-3-face (:foreground ,aqua :slant normal))
      (mu4e-cited-4-face (:foreground ,yellow :slant normal))
      (mu4e-cited-5-face (:foreground ,orange :slant normal))
      (mu4e-cited-6-face (:foreground ,blue :slant normal))
      (mu4e-cited-7-face (:foreground ,purple :slant normal))
      (mu4e-ok-face (:foreground ,green))
      (mu4e-view-contact-face (:inherit nil :foreground ,yellow))
      (mu4e-view-link-face (:inherit link :foreground ,blue))
      (mu4e-view-url-number-face (:inherit nil :foreground ,aqua))
      (mu4e-view-attach-number-face (:inherit nil :foreground ,orange))
      (mu4e-highlight-face (:inherit highlight))
      (mu4e-title-face (:inherit nil :foreground ,green))

      ;; MMM-mode
      (mmm-code-submode-face (:background ,contrast-bg))
      (mmm-comment-submode-face (:inherit font-lock-comment-face))
      (mmm-output-submode-face (:background ,contrast-bg))

      ;; neotree
      (neo-banner-face (:foreground ,blue :weight bold))
      (neo-button-face (:underline t))
      (neo-dir-link-face (:foreground ,orange))
      (neo-expand-btn-face (:foreground ,comment))
      (neo-file-link-face (:foreground ,foreground))
      (neo-header-face (:foreground ,foreground :background ,highlight))
      (neo-root-dir-face (:foreground ,blue :weight bold))
      (neo-vc-added-face (:foreground ,green))
      (neo-vc-conflict-face (:foreground ,red))
      (neo-vc-default-face (:foreground ,foreground))
      (neo-vc-edited-face (:foreground ,purple))
      (neo-vc-ignored-face (:foreground ,contrast-bg))
      (neo-vc-missing-face (:foreground ,red))
      (neo-vc-needs-merge-face (:foreground ,red))
      (neo-vc-unlocked-changes-face (:foreground ,blue :slant italic))
      (neo-vc-user-face (:foreground ,red :slant italic))

      ;; nswbuff
      (nswbuff-current-buffer-face (:foreground ,blue :weight bold :underline nil))
      (nswbuff-default-face (:foreground ,foreground :background ,background))
      (nswbuff-separator-face (:foreground ,comment))
      (nswbuff-special-buffers-face (:foreground ,purple :bold nil :underline nil))

      ;; Parenthesis matching (mic-paren)
      (paren-face-match (:foreground nil :background nil :inherit show-paren-match))
      (paren-face-mismatch (:foreground nil :background nil :inherit show-paren-mismatch))
      (paren-face-no-match (:foreground nil :background nil :inherit show-paren-mismatch))

      ;; Parenthesis dimming (parenface)
      (paren-face (:foreground ,comment :background nil))

      ;; Powerline
      (powerline-active1 (:foreground ,foreground :background ,highlight))
      (powerline-active2 (:foreground ,foreground :background ,contrast-bg))

      ;; Powerline-evil
      (powerline-evil-base-face (:inherit mode-line :foreground ,background))
      (powerline-evil-emacs-face (:inherit powerline-evil-base-face :background ,purple))
      (powerline-evil-insert-face (:inherit powerline-evil-base-face :background ,blue))
      (powerline-evil-motion-face (:inherit powerline-evil-base-face :background ,orange))
      (powerline-evil-normal-face (:inherit powerline-evil-base-face :background ,green))
      (powerline-evil-operator-face (:inherit powerline-evil-base-face :background ,aqua))
      (powerline-evil-replace-face (:inherit powerline-evil-base-face :background ,red))
      (powerline-evil-visual-face (:inherit powerline-evil-base-face :background ,yellow))

      (pulse-highlight-start-face (:background ,red))

      ;; Python-specific overrides
      (py-builtins-face (:foreground ,orange :weight normal))

      ;; Rainbow-delimiters
      (rainbow-delimiters-depth-1-face (:foreground ,foreground))
      (rainbow-delimiters-depth-2-face (:foreground ,aqua))
      (rainbow-delimiters-depth-3-face (:foreground ,yellow))
      (rainbow-delimiters-depth-4-face (:foreground ,green))
      (rainbow-delimiters-depth-5-face (:foreground ,blue))
      (rainbow-delimiters-depth-6-face (:foreground ,foreground))
      (rainbow-delimiters-depth-7-face (:foreground ,aqua))
      (rainbow-delimiters-depth-8-face (:foreground ,yellow))
      (rainbow-delimiters-depth-9-face (:foreground ,green))
      (rainbow-delimiters-unmatched-face (:foreground ,red))

      ;; regex-tool
      (regex-tool-matched-face (:foreground nil :background nil :inherit match))

      ;; RHTML
      (erb-delim-face (:background ,contrast-bg))
      (erb-exec-face (:background ,contrast-bg :weight bold))
      (erb-exec-delim-face (:background ,contrast-bg))
      (erb-out-face (:background ,contrast-bg :weight bold))
      (erb-out-delim-face (:background ,contrast-bg))
      (erb-comment-face (:background ,contrast-bg :weight bold :slant italic))
      (erb-comment-delim-face (:background ,contrast-bg))

      ;; rpm-spec-mode
      (rpm-spec-dir-face (:foreground ,green))
      (rpm-spec-doc-face (:foreground ,green))
      (rpm-spec-ghost-face (:foreground ,red))
      (rpm-spec-macro-face (:foreground ,yellow))
      (rpm-spec-obsolete-tag-face (:foreground ,red))
      (rpm-spec-package-face (:foreground ,red))
      (rpm-spec-section-face (:foreground ,yellow))
      (rpm-spec-tag-face (:foreground ,blue))
      (rpm-spec-var-face (:foreground ,red))

      ;; SLIME
      (slime-highlight-edits-face (:weight bold))
      (slime-repl-input-face (:weight normal :underline nil))
      (slime-repl-prompt-face (:underline nil :weight bold :foreground ,purple))
      (slime-repl-result-face (:foreground ,green))
      (slime-repl-output-face (:foreground ,blue :background ,background))
      (slime-repl-inputed-output-face (:foreground ,comment))

      ;; SLY
      (sly-error-face (:underline (:style wave :color ,red)))
      (sly-mrepl-output-face (:foreground ,purple :background ,background))
      (sly-note-face (:underline (:style wave :color ,green)))
      (sly-style-warning-face (:underline (:style wave :color ,yellow)))
      (sly-warning-face (:underline (:style wave :color ,orange)))
      (sly-stickers-armed-face (:foreground ,background :background ,blue))
      (sly-stickers-empty-face (:foreground ,background :background ,comment))
      (sly-stickers-placed-face (:foreground ,background :background ,foreground))
      (sly-stickers-recordings-face (:foreground ,background :background ,green))

      ;; Smartparens paren matching
      (sp-show-pair-match-face (:foreground nil :background nil :inherit show-paren-match))
      (sp-show-pair-mismatch-face (:foreground nil :background nil :inherit show-paren-mismatch))

      ;; stripe-buffer
      (stripe-highlight (:inherit highlight))

      ;; swiper
      (swiper-line-face (:underline t))

      ;; sx
      (sx-question-mode-content-face (:background ,highlight))
      (sx-question-list-answers (:inherit sx-question-list-parent :foreground ,green))
      (sx-question-mode-accepted (:inherit sx-question-mode-title :foreground ,green))
      (sx-question-mode-kbd-tag (:weight semi-bold :box (:line-width 3 :style released-button :color ,contrast-bg)))

      ;; symbol-overlay
      (symbol-overlay-default-face (:inherit highlight :underline t))

      ;; syslog-mode
      (syslog-debug (:weight bold :foreground ,green))
      (syslog-error (:weight bold :foreground ,red))
      (syslog-hide (:foregound ,comment))
      (syslog-info (:weight bold :foreground ,blue))
      (syslog-su (:weight bold :foreground ,purple))
      (syslog-warn (:weight bold :foreground ,orange))

      ;; transient
      (transient-enabled-suffix (:foreground ,low-contrast-bg :background ,green :weight bold))
      (transient-disabled-suffix (:foreground ,foreground :background ,red :weight bold))

      ;; twittering-mode
      (twittering-username-face (:inherit erc-pal-face))
      (twittering-uri-face (:foreground ,blue :inherit link))
      (twittering-timeline-header-face (:foreground ,green :weight bold))
      (twittering-timeline-footer-face (:inherit twittering-timeline-header-face))

      ;; undo-tree
      (undo-tree-visualizer-default-face (:foreground ,foreground))
      (undo-tree-visualizer-current-face (:foreground ,green :weight bold))
      (undo-tree-visualizer-active-branch-face (:foreground ,red))
      (undo-tree-visualizer-register-face (:foreground ,yellow))

      ;; visual-regexp
      (vr/match-0 (:foreground ,yellow :background ,background :inverse-video t))
      (vr/match-1 (:foreground ,aqua :background ,background :inverse-video t))
      (vr/group-0 (:foreground ,purple :background ,background :inverse-video t))
      (vr/group-1 (:foreground ,green :background ,background :inverse-video t))
      (vr/group-2 (:foreground ,orange :background ,background :inverse-video t))

      ;; vterm
      (vterm-color-black (:background ,background :foreground ,background))
      (vterm-color-blue (:background ,blue :foreground ,blue))
      (vterm-color-cyan (:background ,aqua :foreground ,aqua))
      (vterm-color-default (:foreground nil :background nil :inherit default))
      (vterm-color-green (:background ,green :foreground ,green))
      (vterm-color-magenta (:background ,purple :foreground ,purple))
      (vterm-color-red (:background ,red :foreground ,red))
      (vterm-color-white (:background ,foreground :foreground ,foreground))
      (vterm-color-yellow (:background ,yellow :foreground ,yellow))

      ;; web-mode
      (web-mode-doctype-face (:inherit font-lock-string-face))
      (web-mode-html-attr-equal-face (:foreground nil :background nil :inherit default))
      (web-mode-html-attr-name-face (:inherit font-lock-variable-name-face))
      (web-mode-html-tag-face (:inherit font-lock-function-name-face))
      (web-mode-symbol-face (:inherit font-lock-constant-face))

      ;; weechat
      (weechat-highlight-face (:foreground ,orange))
      (weechat-nick-self-face (:foreground ,green))
      (weechat-time-face (:foreground ,aqua))

      ;; wgrep
      (wgrep-delete-face (:foreground ,red))
      (wgrep-done-face (:foreground ,blue))
      (wgrep-face (:foreground ,green :background ,contrast-bg))
      (wgrep-file-face (:foreground ,comment :background ,contrast-bg))
      (wgrep-reject-face (:foreground ,orange :weight bold))

      ;; xcscope
      (cscope-file-face (:foreground ,green))
      (cscope-function-face (:foreground ,blue))
      (cscope-line-number-face (:foreground ,red))
      (cscope-separator-face (:bold t :overline t :underline t :foreground ,purple))

      ;; ztree
      (ztreep-arrow-face (:foreground ,highlight))
      (ztreep-diff-header-face (:foreground ,yellow :weight bold))
      (ztreep-diff-header-small-face (:foregorund ,yellow))
      (ztreep-diff-model-add-face (:foreground ,green))
      (ztreep-diff-model-diff-face (:foreground ,red))
      (ztreep-diff-model-ignored-face (:foreground ,orange))
      (ztreep-diff-model-normal-face (:foreground ,foreground))
      (ztreep-expand-sign-face (:foreground ,foreground))
      (ztreep-header-face (:forground ,yellow :weight bold))
      (ztreep-leaf-face (:foreground ,aqua))
      (ztreep-node-face (:foreground ,foreground))
      ))))

(defmacro color-theme-sanityinc-tomorrow--frame-parameter-specs ()
  "Return a backquote which defines a list of frame parameter specs.

These are required by color-theme's `color-theme-install', but
not by the new `deftheme' mechanism. It expects to be evaluated
in a scope in which the various color names to which it refers
are bound."
  (quote
   `(((background-color . ,background)
      (background-mode . light)
      (border-color . ,foreground)
      (cursor-color . ,red)
      (foreground-color . ,foreground)
      (mouse-color . ,aqua)))))

(defun color-theme-sanityinc-tomorrow--theme-name (mode)
  (intern (format "sanityinc-tomorrow-%s" (symbol-name mode))))

(defmacro color-theme-sanityinc-tomorrow--define-theme (mode)
  "Define a theme for the tomorrow variant `MODE'."
  (let ((name (color-theme-sanityinc-tomorrow--theme-name mode))
        (doc (format "A version of Chris Kempson's 'Tomorrow' theme (%s version)" mode)))
    `(progn
       (deftheme ,name ,doc)
       (put ',name 'theme-immediate t)
       (color-theme-sanityinc-tomorrow--with-colors
        ',mode
        (apply 'custom-theme-set-faces ',name
               (color-theme-sanityinc-tomorrow--face-specs))
        (custom-theme-set-variables
         ',name
         `(frame-background-mode ',background-mode)
         `(beacon-color ,red)
         `(fci-rule-color ,contrast-bg)
         `(vc-annotate-color-map
           '((20  . ,red)
             (40  . ,orange)
             (60  . ,yellow)
             (80  . ,green)
             (100 . ,aqua)
             (120 . ,blue)
             (140 . ,purple)
             (160 . ,red)
             (180 . ,orange)
             (200 . ,yellow)
             (220 . ,green)
             (240 . ,aqua)
             (260 . ,blue)
             (280 . ,purple)
             (300 . ,red)
             (320 . ,orange)
             (340 . ,yellow)
             (360 . ,green)))
         `(vc-annotate-very-old-color nil)
         `(vc-annotate-background nil)
         `(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
         `(ansi-color-names-vector (vector ,background ,red ,green ,yellow ,blue ,purple ,aqua ,foreground))
         '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
         `(window-divider-mode nil)
         ))
       (provide-theme ',name))))


(defun color-theme-sanityinc-tomorrow (mode)
  "Apply the tomorrow variant theme."
  (if (fboundp 'load-theme)
      (let ((name (color-theme-sanityinc-tomorrow--theme-name mode)))
        (if (boundp 'custom-enabled-themes)
            (custom-set-variables `(custom-enabled-themes '(,name)))
          (if (> emacs-major-version 23)
              (load-theme name t)
            (load-theme name))))
    (progn
      (require 'color-theme)
      (color-theme-sanityinc-tomorrow--with-colors
       mode
       (color-theme-install
        `(,(intern (concat "color-theme-sanityinc-tomorrow-" (symbol-name mode)))
          ,@(color-theme-sanityinc-tomorrow--frame-parameter-specs)
          ,@(color-theme-sanityinc-tomorrow--face-specs)))
       ;; ansi-color - comint and other modes that handle terminal color escape sequences
       (setq ansi-color-names-vector (vector background red green yellow blue purple aqua foreground))
       (setq ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])))))

;;;###autoload
(when (boundp 'custom-theme-load-path)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;;;###autoload
(defun color-theme-sanityinc-tomorrow-night ()
  "Apply the tomorrow night theme."
  (interactive)
  (color-theme-sanityinc-tomorrow 'night))

;;;###autoload
(defun color-theme-sanityinc-tomorrow-day ()
  "Apply the tomorrow day theme."
  (interactive)
  (color-theme-sanityinc-tomorrow 'day))

;;;###autoload
(defun color-theme-sanityinc-tomorrow-bright ()
  "Apply the tomorrow bright theme."
  (interactive)
  (color-theme-sanityinc-tomorrow 'bright))

;;;###autoload
(defun color-theme-sanityinc-tomorrow-eighties ()
  "Apply the tomorrow eighties theme."
  (interactive)
  (color-theme-sanityinc-tomorrow 'eighties))

;;;###autoload
(defun color-theme-sanityinc-tomorrow-blue ()
  "Apply the tomorrow blue theme."
  (interactive)
  (color-theme-sanityinc-tomorrow 'blue))


(provide 'color-theme-sanityinc-tomorrow)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; color-theme-sanityinc-tomorrow.el ends here
