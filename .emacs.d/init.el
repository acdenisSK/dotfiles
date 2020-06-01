;;; init.el --- Emacs configuration  -*- lexical-binding: t; -*-

;; Some parts of this configuration were influenced by Dawid Eckert (daedreth)'s configuration¹,
;; to whom I must express my gratitude for convincing me to use such a fantastic and customizable editor/platform!
;; His Youtube tutorial series is great². Also, checkout Lukewh³'s Emacs series⁴; they're great too!
;;
;; 1 - https://github.com/daedreth/UncleDavesEmacs
;; 2 - https://www.youtube.com/watch?v=d6iY_1aMzeg&list=PLX2044Ew-UVVv31a0-Qn3dA6Sd_-NyA1n
;; 3 - https://www.youtube.com/channel/UC7FpGodjczWY8mDV1KvP2pQ
;; 4 - https://www.youtube.com/playlist?list=PLNJWazvift25KnHDwYlhwrrgr60wtpQOB

;;; This fixed garbage collection, makes emacs start up faster ;;;;;;;
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))

(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
	gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package atom-one-dark-theme
  :ensure t
  :config (load-theme 'atom-one-dark t))

(defvar alex/shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list alex/shell)))
(ad-activate 'ansi-term)
(global-set-key (kbd "<M-return>") 'ansi-term)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C-+") 'text-scale-decrease)

(global-subword-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-always-indent 'complete)

(setq backward-delete-char-untabify-method 'hungry)

(setq next-line-add-newlines nil)

(show-paren-mode 1)

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

(setq line-number-mode t)
(setq column-number-mode t)

(global-hl-line-mode)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-message t)

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

(ido-mode 1)

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :after all-the-icons
  :hook (after-init . doom-modeline-mode))

(use-package eterm-256color
  :ensure t
  :hook (term-mode . eterm-256color-mode))

(use-package rainbow-mode
  :ensure t
  :hook (web-mode . rainbow-mode))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package evil
  :ensure t
  :config (evil-mode 1))

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :bind
  (:map company-mode-map ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-tooltip-limit 5)
  (company-idle-delay 0.15)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  (company-require-match 'never))

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

(use-package toml-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package flycheck-rust
  :ensure t
  :after flycheck
  :hook (flycheck-mode . flycheck-rust-setup))

(use-package meson-mode
  :ensure t)

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer")))
  :hook ((c-mode c++-mode rust-mode) . eglot-ensure)
  :bind (:map eglot-mode-map (("<f2>" . eglot-rename) ("<f3>" . eglot-format))))

(use-package eldoc-box
  :ensure t
  :hook (eglot-managed-mode . eldoc-box-hover-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.15)
 '(company-minimum-prefix-length 2)
 '(company-require-match 'never)
 '(company-selection-wrap-around t)
 '(company-tooltip-limit 5)
 '(package-selected-packages
   '(smex eldoc-box eglot flycheck-rust rust-mode toml-mode dashboard company flycheck evil avy expand-region which-key eterm-256color doom-modeline all-the-icons atom-one-dark-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
