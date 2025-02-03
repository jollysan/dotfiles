;;sepereate customizations to another file
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;;load the theme
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (load-theme 'kanagawa t)
			  (load-file "~/.emacs.d/kanagawa-overrides.el"))))

;;do not pollute folders by creating backups, create them in another location
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;;Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/lisp");load my files


(load "~/.emacs.d/my-exwm-config.el")


(menu-bar-mode -1) ;f10 menu bar popup
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(electric-pair-mode 1)
(show-paren-mode 1)
;;(yas-global-mode 1)
(which-key-mode 1)
(add-hook 'after-init-hook 'global-company-mode) ;says in its page
;;(global-company-mode 1)
;;(recentf-mode 1)
(winner-mode 1)
;; something to do with truncated lines
(global-visual-line-mode t)


(setq inferior-lisp-program "sbcl")

(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(setq-default tab-width 4) ; Set tab width to 4 spaces

(setq fast-but-imprecise-scrolling 1)
;;(setq scroll-conservatively 101) ;when go outside window, scroll only enough to make cursor visible

;;(setq help-at-pt-display-when-idle t)

;;(setq echo-keystrokes 0.1) ; echo area wait time

(set-face-attribute 'default nil :height 150) ;font size
;; Inherit line-number face from default
(defun line-number-inherit ()
  "fix line number font size not changing issue"
  (set-face-attribute 'line-number nil :inherit 'default)
  (set-face-attribute 'line-number-current-line nil :inherit 'default)
  )
(add-hook 'server-after-make-frame-hook 'line-number-inherit)
(unless (and (boundp 'server-process) server-process)
  (line-number-inherit))


;;; smooth scroll
;;(pixel-scroll-precision-mode)
;;pixel-scroll-precision-use-momentum
;;(setq pixel-scroll-precision-large-scroll-height 40.0) ;for mouse scroll i guess


;;; lsp
(require 'flycheck)
(require 'lsp-ui)
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

;;lsp optimisation
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))


(add-hook 'lsp-mode-hook
		  (lambda ()
			(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)))

(add-hook 'compilation-filter-hook
		  (lambda () ;Colorize the compilation output.
			(ansi-color-apply-on-region (point-min) (point-max))));otherwise it prints color commands

;;(projectile-mode 1)
(add-hook 'projectile-mode-hook
		  (lambda ()
			(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))

(add-hook 'treemacs-mode-hook
		  (lambda ()
			(treemacs--set-width 25)
			(setq treemacs-indentation 1)
			(treemacs-follow-mode)))


;; discord rpc
(require 'elcord)
;;(elcord-mode) ;starts the rpc


(defun toggle-mode-line ()
  "toggles the modeline on and off"
  (interactive) 
  (setq mode-line-format
		(if (equal mode-line-format nil)
			(default-value 'mode-line-format)) )
  (redraw-display))

(defun toggle-mode-line-for-current-window ()
  "Toggle the mode line for the current window."
  (interactive)
  (if (not (window-parameter nil 'mode-line-format))
      ;; If no mode line format is set, disable the mode line for this window
      (set-window-parameter nil 'mode-line-format 'none)
    ;; Otherwise, restore the mode line to its default value
    (set-window-parameter nil 'mode-line-format nil))
  (force-mode-line-update))  ;; Force mode line to update for the window


(global-set-key [M-f12] 'toggle-mode-line)
(global-set-key [M-S-f12] 'toggle-mode-line-for-current-window)

;; (global-set-key [f12] '(lambda () (menu-bar-mode -1) (scroll-bar-mode -1)))

;; Variable to track if the desktop was read
(defvar my-desktop-was-read nil
  "Whether the desktop was read by `desktop-read`.")
;; Hook to read the desktop when the first client frame is created
(add-hook 'server-after-make-frame-hook
		  (lambda ()
			(unless my-desktop-was-read
			  (desktop-read)
			  (setq my-desktop-was-read t))))


