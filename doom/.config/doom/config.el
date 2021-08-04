;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-zenburn)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun my-nov-font-setup ()
  "Ebook text width."
    (setq-default nov-text-width 80))
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; (use-package! lsp-tailwindcss)
(use-package! lsp-mode
  :config
  (add-to-list 'lsp-file-watch-ignored "[/\\\]vendor$")
  (setq lsp-file-watch-threshold 20000)
  (setq lsp-enable-snippets nil)
(setq +format-with-lsp nil))

(add-hook 'css-mode-hook #'lsp)

(use-package web-mode
  :commands web-mode
  :mode
  (("\\.html\\'"        . web-mode)
   ("\\.phtml\\'"       . web-mode)
   ("\\.tpl\\.php\\'"   . web-mode)
   ("\\.html\\.twig\\'" . web-mode))
  :config
  (add-to-list 'web-mode-engines-alist
               '("django" . "\\.html\\.twig\\'")))
(setq-hook! 'web-mode-hook +format-with 'prettier-prettify)

(require 'php-cs-fixer)

(add-hook! 'php-mode-hook
  (custom-set-variables
    '(php-cs-fixer-config-option "/home/steven/.config/php/php-cs-fixer.php")
    '(php-cs-fixer-rules-fixer-part-options '(""))
    '(php-cs-fixer-rules-level-part-options nil)))
(add-hook! 'before-save-hook #'php-cs-fixer-before-save)

(setq
 lsp-intelephense-licence-key (replace-regexp-in-string "\n\\'" "" (shell-command-to-string "pass license/intelephense"))
 projectile-project-search-path '("~/code/"))