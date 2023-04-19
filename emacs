;(vc-load-vc-hooks)

;; (if (display-graphic-p)
;;     (progn
;;       (load "gnuserv-compat")
;;       (load-library "gnuserv")
;;       (gnuserv-start)
;;       )
;;  )

;;too many git diffs
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; ; TRAMP
;; (require 'tramp )
;; (setq tramp-default-method "ssh")
;; ;      tramp-default-host "mckenzie")

;; (add-to-list 'tramp-default-proxies-alist
;;              '("\\." "\\`root\\'" "/ssh:%h:"))

;; ; show remote host in mode line
;; (defconst my-mode-line-buffer-identification
;;   (list
;;    '(:eval
;;        (let ((host-name
;;               (if (file-remote-p default-directory)
;;                   (tramp-file-name-host
;;                    (tramp-dissect-file-name default-directory))
;;                 (system-name)))
;;              (user-name
;;               (if (string-match "^/su\\(do\\)?:root@" default-directory)
;;                   #("root" 0 4 (face font-lock-warning-face))
;;                 (user-login-name))))
;;          (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
;;              (concat user-name "@"
;;              (substring host-name 0 (match-beginning 1)))
;;            (concat user-name "@" host-name))))
;;    ": %12b"))

;; (setq-default
;;  mode-line-buffer-identification
;;  my-mode-line-buffer-identification
;; )

;; (add-hook
;;  'dired-mode-hook
;;  '(lambda ()
;;     (setq
;;      mode-line-buffer-identification
;;      my-mode-line-buffer-identification)))

;; ; /TRAMP


; Turn off menubar
(menu-bar-mode -1)

; Show what function I am in:
(which-function-mode 1)

;  OLD emacs color crap.. is crap(load-file "~/.emacs.colors.el")

(setq c-mode-hook
      '(lambda ()
	 (require 'gtags)
	 (gtags-mode 1)
	 ))

(add-to-list 'auto-mode-alist '("\\.S\\'" . gtags-mode))


;; (defun x-paste ()
;;   (interactive)
;;   (let ((interprogram-paste-function
;; 	 'x-cut-buffer-or-selection-value))
;;    (yank)))

;; scroll wheel support
;;(add-to-list 'load-path "~/.emacs.d")
(unless window-system
;;  (require 'ext-mouse)

;;  (xterm-mouse-mode 1)
;;   (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 2)))
;;   (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 2)))
;;   (xterm-mouse-mode t);
;;   (mouse-wheel-mode t)
;;   (load-library "mouse")
;;   (global-set-key [mouse-2] 'x-paste)
;;   (setq x-select-enable-clipboard t)
)

;;(menu-bar-enable-clipboard t)


;perl
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;python
; (add-hook 'python-mode-hook
;       (lambda ()
;         (setq indent-tabs-mode t)
;         (setq tab-width 8)
;         (setq python-indent 8)))

(add-hook 'python-mode-hook 'guess-style-guess-tabs-mode)
(add-hook 'python-mode-hook (lambda ()
			      (guess-style-guess-tab-width)))

;c
(setq c-default-style
      '((c-mode . "k&r") (other . "gnu")))

(setq c-basic-offset 8)

;makestuff
;(setq compilation-read-command nil)
;(global-set-key [f5] 'compile)

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
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


;;(setq server-use-tcp t)
;;(when (and (functionp 'server-running-p) (not (server-running-p)))
;;(server-start))


;other stuff
(require 'generic-x)
;(require 'hexagon-mode)

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
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default))))

;;Solarized Colors

(when (>= emacs-major-version 24)
  (add-to-list 'load-path "~/.emacs.d/lua-mode")
  (add-to-list 'load-path "~/.emacs.d/yaml-mode")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
  (load-theme 'solarized-light t))

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
    (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
    (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(require 'yaml-mode)
(autoload 'yaml-mode "yaml-mode" "YAML editing mode." t)
     (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
     (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
     