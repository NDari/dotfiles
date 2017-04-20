;; package management
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
      (package-install 'use-package))

(eval-when-compile
    (require 'use-package))

;; No toolbar
(tool-bar-mode -1)

;; the color scheme
(load-theme 'solarized t)

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
(setq default-tab-width 2)

;; change paren highlight color
(require 'paren)
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

;; indentation settings
(setq js-indent-level 2)
(setq rb-indent-level 2)

;; line nums
(global-linum-mode t)
;; use customized linum-format: add a addition space after the line number
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;;;;;;;;;;;;;;;;; Package settings

;; evil-mode
(require 'evil)
(evil-mode t)

;; evil mode custom key binds.
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

;; and enable the <leader> key binding
(require 'evil-leader)
(global-evil-leader-mode)

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

;; snipe mode allows motion with "s" and two chars. A better version of
;; easymotion, and a clone of vim-seek
(require 'evil-snipe)
(evil-snipe-mode 1)
(evil-snipe-override-mode 1)
(setq evil-snipe-scope 'whole-visible)

;; same as vim surround
(require 'evil-surround)
(global-evil-surround-mode 1)

;; kinda like nerd tree
(require 'neotree)

;; make neotree keybinding work when in that buffer
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "y") 'neotree-copy-node)

;; enable company mode globally (for auto complete)
(global-company-mode t)

;; snippets!!
(require 'yasnippet)
(yas-global-mode 1)

(defun my-go-mode-hook ()
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; highlight current line
(require 'highlight-current-line)
(highlight-current-line-on t)

;; To customize the line-highlight color
(set-face-background 'highlight-current-line-face "light grey")

;; golang snippets from https://github.com/atotto/yasnippet-golang
(add-to-list 'yas-snippet-dirs "/Users/naseer/.emacs.d/plugins/yasnippet-golang")

;; set go mode to tab == 4 spaces
(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq indent-tabs-mode 1)))

;; spell checking. Emacs 24.2+ has flyspell, but we need
;; to do brew install aspell --with-lang-en to add a spell-checker
;; for it. to make it work in a buffer, do M-x flyspell-buffer
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'find-file-hooks 'turn-on-flyspell)

;; linting settings
(require 'flycheck)
(global-flycheck-mode t)
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pylint jedi gotest go-autocomplete evil-surround evil-snipe web-mode js2-mode company-go flymake-go elixir-yasnippets ## flymake-easy flymake-elixir flycheck markdown-preview-mode helm-projectile projectile neotree use-package magit linum-relative iedit highlight-current-line helm hc-zenburn-theme go-snippets go-eldoc exec-path-from-shell evil company-try-hard color-theme-solarized alchemist)))
 '(show-paren-mode t))

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
