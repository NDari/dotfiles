;; PACKAGE --- initualization for my emacs


;;; Code:
(require 'package)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			             ("gnu"   . "http://elpa.gnu.org/packages/")
			             ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)


(unless (package-installed-p 'use-package)
    (package-refresh-contents)
      (package-install 'use-package))
(eval-when-compile
    (require 'use-package))
(setq use-package-verbose t)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; no syntax
;; (global-font-lock-mode 0)

;; disable initial screen
(setq inhibit-startup-screen t)

;; always follow symlinks
(setq vc-follow-symlinks t)

;; set scrolling to be one line at a time
(setq scroll-step 1
      scroll-margin 10
      scroll-preserve-screen-position 1)

;; tab to complete and indent
(setq tab-always-indent 'complete)

;; Emacs modes typically provide a standard means to change the
;; indentation width -- eg. c-basic-offset: use that to adjust your
;; personal indentation width, while maintaining the style (and
;; meaning) of any files you load.
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; but maintain correct appearance

;; Mac Emacs settings
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; fancy titlebar for macos
;(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;(add-to-list 'default-frame-alist '(ns-appearance . dark))
;(setq ns-use-proxy-icon  nil)
;(setq frame-title-format nil)

;; show matching parens
(show-paren-mode 1)

;; disible bell only
(setq visible-bell 1)

;; show matching parns/braces/etc
(electric-pair-mode t)

;; indent to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq initial-frame-alist '((top . 0) (left . 0) (width . 100) (height . 50)))

; font
(add-to-list 'default-frame-alist '(font . "Consolas for Powerline-16"))
(set-face-attribute 'default t :font "Consolas for Powerline-16")

;; backups
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq backup-by-copying t) ; slow but safest bet
;(setq backup-by-copying-when-linked t) ; faster but may not be fool proof in all cases
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
;; and put all auto saved files (#filename# in that folder too
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))

;; line nums
(global-display-line-numbers-mode t)

; highlight current line
;(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;; Package settings
;; evil-mode
(use-package evil
  :ensure t
  :bind
  (:map evil-motion-state-map
        ("C-u" . evil-scroll-up))
  :init
  (setq evil-want-C-u-scroll t
        evil-want-C-i-jump t
        evil-want-Y-yank-to-eol t
        evil-want-keybinding nil)
  :config
  (evil-mode t)
  (add-to-list 'evil-emacs-state-modes 'vterm-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; evil mode custom key binds.
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

; and enable the <leader> key binding
 (use-package evil-leader
   :ensure t
   :init
   (global-evil-leader-mode))

 (evil-leader/set-leader "SPC")
   (evil-leader/set-key
     "f" 'helm-find
     "b" 'helm-buffers-list)

;; allow escape to be remapped
(use-package evil-escape
  :ensure t
  :init
  (evil-escape-mode +1)
  :config
  (setq-default evil-escape-key-sequence "kj")
  (setq-default evil-escape-delay 0.1))

;; snipe mode allows motion with "s" and two chars. a better version of
;; easymotion, and a clone of vim-seek
(use-package evil-snipe
  :ensure t
  :init
  (setq evil-snipe-scope 'whole-visible)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

;; same as vim surround
(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode 1))

;; theme
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;; change paren highlight color
;(use-package paren
;  :ensure t
;  :config
;  (setq show-paren-delay 0)
;  (set-face-background 'show-paren-match (face-background 'default))
;  (set-face-foreground 'show-paren-match "green")
;  (set-face-attribute 'show-paren-match nil :weight 'extra-bold)
;  (show-paren-mode +1)
;  (setq show-paren-style 'expression)) ;; highlight whole expression

;; all the icons
(use-package all-the-icons
  :if window-system
  :ensure t
  :config
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))


;; helm
(use-package helm
  :ensure t
  :init
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-echo-input-in-header-line t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  :config
  (helm-mode +1)
  (custom-set-variables
   '(helm-mode-fuzzy-match t)
   '(helm-completion-in-region-fuzzy-match t)
   '(helm-candidate-number-list 10)
   '(helm-split-window-in-side-p t))
  (bind-key "M-x" 'helm-M-x))

(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  :config
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (projectile-mode +1))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;; (XX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; enable company mode (for auto complete)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.2)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; use jupyter console for the repl
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
;; disable eply using it's own venv
(setq elpy-rpc-virtualenv-path 'current)


; (use-package rust-mode
;   :ensure t
;   :init
;   (setq rust-format-on-save t)
;   :config
;   (add-hook 'rust-mode-hook #'racer-mode))
;
; (use-package company-racer
;   :ensure t
;   :config
;   (add-hook 'racer-mode-hook #'eldoc-mode))

;; Superior Lisp Interaction Mode for Emacs
; (use-package slime
;   :ensure t
;   :defer t
;   :init
;   (setq inferior-lisp-program "sbcl")
;   :config
;   (add-hook 'slime-mode-hook
;             (lambda ()
;               (add-to-list 'slime-contribs 'slime-fancy)
;               (add-to-list 'slime-contribs 'inferior-slime))))

;; linting settings
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t)
  :config
  ;; spell checking. Emacs 24.2+ has flyspell, but we need
  ;; to do brew install aspell --with-lang-en to add a spell-checker
  ;; for it. to make it work in a buffer, do M-x flyspell-buffer
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'find-file-hooks 'turn-on-flyspell))

(use-package vterm
    :ensure t
    :load-path "~/tools/emacs-libvterm")

(use-package julia-mode
    :ensure t)

(use-package julia-snail
  :ensure t
  :hook (julia-mode . julia-snail-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;;; end here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" "939ea070fb0141cd035608b2baabc4bd50d8ecc86af8528df9d41f4d83664c6a" "76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" default))
 '(helm-candidate-number-list 10)
 '(helm-completion-in-region-fuzzy-match t)
 '(helm-minibuffer-history-key "M-p")
 '(helm-mode-fuzzy-match t)
 '(helm-split-window-inside-p t)
 '(package-selected-packages
   '(gruvbox-theme which-key use-package projectile julia-snail helm flycheck exec-path-from-shell evil-surround evil-snipe evil-leader evil-escape evil-collection elpy all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
