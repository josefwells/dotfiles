;; hey emacs this is -*- emacs-lisp -*-

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Install Packages
(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    blacken
    solarized-theme
    flycheck-yamllint
    yaml-mode
    dockerfile-mode
    origami
    diffview
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; Mouse
(xterm-mouse-mode 1)

(load-theme 'solarized-wombat-dark t)
;;(load-theme 'solarized-light t))


;; Turn off menubar
(menu-bar-mode -1)

;; Show what function I am in:
(which-function-mode 1)

;; c
(setq c-mode-hook
      '(lambda ()
	 (require 'gtags)
	 (gtags-mode 1)
	 ))
(setq c-default-style
      '((c-mode . "k&r") (other ."gnu")))
(setq c-basic-offset 8)

(add-to-list 'auto-mode-alist '("\\.S\\'" . gtags-mode))

;; perl
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;; python
(elpy-enable)
;;(setq elpy-syntax-check-command "pylint")
(when (load "flycheck" t t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))

;; makestuff
(global-set-key [f5] 'compile-again)
(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  """Run the same compile as the last time.

If there was no last time, or there is a prefix argument, this acts like
M-x compile.
"""
 (interactive "p")
 (if (and (eq pfx 1)
	    compilation-last-buffer)
     (progn
       (set-buffer compilation-last-buffer)
       (revert-buffer t t))
   (call-interactively 'compile)))


(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
)



;other stuff
(require 'generic-x)

(show-paren-mode t)
(setq blink-matching-paren t)
(setq column-number-mode t)
(setq inhibit-splash-screen t)
(setq inhibit-read-only t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default))
 '(package-selected-packages
   '(diffview origami dockerfile-mode yaml-mode flycheck-yamllint solarized-theme blacken flycheck elpy better-defaults)))


;;(require 'yaml-mode)
(autoload 'yaml-mode "yaml-mode" "YAML editing mode." t)
     (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
     (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Trailing whitespace fix on save
(defun my-before-save-hook ()
  (progn (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'my-before-save-hook)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load work settings if available
( let ((work-settings "~/.emacs.work.el"))
  (when (file-exists-p work-settings)
    (load-file work-settings))
)

