;; package management
(require 'package)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			             ("gnu"   . "http://elpa.gnu.org/packages/")
			             ("melpa" . "https://melpa.org/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)


(unless (package-installed-p 'use-package)
    (package-refresh-contents)
      (package-install 'use-package))
(eval-when-compile
    (require 'use-package))

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; disable initial screen
(setq inhibit-startup-screen t)

;; always follow symlinks
(setq vc-follow-symlinks t)

;; keep line location between reopening of a file
(setq scroll-preserve-screen-position 1)

;; set scrolling to be one line at a time
(setq scroll-step 1)

;; set the scrolling to leave 10 lines above or below the highest or lowest line
(setq scroll-margin 10)

;; tab to complete and indent
(setq tab-always-indent 'complete)

;; Mac Emacs settings
;(setq mac-option-modifier 'super)
;(setq mac-command-modifier 'meta)

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
(add-to-list 'default-frame-alist '(font . "Fira Code"))
(set-face-attribute 'default t :font "Fira Code")

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
(global-linum-mode t)
;; use customized linum-format: add a addition space after the line number
(setq linum-format
      (lambda (line)
        (propertize (format (let
                                ((w (length (number-to-string (count-lines (point-min)
                                                                           (point-max))))))
                              (concat "%" (number-to-string w) "d "))
                            line)
                    'face
                    'linum)))

; highlight current line
(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;; Package settings
;; evil-mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; evil mode custom key binds.
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-insert-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-insert-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-insert-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
     (define-key evil-insert-state-map (kbd "C-l") 'evil-window-right)))

; and enable the <leader> key binding
 (use-package evil-leader
   :ensure t
   :init
   (global-evil-leader-mode))

 (evil-leader/set-leader "SPC")
   (evil-leader/set-key
     "f" 'helm-find-files
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
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;; change paren highlight color
;; (use-package paren
;;   :ensure t
;;   :config
;;   (setq show-paren-delay 0)
;;   (set-face-background 'show-paren-match (face-background 'default))
;;   (set-face-foreground 'show-paren-match "green")
;;   (set-face-attribute 'show-paren-match nil :weight 'extra-bold)
;;   (show-paren-mode +1)
;;   (setq show-paren-style 'expression)) ;; highlight whole expression

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
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 150)
  (setq helm-split-window-in-side-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-echo-input-in-header-line t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  :config
  (helm-mode +1))
(global-set-key (kbd "M-x") 'helm-M-x)

;; enable company mode (for auto complete)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.5)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 20)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package rust-mode
  :ensure t
  :init
  (setq rust-format-on-save t))

(use-package company-racer
  :ensure t)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

;; Superior Lisp Interaction Mode for Emacs
(use-package slime
  :ensure t
  :defer t
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  (add-hook 'slime-mode-hook
            (lambda ()
              (add-to-list 'slime-contribs 'slime-fancy)
              (add-to-list 'slime-contribs 'inferior-slime))))

;; clojure stuff
;(use-package clojure-mode
  ;:ensure t
  ;:config
  ;(add-hook 'clojure-mode-hook #'paredit-mode)
  ;(add-hook 'clojure-mode-hook #'subword-mode)
  ;(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))
;
;(use-package cider
  ;:ensure t
  ;:config
  ;(setq nrepl-log-messages t)
  ;(add-hook 'cider-mode-hook #'eldoc-mode)
  ;(add-hook 'cider-repl-mode-hook #'eldoc-mode)
  ;(add-hook 'cider-repl-mode-hook #'paredit-mode)
  ;(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode))

(use-package paredit
  :ensure t
  :config
  (dolist (m '(emacs-lisp-mode-hook
	       racket-mode-hook
	       racket-repl-mode-hook))
    (add-hook m #'paredit-mode))
  (bind-keys :map paredit-mode-map
	     ("{"   . paredit-open-curly)
	     ("}"   . paredit-close-curly))
  (unless terminal-frame
    (bind-keys :map paredit-mode-map
	       ("M-[" . paredit-wrap-square)
	       ("M-{" . paredit-wrap-curly))))

;; linting settings
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; spell checking. Emacs 24.2+ has flyspell, but we need
;; to do brew install aspell --with-lang-en to add a spell-checker
;; for it. to make it work in a buffer, do M-x flyspell-buffer
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'find-file-hooks 'turn-on-flyspell)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-init nil t)
 '(evil-collection-setup-minibuffer t)
 '(package-selected-packages
   (quote
    (racket-mode slime-company company-lsp helm-company doom-themes which-key use-package slime rust-mode neotree helm flycheck evil-surround evil-snipe evil-leader evil-escape evil-collection company-racer all-the-icons))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
