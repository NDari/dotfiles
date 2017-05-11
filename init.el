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

;; Mac Emacs settings
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; fancy titlebar for macos
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

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

; set default home. Mostly for windows
(setq default-directory (getenv "HOME"))

(define-key global-map (kbd "C-;") 'helm-M-x)
;;;;;;;;;;;;;;;;; Package settings

;; evil-mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

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

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "t" 'helm-projectile
  "g" 'helm-find
  "f" 'helm-find-files
  "e" 'new-shell
  "b" 'helm-buffers-list
  "x" 'helm-M-x
  "k" 'kill-buffer)

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

; theme
(use-package atom-one-dark-theme
  :ensure t
  :init
  (load-theme 'atom-one-dark t))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;; change paren highlight color
(use-package paren
  :ensure t
  :config
  (setq show-paren-delay 0)
  (set-face-background 'show-paren-match (face-background 'default))
  (set-face-foreground 'show-paren-match "green")
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold)
  (show-paren-mode +1)
  (setq show-paren-style 'expression)) ;; highlight whole expression

;; all the icons
(use-package all-the-icons :ensure t)

;; kinda like nerd tree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; make neotree keybinding work when in that buffer
(evil-define-key 'normal neotree-mode-map (kbd "<return>") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "y") 'neotree-copy-node)

;; helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t)
  (setq helm-mode-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-locate-fuzzy-match t)
  (setq helm-semantic-fuzzy-match t)
  (setq helm-imenu-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 150)
  (setq helm-split-window-in-side-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-echo-input-in-header-line t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  :config
  (helm-mode +1))

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

;; rust
(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t))

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
 '(ansi-color-names-vector
   ["#1B2229" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#DFDFDF"])
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "adf5275cc3264f0a938d97ded007c82913906fc6cd64458eaae6853f6be287ce" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "0dd2666921bd4c651c7f8a724b3416e95228a13fca1aa27dc0022f4e023bf197" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "2c88b703cbe7ce802bf6f0bffe3edbb8d9ec68fc7557089d4eaa1e29f7529fe1" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "78496062ff095da640c6bb59711973c7c66f392e3ac0127e611221d541850de2" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402" default)))
 '(fci-rule-color "#5B6268")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(package-selected-packages
   (quote
    (solarized-theme evil-escape use-package neotree helm flycheck evil-surround evil-snipe)))
 '(show-paren-mode t)
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#b4be6c")
    (cons 60 "#d0be73")
    (cons 80 "#ECBE7B")
    (cons 100 "#e6ab6a")
    (cons 120 "#e09859")
    (cons 140 "#da8548")
    (cons 160 "#d38079")
    (cons 180 "#cc7cab")
    (cons 200 "#c678dd")
    (cons 220 "#d974b7")
    (cons 240 "#ec7091")
    (cons 260 "#ff6c6b")
    (cons 280 "#cf6162")
    (cons 300 "#9f585a")
    (cons 320 "#6f4e52")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))

;;;;;;;;;;;; Custom functions

(defun new-shell ()
 "Function to split a window horizontally, switch to it, and open shell in it."
  (interactive)
    (let* ((new-window (split-window-horizontally)))
           (select-window new-window)
           (shell "shell")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
