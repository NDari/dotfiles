;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(when (eq system-type 'gnu/linux)
  (setq x-super-keysym 'meta))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta))

(global-set-key (kbd "M-x") 'helm-M-x)
