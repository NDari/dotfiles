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

;; the color scheme
; (load-theme 'solarized t)

;; disable initial screen
(setq inhibit-startup-screen t)

;; set scrolling to be one line at a time
(setq scroll-step 1)

;; set the scrolling to leave 10 lines above or below the highest or lowest line
(setq scroll-margin 10)

;; show matching parens
(show-paren-mode 1)

;; disible bell only
(setq visible-bell 1)

;; show matching parns/braces/etc
(electric-pair-mode t)

;; show matching parens without delay
(setq show-paren-delay 0)

;; indent to 2 spaces
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)

; Always follow symlinks
(setq vc-follow-symlinks t)

; font
(add-to-list 'default-frame-alist '(font . "Consolas-12"))
(set-face-attribute 'default t :font "Consolas-12")

;; change paren highlight color
(use-package paren :ensure t)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "red")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

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
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

; highlight current line
(global-hl-line-mode +1)
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
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

;; and enable the <leader> key binding
(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode))

(evil-leader/set-leader ",")
(evil-leader/set-key
  "t" 'helm-projectile
  "f" 'neotree-toggle
  "b" 'helm-buffers-list
  "p" 'evil-prev-buffer
  "n" 'evil-next-buffer
  "x" 'execute-extended-command
  "e" 'new-eshell
  "k" 'kill-buffer)

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; snipe mode allows motion with "s" and two chars. A better version of
;; easymotion, and a clone of vim-seek
(use-package evil-snipe
  :ensure t
  :init
  (setq evil-snipe-scope 'whole-visible)
  :config
  (evil-snipe-mode 1)
  (evil-snipe-override-mode 1))

;; same as vim surround
(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode 1))

;; kinda like nerd tree
;; All The Icons
(use-package all-the-icons :ensure t)

;; NeoTree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; make neotree keybinding work when in that buffer
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "y") 'neotree-copy-node)

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
	helm-mode-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-candidate-number-list 150
	helm-split-window-in-side-p t
	helm-move-to-line-cycle-in-source t
	helm-echo-input-in-header-line t
	helm-autoresize-max-height 0
	helm-autoresize-min-height 20)
  :config
  (helm-mode +1))

;; Fancy titlebar for MacOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

;; goimports on save
(defun my-go-mode-hook ()
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; set go mode to tab == 4 spaces
(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq indent-tabs-mode 1)))

;; highlight current line
; (use-package highlight-current-line
  ; :ensure t
  ; :config
  ; (highlight-current-line-on t)
  ; )

;; To customize the line-highlight color
; (set-face-background 'highlight-current-line-face "light grey")

;; golang snippets from https://github.com/atotto/yasnippet-golang
; (add-to-list 'yas-snippet-dirs "/Users/naseer/.emacs.d/plugins/yasnippet-golang")


;; spell checking. Emacs 24.2+ has flyspell, but we need
;; to do brew install aspell --with-lang-en to add a spell-checker
;; for it. to make it work in a buffer, do M-x flyspell-buffer
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'find-file-hooks 'turn-on-flyspell)

;; linting settings
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1B2229" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#DFDFDF"])
 '(custom-safe-themes
   (quote
    ("d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402" default)))
 '(fci-rule-color "#5B6268")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(package-selected-packages
   (quote
    (use-package neotree helm flycheck evil-surround evil-snipe doom-themes)))
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

(defun new-eshell ()
 "function to split a window horizontally, switch to it, and open eshell in it."
  (interactive)
    (let* ((new-window (split-window-horizontally)))
           (select-window new-window)
           (eshell "eshell")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
