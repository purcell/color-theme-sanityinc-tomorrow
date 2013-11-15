;;; color-theme-sanityinc-tomorrow.el --- A version of Chris Kempson's "tomorrow" themes

;; Copyright (C) 2012 Steve Purcell

;; Author: Steve Purcell <steve@sanityinc.com>
;; Keywords: themes
;; X-URL: http://github.com/purcell/color-theme-sanityinc-tomorrow
;; URL: http://github.com/purcell/color-theme-sanityinc-tomorrow
;; Version: {{VERSION}}

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

;;     M-x color-theme-tomorrow-day
;;     M-x color-theme-tomorrow-night
;;     M-x color-theme-tomorrow-blue
;;     M-x color-theme-tomorrow-bright
;;     M-x color-theme-tomorrow-eighties
;;
;;; Credit:

;; Colour selection by Chris Kempson:
;; https://github.com/ChrisKempson/Tomorrow-Theme

;;; Code:

(defconst color-theme-sanityinc-tomorrow-colors
  '((night . ((background . "#1d1f21")
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

`MODE' should be set to either 'day, 'night, 'eighties, 'blue or 'bright."
  `(let* ((colors (or (cdr (assoc ,mode color-theme-sanityinc-tomorrow-colors))
                      (error "no such theme flavor")))
          (background   (cdr (assoc 'background colors)))
          (current-line (cdr (assoc 'current-line colors)))
          (selection    (cdr (assoc 'selection colors)))
          (foreground   (cdr (assoc 'foreground colors)))
          (comment      (cdr (assoc 'comment colors)))
          (red          (cdr (assoc 'red colors)))
          (orange       (cdr (assoc 'orange colors)))
          (yellow       (cdr (assoc 'yellow colors)))
          (green        (cdr (assoc 'green colors)))
          (aqua         (cdr (assoc 'aqua colors)))
          (blue         (cdr (assoc 'blue colors)))
          (purple       (cdr (assoc 'purple colors)))
          (class '((class color) (min-colors 89))))
     ,@body))

(defmacro color-theme-sanityinc-tomorrow--face-specs ()
  "Return a backquote which defines a list of face specs.

It expects to be evaluated in a scope in which the various color
names to which it refers are bound."
  (quote
   `(;; Standard font lock faces
     (default ((,class (:foreground ,foreground :background ,background))))
     (bold ((,class (:weight bold))))
     (bold-italic ((,class (:slant italic :weight bold))))
     (underline ((,class (:underline t))))
     (italic ((,class (:slant italic))))
     (font-lock-builtin-face ((,class (:foreground ,purple))))
     (font-lock-comment-delimiter-face ((,class (:foreground ,comment :slant italic))))
     (font-lock-comment-face ((,class (:foreground ,comment :slant italic))))
     (font-lock-constant-face ((,class (:foreground ,blue))))
     (font-lock-doc-face ((,class (:foreground ,purple))))
     (font-lock-doc-string-face ((,class (:foreground ,yellow))))
     (font-lock-function-name-face ((,class (:foreground ,orange))))
     (font-lock-keyword-face ((,class (:foreground ,green))))
     (font-lock-negation-char-face ((,class (:foreground ,blue))))
     (font-lock-preprocessor-face ((,class (:foreground ,purple))))
     (font-lock-regexp-grouping-backslash ((,class (:foreground ,yellow))))
     (font-lock-regexp-grouping-construct ((,class (:foreground ,purple))))
     (font-lock-string-face ((,class (:foreground ,aqua))))
     (font-lock-type-face ((,class (:foreground ,blue))))
     (font-lock-variable-name-face ((,class (:foreground ,yellow))))
     (font-lock-warning-face ((,class (:weight bold :foreground ,red))))
     (shadow ((,class (:foreground ,comment))))
     (success ((,class (:foreground ,green))))
     (error ((,class (:foreground ,red))))
     (warning ((,class (:foreground ,orange))))

     ;; Flycheck
     (flycheck-error ((,class (:underline (:style wave :color ,red)))))
     (flycheck-warning ((,class (:underline (:style wave :color ,orange)))))

     ;; Flymake
     (flymake-warnline ((,class (:underline (:style wave :color ,orange) :background ,background))))
     (flymake-errline ((,class (:underline (:style wave :color ,red) :background ,background))))

     ;; Clojure errors
     (clojure-test-failure-face ((,class (:background nil :inherit flymake-warnline))))
     (clojure-test-error-face ((,class (:background nil :inherit flymake-errline))))
     (clojure-test-success-face ((,class (:background nil :foreground nil :underline ,green))))

     ;; EDTS errors
     (edts-face-warning-line ((t (:background nil :inherit flymake-warnline))))
     (edts-face-warning-mode-line ((,class (:background nil :foreground ,orange :weight bold))))
     (edts-face-error-line ((t (:background nil :inherit flymake-errline))))
     (edts-face-error-mode-line ((,class (:background nil :foreground ,red :weight bold))))

     ;; For Brian Carper's extended clojure syntax table
     (clojure-keyword ((,class (:foreground ,yellow))))
     (clojure-parens ((,class (:foreground ,foreground))))
     (clojure-braces ((,class (:foreground ,green))))
     (clojure-brackets ((,class (:foreground ,yellow))))
     (clojure-double-quote ((,class (:foreground ,aqua :background nil))))
     (clojure-special ((,class (:foreground ,blue))))
     (clojure-java-call ((,class (:foreground ,purple))))

     ;; Rainbow-delimiters
     (rainbow-delimiters-depth-1-face ((,class (:foreground ,foreground))))
     (rainbow-delimiters-depth-2-face ((,class (:foreground ,aqua))))
     (rainbow-delimiters-depth-3-face ((,class (:foreground ,yellow))))
     (rainbow-delimiters-depth-4-face ((,class (:foreground ,green))))
     (rainbow-delimiters-depth-5-face ((,class (:foreground ,blue))))
     (rainbow-delimiters-depth-6-face ((,class (:foreground ,foreground))))
     (rainbow-delimiters-depth-7-face ((,class (:foreground ,aqua))))
     (rainbow-delimiters-depth-8-face ((,class (:foreground ,yellow))))
     (rainbow-delimiters-depth-9-face ((,class (:foreground ,green))))
     (rainbow-delimiters-unmatched-face ((,class (:foreground ,red))))

     ;; MMM-mode
     (mmm-code-submode-face ((,class (:background ,current-line))))
     (mmm-comment-submode-face ((,class (:inherit font-lock-comment-face))))
     (mmm-output-submode-face ((,class (:background ,current-line))))

     ;; Search
     (match ((,class (:foreground ,blue :background ,background :inverse-video t))))
     (isearch ((,class (:foreground ,yellow :background ,background :inverse-video t))))
     (isearch-lazy-highlight-face ((,class (:foreground ,aqua :background ,background :inverse-video t))))
     (isearch-fail ((,class (:background ,background :inherit font-lock-warning-face :inverse-video t))))

     ;; Anzu
     (anzu-mode-line ((,class (:foreground ,orange))))
     (anzu-replace-highlight ((,class (:inherit isearch-lazy-highlight-face))))
     (anzu-replace-to ((,class (:inherit isearch))))

     ;; IDO
     (ido-subdir ((,class (:foreground ,purple))))
     (ido-first-match ((,class (:foreground ,orange))))
     (ido-only-match ((,class (:foreground ,green))))
     (ido-indicator ((,class (:foreground ,red :background ,background))))
     (ido-virtual ((,class (:foreground ,comment))))

     ;; flx-ido
     (flx-highlight-face ((,class (:inherit nil :foreground ,yellow :weight bold :underline nil))))

     ;; which-function
     (which-func ((,class (:foreground ,blue :background nil :weight bold))))

     ;; Emacs interface
     (cursor ((,class (:background ,orange))))
     (fringe ((,class (:background ,current-line))))
     (linum ((,class (:background ,current-line :foreground ,green))))
     (border ((,class (:background ,current-line))))
     (border-glyph ((,class (nil))))
     (highlight ((,class (:inverse-video nil :background ,current-line))))
     (gui-element ((,class (:background ,current-line :foreground ,foreground))))
     (mode-line ((,class (:foreground nil :background ,current-line
                                      :box (:line-width 1 :color ,foreground)))))
     (mode-line-buffer-id ((,class (:foreground ,purple :background nil))))
     (mode-line-inactive ((,class (:inherit mode-line
                                       :foreground ,comment
                                       :background ,current-line :weight normal
                                       :box (:line-width 1 :color ,foreground)))))
     (mode-line-emphasis ((,class (:foreground ,foreground :slant italic))))
     (mode-line-highlight ((,class (:foreground ,purple :box nil :weight bold))))
     (minibuffer-prompt ((,class (:foreground ,blue))))
     (region ((,class (:background ,selection))))
     (secondary-selection ((,class (:background ,current-line))))

     (header-line ((,class (:inherit mode-line :foreground ,purple :background nil))))

     (trailing-whitespace ((,class (:foreground ,red :inverse-video t :underline nil))))
     (whitespace-trailing ((,class (:foreground ,red :inverse-video t :underline nil))))
     (whitespace-space-after-tab ((,class (:foreground ,red :inverse-video t :underline nil))))
     (whitespace-space-before-tab ((,class (:foreground ,red :inverse-video t :underline nil))))
     (whitespace-empty ((,class (:foreground ,red :inverse-video t :underline nil))))
     (whitespace-line ((,class (:background nil :foreground ,red))))
     (whitespace-indentation ((,class (:background nil :foreground ,aqua))))
     (whitespace-space ((,class (:background nil :foreground ,selection))))
     (whitespace-newline ((,class (:background nil :foreground ,selection))))
     (whitespace-tab ((,class (:background nil :foreground ,selection))))
     (whitespace-hspace ((,class (:background nil :foreground ,selection))))

     ;; Parenthesis matching (built-in)
     (show-paren-match ((,class (:background nil :foreground nil :inverse-video t))))
     (show-paren-mismatch ((,class (:background ,purple :foreground ,background))))

     ;; Smartparens paren matching
     (sp-show-pair-match-face ((,class (:foreground nil :background nil :inherit show-paren-match))))
     (sp-show-pair-mismatch-face ((,class (:foreground nil :background nil :inherit show-paren-mismatch))))

     ;; Parenthesis matching (mic-paren)
     (paren-face-match ((,class (:foreground nil :background nil :inherit show-paren-match))))
     (paren-face-mismatch ((,class (:foreground nil :background nil :inherit show-paren-mismatch))))
     (paren-face-no-match ((,class (:foreground nil :background nil :inherit show-paren-mismatch))))

     ;; Parenthesis dimming (parenface)
     (paren-face ((,class (:foreground ,comment :background nil))))

     (sh-heredoc ((,class (:foreground nil :inherit font-lock-string-face :weight normal))))
     (sh-quoted-exec ((,class (:foreground nil :inherit font-lock-preprocessor-face))))
     (slime-highlight-edits-face ((,class (:weight bold))))
     (slime-repl-input-face ((,class (:weight normal :underline nil))))
     (slime-repl-prompt-face ((,class (:underline nil :weight bold :foreground ,purple))))
     (slime-repl-result-face ((,class (:foreground ,green))))
     (slime-repl-output-face ((,class (:foreground ,blue :background ,background))))

     (csv-separator-face ((,class (:foreground ,orange))))

     (diff-added ((,class (:foreground ,green))))
     (diff-changed ((,class (:foreground ,purple))))
     (diff-removed ((,class (:foreground ,orange))))
     (diff-header ((,class (:foreground ,aqua :background nil))))
     (diff-file-header ((,class (:foreground ,blue :background nil))))
     (diff-hunk-header ((,class (:foreground ,purple))))
     (diff-refine-added ((,class (:inherit diff-added :inverse-video t))))
     (diff-refine-removed ((,class (:inherit diff-removed :inverse-video t))))

     (ediff-even-diff-A ((,class (:foreground nil :background nil :inverse-video t))))
     (ediff-even-diff-B ((,class (:foreground nil :background nil :inverse-video t))))
     (ediff-odd-diff-A  ((,class (:foreground ,comment :background nil :inverse-video t))))
     (ediff-odd-diff-B  ((,class (:foreground ,comment :background nil :inverse-video t))))

     (eldoc-highlight-function-argument ((,class (:foreground ,green :weight bold))))

     ;; macrostep
     (macrostep-expansion-highlight-face ((,class (:inherit highlight :foreground nil))))

     ;; undo-tree
     (undo-tree-visualizer-default-face ((,class (:foreground ,foreground))))
     (undo-tree-visualizer-current-face ((,class (:foreground ,green :weight bold))))
     (undo-tree-visualizer-active-branch-face ((,class (:foreground ,red))))
     (undo-tree-visualizer-register-face ((,class (:foreground ,yellow))))

     ;; dired+
     (diredp-compressed-file-suffix ((,class (:foreground ,blue))))
     (diredp-deletion ((,class (:inherit error :inverse-video t))))
     (diredp-deletion-file-name ((,class (:inherit error))))
     (diredp-dir-heading ((,class (:foreground ,green :weight bold))))
     (diredp-dir-priv ((,class (:foreground ,aqua :background nil))))
     (diredp-exec-priv ((,class (:foreground ,blue :background nil))))
     (diredp-executable-tag ((,class (:foreground ,red :background nil))))
     (diredp-file-name ((,class (:foreground ,yellow))))
     (diredp-file-suffix ((,class (:foreground ,green))))
     (diredp-flag-mark ((,class (:foreground ,green :inverse-video t))))
     (diredp-flag-mark-line ((,class (:background nil :inherit highlight))))
     (diredp-ignored-file-name ((,class (:foreground ,comment))))
     (diredp-link-priv ((,class (:background nil :foreground ,purple))))
     (diredp-mode-line-flagged ((,class (:foreground ,red))))
     (diredp-mode-line-marked ((,class (:foreground ,green))))
     (diredp-no-priv ((,class (:background nil))))
     (diredp-number ((,class (:foreground ,yellow))))
     (diredp-other-priv ((,class (:background nil :foreground ,purple))))
     (diredp-rare-priv ((,class (:foreground ,red :background nil))))
     (diredp-read-priv ((,class (:foreground ,green :background nil))))
     (diredp-symlink ((,class (:foreground ,purple))))
     (diredp-write-priv ((,class (:foreground ,yellow :background nil))))

     ;; Magit (a patch is pending in magit to make these standard upstream)
     (magit-branch ((,class (:foreground ,green))))
     (magit-header ((,class (:inherit nil :weight bold))))
     (magit-item-highlight ((,class (:inherit highlight :background nil))))
     (magit-log-author ((,class (:foreground ,aqua))))
     (magit-log-graph ((,class (:foreground ,comment))))
     (magit-log-sha1 ((,class (:foreground ,yellow))))
     (magit-log-head-label-bisect-bad ((,class (:foreground ,red))))
     (magit-log-head-label-bisect-good ((,class (:foreground ,green))))
     (magit-log-head-label-default ((,class (:foreground ,yellow :box nil :weight bold))))
     (magit-log-head-label-local ((,class (:foreground ,purple :box nil :weight bold))))
     (magit-log-head-label-remote ((,class (:foreground ,purple :box nil :weight bold))))
     (magit-log-head-label-tags ((,class (:foreground ,aqua :box nil :weight bold))))
     (magit-section-title ((,class (:foreground ,blue :weight bold))))

     ;; git-gutter
     (git-gutter:modified ((,class (:foreground ,purple :weight bold))))
     (git-gutter:added ((,class (:foreground ,green :weight bold))))
     (git-gutter:deleted ((,class (:foreground ,red :weight bold))))
     (git-gutter:unchanged ((,class (:background ,yellow))))

     ;; git-gutter-fringe
     (git-gutter-fr:modified ((,class (:foreground ,purple :weight bold))))
     (git-gutter-fr:added ((,class (:foreground ,green :weight bold))))
     (git-gutter-fr:deleted ((,class (:foreground ,red :weight bold))))

     (link ((,class (:foreground nil :underline t))))
     (widget-button ((,class (:underline t))))
     (widget-field ((,class (:background ,current-line :box (:line-width 1 :color ,foreground)))))

     ;; Compilation (most faces politely inherit from 'success, 'error, 'warning etc.)
     (compilation-column-number ((,class (:foreground ,yellow))))
     (compilation-line-number ((,class (:foreground ,yellow))))
     (compilation-message-face ((,class (:foreground ,blue))))
     (compilation-mode-line-exit ((,class (:foreground ,green))))
     (compilation-mode-line-fail ((,class (:foreground ,red))))
     (compilation-mode-line-run ((,class (:foreground ,blue))))

     ;; Grep
     (grep-context-face ((,class (:foreground ,comment))))
     (grep-error-face ((,class (:foreground ,red :weight bold :underline t))))
     (grep-hit-face ((,class (:foreground ,blue))))
     (grep-match-face ((,class (:foreground nil :background nil :inherit match))))

     ;;; TODO: wgrep faces

     (regex-tool-matched-face ((,class (:foreground nil :background nil :inherit match))))

     ;; mark-multiple
     (mm/master-face ((,class (:inherit region :foreground nil :background nil))))
     (mm/mirror-face ((,class (:inherit region :foreground nil :background nil))))

     (org-agenda-structure ((,class (:foreground ,purple))))
     (org-agenda-date ((,class (:foreground ,blue :underline nil))))
     (org-agenda-done ((,class (:foreground ,green))))
     (org-agenda-dimmed-todo-face ((,class (:foreground ,comment))))
     (org-block ((,class (:foreground ,orange))))
     (org-code ((,class (:foreground ,yellow))))
     (org-column ((,class (:background ,current-line))))
     (org-column-title ((,class (:inherit org-column :weight bold :underline t))))
     (org-date ((,class (:foreground ,blue :underline t))))
     (org-document-info ((,class (:foreground ,aqua))))
     (org-document-info-keyword ((,class (:foreground ,green))))
     (org-document-title ((,class (:weight bold :foreground ,orange :height 1.44))))
     (org-done ((,class (:foreground ,green))))
     (org-ellipsis ((,class (:foreground ,comment))))
     (org-footnote ((,class (:foreground ,aqua))))
     (org-formula ((,class (:foreground ,red))))
     (org-hide ((,class (:foreground ,background :background ,background))))
     (org-link ((,class (:foreground ,blue :underline t))))
     (org-scheduled ((,class (:foreground ,green))))
     (org-scheduled-previously ((,class (:foreground ,orange))))
     (org-scheduled-today ((,class (:foreground ,green))))
     (org-special-keyword ((,class (:foreground ,orange))))
     (org-table ((,class (:foreground ,purple))))
     (org-todo ((,class (:foreground ,red))))
     (org-upcoming-deadline ((,class (:foreground ,orange))))
     (org-warning ((,class (:weight bold :foreground ,red))))

     (markdown-url-face ((,class (:inherit link))))
     (markdown-link-face ((,class (:foreground ,blue :underline t))))

     (hl-sexp-face ((,class (:background ,current-line))))
     (highlight-symbol-face ((,class (:background ,current-line :weight bold))))
     (highlight-80+ ((,class (:background ,current-line))))

     ;; Python-specific overrides
     (py-builtins-face ((,class (:foreground ,orange :weight normal))))

     ;; js2-mode
     (js2-warning ((,class (:underline ,orange))))
     (js2-error ((,class (:foreground nil :underline ,red))))
     (js2-external-variable ((,class (:foreground ,purple))))
     (js2-function-param ((,class (:foreground ,blue))))
     (js2-instance-member ((,class (:foreground ,blue))))
     (js2-private-function-call ((,class (:foreground ,red))))

     ;; js3-mode
     (js3-warning-face ((,class (:underline ,orange))))
     (js3-error-face ((,class (:foreground nil :underline ,red))))
     (js3-external-variable-face ((,class (:foreground ,purple))))
     (js3-function-param-face ((,class (:foreground ,blue))))
     (js3-jsdoc-tag-face ((,class (:foreground ,orange))))
     (js3-jsdoc-type-face ((,class (:foreground ,aqua))))
     (js3-jsdoc-value-face ((,class (:foreground ,yellow))))
     (js3-jsdoc-html-tag-name-face ((,class (:foreground ,blue))))
     (js3-jsdoc-html-tag-delimiter-face ((,class (:foreground ,green))))
     (js3-instance-member-face ((,class (:foreground ,blue))))
     (js3-private-function-call-face ((,class (:foreground ,red))))

     ;; coffee-mode
     (coffee-mode-class-name ((,class (:foreground ,orange :weight bold))))
     (coffee-mode-function-param ((,class (:foreground ,purple))))

     ;; nxml
     (nxml-name-face ((,class (:foreground unspecified :inherit font-lock-constant-face))))
     (nxml-attribute-local-name-face ((,class (:foreground unspecified :inherit font-lock-variable-name-face))))
     (nxml-ref-face ((,class (:foreground unspecified :inherit font-lock-preprocessor-face))))
     (nxml-delimiter-face ((,class (:foreground unspecified :inherit font-lock-keyword-face))))
     (nxml-delimited-data-face ((,class (:foreground unspecified :inherit font-lock-string-face))))
     (rng-error-face ((,class (:underline ,red))))

     ;; RHTML
     (erb-delim-face ((,class (:background ,current-line))))
     (erb-exec-face ((,class (:background ,current-line :weight bold))))
     (erb-exec-delim-face ((,class (:background ,current-line))))
     (erb-out-face ((,class (:background ,current-line :weight bold))))
     (erb-out-delim-face ((,class (:background ,current-line))))
     (erb-comment-face ((,class (:background ,current-line :weight bold :slant italic))))
     (erb-comment-delim-face ((,class (:background ,current-line))))

     ;; Message-mode
     (message-header-other ((,class (:foreground nil :background nil :weight normal))))
     (message-header-subject ((,class (:inherit message-header-other :weight bold :foreground ,yellow))))
     (message-header-to ((,class (:inherit message-header-other :weight bold :foreground ,orange))))
     (message-header-cc ((,class (:inherit message-header-to :foreground nil))))
     (message-header-name ((,class (:foreground ,blue :background nil))))
     (message-header-newsgroups ((,class (:foreground ,aqua :background nil :slant normal))))
     (message-separator ((,class (:foreground ,purple))))

     ;; Jabber
     (jabber-chat-prompt-local ((,class (:foreground ,yellow))))
     (jabber-chat-prompt-foreign ((,class (:foreground ,orange))))
     (jabber-chat-prompt-system ((,class (:foreground ,yellow :weight bold))))
     (jabber-chat-text-local ((,class (:foreground ,yellow))))
     (jabber-chat-text-foreign ((,class (:foreground ,orange))))
     (jabber-chat-text-error ((,class (:foreground ,red))))

     (jabber-roster-user-online ((,class (:foreground ,green))))
     (jabber-roster-user-xa ((,class :foreground ,comment)))
     (jabber-roster-user-dnd ((,class :foreground ,yellow)))
     (jabber-roster-user-away ((,class (:foreground ,orange))))
     (jabber-roster-user-chatty ((,class (:foreground ,purple))))
     (jabber-roster-user-error ((,class (:foreground ,red))))
     (jabber-roster-user-offline ((,class (:foreground ,comment))))

     (jabber-rare-time-face ((,class (:foreground ,comment))))
     (jabber-activity-face ((,class (:foreground ,purple))))
     (jabber-activity-personal-face ((,class (:foreground ,aqua))))

     ;; Powerline
     (powerline-active1 ((t (:foreground ,foreground :background ,selection))))
     (powerline-active2 ((t (:foreground ,foreground :background ,current-line))))

     ;; Outline
     (outline-1 ((,class (:inherit nil :foreground ,blue))))
     (outline-2 ((,class (:inherit nil :foreground ,yellow))))
     (outline-3 ((,class (:inherit nil :foreground ,purple))))
     (outline-4 ((,class (:inherit nil :foreground ,aqua))))
     (outline-5 ((,class (:inherit nil :foreground ,orange))))
     (outline-6 ((,class (:inherit nil :foreground ,blue))))
     (outline-7 ((,class (:inherit nil :foreground ,yellow))))
     (outline-8 ((,class (:inherit nil :foreground ,purple))))
     (outline-9 ((,class (:inherit nil :foreground ,aqua))))

     ;; mu4e
     (mu4e-header-highlight-face ((,class (:underline nil :inherit region))))
     (mu4e-header-marks-face ((,class (:underline nil :foreground ,yellow))))
     (mu4e-flagged-face ((,class (:foreground ,orange :inherit nil))))
     (mu4e-replied-face ((,class (:foreground ,blue :inherit nil))))
     (mu4e-unread-face ((,class (:foreground ,yellow :inherit nil))))
     (mu4e-cited-1-face ((,class (:inherit outline-1 :slant normal))))
     (mu4e-cited-2-face ((,class (:inherit outline-2 :slant normal))))
     (mu4e-cited-3-face ((,class (:inherit outline-3 :slant normal))))
     (mu4e-cited-4-face ((,class (:inherit outline-4 :slant normal))))
     (mu4e-cited-5-face ((,class (:inherit outline-5 :slant normal))))
     (mu4e-cited-6-face ((,class (:inherit outline-6 :slant normal))))
     (mu4e-cited-7-face ((,class (:inherit outline-7 :slant normal))))
     (mu4e-ok-face ((,class (:foreground ,green))))
     (mu4e-view-contact-face ((,class (:inherit nil :foreground ,yellow))))
     (mu4e-view-link-face ((,class (:inherit link :foreground ,blue))))
     (mu4e-view-url-number-face ((,class (:inherit nil :foreground ,aqua))))
     (mu4e-view-attach-number-face ((,class (:inherit nil :foreground ,orange))))
     (mu4e-highlight-face ((,class (:inherit highlight))))
     (mu4e-title-face ((,class (:inherit nil :foreground ,green))))

     ;; Gnus
     (gnus-cite-1 ((,class (:inherit outline-1 :foreground nil))))
     (gnus-cite-2 ((,class (:inherit outline-2 :foreground nil))))
     (gnus-cite-3 ((,class (:inherit outline-3 :foreground nil))))
     (gnus-cite-4 ((,class (:inherit outline-4 :foreground nil))))
     (gnus-cite-5 ((,class (:inherit outline-5 :foreground nil))))
     (gnus-cite-6 ((,class (:inherit outline-6 :foreground nil))))
     (gnus-cite-7 ((,class (:inherit outline-7 :foreground nil))))
     (gnus-cite-8 ((,class (:inherit outline-8 :foreground nil))))
     ;; there are several more -cite- faces...
     (gnus-header-content ((,class (:inherit message-header-other))))
     (gnus-header-subject ((,class (:inherit message-header-subject))))
     (gnus-header-from ((,class (:inherit message-header-other-face :weight bold :foreground ,orange))))
     (gnus-header-name ((,class (:inherit message-header-name))))
     (gnus-button ((,class (:inherit link :foreground nil))))
     (gnus-signature ((,class (:inherit font-lock-comment-face))))

     (gnus-summary-normal-unread ((,class (:foreground ,blue :weight normal))))
     (gnus-summary-normal-read ((,class (:foreground ,foreground :weight normal))))
     (gnus-summary-normal-ancient ((,class (:foreground ,aqua :weight normal))))
     (gnus-summary-normal-ticked ((,class (:foreground ,orange :weight normal))))
     (gnus-summary-low-unread ((,class (:foreground ,comment :weight normal))))
     (gnus-summary-low-read ((,class (:foreground ,comment :weight normal))))
     (gnus-summary-low-ancient ((,class (:foreground ,comment :weight normal))))
     (gnus-summary-high-unread ((,class (:foreground ,yellow :weight normal))))
     (gnus-summary-high-read ((,class (:foreground ,green :weight normal))))
     (gnus-summary-high-ancient ((,class (:foreground ,green :weight normal))))
     (gnus-summary-high-ticked ((,class (:foreground ,orange :weight normal))))
     (gnus-summary-cancelled ((,class (:foreground ,red :background nil :weight normal))))

     (gnus-group-mail-low ((,class (:foreground ,comment))))
     (gnus-group-mail-low-empty ((,class (:foreground ,comment))))
     (gnus-group-mail-1 ((,class (:foreground nil :weight normal :inherit outline-1))))
     (gnus-group-mail-2 ((,class (:foreground nil :weight normal :inherit outline-2))))
     (gnus-group-mail-3 ((,class (:foreground nil :weight normal :inherit outline-3))))
     (gnus-group-mail-4 ((,class (:foreground nil :weight normal :inherit outline-4))))
     (gnus-group-mail-5 ((,class (:foreground nil :weight normal :inherit outline-5))))
     (gnus-group-mail-6 ((,class (:foreground nil :weight normal :inherit outline-6))))
     (gnus-group-mail-1-empty ((,class (:inherit gnus-group-mail-1 :foreground ,comment))))
     (gnus-group-mail-2-empty ((,class (:inherit gnus-group-mail-2 :foreground ,comment))))
     (gnus-group-mail-3-empty ((,class (:inherit gnus-group-mail-3 :foreground ,comment))))
     (gnus-group-mail-4-empty ((,class (:inherit gnus-group-mail-4 :foreground ,comment))))
     (gnus-group-mail-5-empty ((,class (:inherit gnus-group-mail-5 :foreground ,comment))))
     (gnus-group-mail-6-empty ((,class (:inherit gnus-group-mail-6 :foreground ,comment))))
     (gnus-group-news-1 ((,class (:foreground nil :weight normal :inherit outline-5))))
     (gnus-group-news-2 ((,class (:foreground nil :weight normal :inherit outline-6))))
     (gnus-group-news-3 ((,class (:foreground nil :weight normal :inherit outline-7))))
     (gnus-group-news-4 ((,class (:foreground nil :weight normal :inherit outline-8))))
     (gnus-group-news-5 ((,class (:foreground nil :weight normal :inherit outline-1))))
     (gnus-group-news-6 ((,class (:foreground nil :weight normal :inherit outline-2))))
     (gnus-group-news-1-empty ((,class (:inherit gnus-group-news-1 :foreground ,comment))))
     (gnus-group-news-2-empty ((,class (:inherit gnus-group-news-2 :foreground ,comment))))
     (gnus-group-news-3-empty ((,class (:inherit gnus-group-news-3 :foreground ,comment))))
     (gnus-group-news-4-empty ((,class (:inherit gnus-group-news-4 :foreground ,comment))))
     (gnus-group-news-5-empty ((,class (:inherit gnus-group-news-5 :foreground ,comment))))
     (gnus-group-news-6-empty ((,class (:inherit gnus-group-news-6 :foreground ,comment))))

     (erc-direct-msg-face ((,class (:foreground ,orange))))
     (erc-error-face ((,class (:foreground ,red))))
     (erc-header-face ((,class (:foreground ,foreground :background ,selection))))
     (erc-input-face ((,class (:foreground ,green))))
     (erc-keyword-face ((,class (:foreground ,yellow))))
     (erc-current-nick-face ((,class (:foreground ,green))))
     (erc-my-nick-face ((,class (:foreground ,green))))
     (erc-nick-default-face ((,class (:weight normal :foreground ,purple))))
     (erc-nick-msg-face ((,class (:weight normal :foreground ,yellow))))
     (erc-notice-face ((,class (:foreground ,comment))))
     (erc-pal-face ((,class (:foreground ,orange))))
     (erc-prompt-face ((,class (:foreground ,blue))))
     (erc-timestamp-face ((,class (:foreground ,aqua))))
     (erc-keyword-face ((,class (:foreground ,green))))

     ;; twittering-mode
     (twittering-username-face ((,class (:inherit erc-pal-face))))
     (twittering-uri-face ((,class (:foreground ,blue :inherit link))))
     (twittering-timeline-header-face ((,class (:foreground ,green :weight bold))))
     (twittering-timeline-footer-face ((,class (:inherit twittering-timeline-header-face))))

     (custom-variable-tag ((,class (:foreground ,blue))))
     (custom-group-tag ((,class (:foreground ,blue))))
     (custom-state ((,class (:foreground ,green))))

     ;; ansi-term
     (term ((,class (:foreground nil :background nil :inherit default))))
     (term-color-black   ((,class (:foreground ,foreground :background ,foreground))))
     (term-color-red     ((,class (:foreground ,red :background ,red))))
     (term-color-green   ((,class (:foreground ,green :background ,green))))
     (term-color-yellow  ((,class (:foreground ,yellow :background ,yellow))))
     (term-color-blue    ((,class (:foreground ,blue :background ,blue))))
     (term-color-magenta ((,class (:foreground ,purple :background ,purple))))
     (term-color-cyan    ((,class (:foreground ,aqua :background ,aqua))))
     (term-color-white   ((,class (:foreground ,background :background ,background))))
     )))

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
      (cursor-color . ,purple)
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
         `(fci-rule-color ,current-line)
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
         `(ansi-color-names-vector (vector ,foreground ,red ,green ,yellow ,blue ,purple ,aqua ,background))
         '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
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
       (setq ansi-color-names-vector (vector foreground red green yellow blue purple aqua background))
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
;; rainbow-mode: t
;; End:

;;; color-theme-sanityinc-tomorrow.el ends here
