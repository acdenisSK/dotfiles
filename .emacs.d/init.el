;;; init.el --- Emacs configuration  -*- lexical-binding: t; -*-

;; Run the garbage collector at around 40 MBs, rather than the default 800 kBs,
;; for faster startup time.
(setq gc-cons-threshold 40000000)

(defun startup/reset-gc ()
  (setq gc-cons-threshold 800000))

;; Do set it back, however.
(add-hook 'emacs-startup-hook 'startup/reset-gc)

;; Set up package management.
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Change defaults.

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-always-indent 'complete)

(setq backward-delete-char-untabify-method 'hungry)

(setq next-line-add-newlines nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq scroll-conservatively 100)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq ring-bell-function 'ignore)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(show-paren-mode 1)

(setq line-number-mode t)
(setq column-number-mode t)

(global-hl-line-mode)

(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-message t)

;; Change and add keybindings.
(defun kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x b") 'ibuffer)

(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C-+") 'text-scale-decrease)

(use-package atom-one-dark-theme
  :ensure t
  :config (load-theme 'atom-one-dark t))

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :after all-the-icons
  :config
  (doom-modeline-mode 1))

(use-package rainbow-mode
  :ensure t
  :hook (web-mode . rainbow-mode))

(use-package emojify
  :ensure t
  :config (global-emojify-mode 1))

(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode 1))

(use-package undo-fu
  :ensure t)

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package toml-mode
  :ensure t)

(use-package cmake-mode
  :ensure t)

(use-package meson-mode
  :ensure t)

(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1))

(use-package ivy
  :ensure t
  :init
  (setq
   ivy-use-virtual-buffers t
   enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :ensure t
  :after ivy
  :config
  (ivy-rich-mode 1))

(use-package counsel
  :ensure t
  :after (ivy ivy-rich)
  :config
  (counsel-mode 1))

(use-package evil
  :ensure t
  :init
  (setq
   evil-want-integration t
   evil-want-keybinding nil
   evil-want-C-u-scroll t
   evil-want-C-i-jump nil
   evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (add-to-list 'evil-emacs-state-modes 'dired-mode))

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (((c-mode c++-mode rust-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-ivy
  :ensure t
  :after ivy
  :commands lsp-ivy-workspace-symbol)

(use-package company
  :ensure t
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind ((:map company-active-map
               ("<tab>" . company-complete-selection)
               ("C-n" . company-select-next)
               ("C-p" . company-select-previous))
         (:map lsp-mode-map
               ("<tab>" . company-indent-or-complete-common)))
  :custom
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t))

(if window-system
    (use-package company-box
      :ensure t
      :hook (company-mode . company-box-mode)))

(use-package projectile
  :ensure t
  :init
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired)
  :config (projectile-mode 1)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package dashboard
  :ensure t
  :after all-the-icons
  :init
  (setq
   dashboard-items '((recents . 15))
   dashboard-set-file-icons t
   dashboard-set-heading-icons t)
  :config
  (dashboard-setup-startup-hook))

(use-package rustic
  :ensure t
  :init
  (setq
   rustic-lsp-client 'lsp-mode
   rustic-lsp-server 'rust-analyzer))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(atom-one-dark-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
