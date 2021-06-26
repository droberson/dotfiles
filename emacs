;; Daniel Roberson's .emacs
;;


;; Start in daemon mode.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'server)
(unless (server-running-p)
  (server-start))
  (add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

;; Type y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Stop to show startup message
(setq inhibit-startup-message t)

;; Stop to show toolbar
(if window-system (tool-bar-mode -1))

;; Change color of modeline
(set-face-background 'mode-line "Blue")
(set-face-foreground 'mode-line "White")

;; Use mouse in xterms
;; TODO: make it recognize if in X, console, or xterm if possible
(require 'xt-mouse)
(xterm-mouse-mode t)
(when (require 'mwheel nil 'noerror)
  (mouse-wheel-mode t))

;; Color settings
(set-foreground-color "gray")
(set-background-color "black")
(set-cursor-color "yellow")
(set-mouse-color "white")

;; Don't clobber creation dates of files (Use on OSX/Windows)
;;(setq backup-by-copying t)

;; Delete selections with a keypress
(delete-selection-mode 1)

;; matchCamelCasedWords for word navigation (M-f, M-b)
(global-subword-mode 0) ;; 1 = on, 0 = off

;; Disable automatic backups
;;
;; this is really annoying to have on by default. perhaps making it
;; only work in certain modes? it would be great to auto save for
;; document writing/note taking, but not for doing sysadmin work.
(setq make-backup-files nil)   ;; stop making ~ files
(setq auto-save-default nil)   ;; stop making #files#

;; org-mode stuff
(require 'org-install)
(setq org-log-done 'time)      ;; Timestamp on completion (C-c C-t)
(require 'org-inlinetask)
;;;; https://orgmode.org/guide/Multi_002dstate-Workflow.html
(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "|" "DONE")))

;; Set default terminal
(if (eq system-type 'gnu/linux)
    (setq explicit-shell-file-name "/usr/bin/zsh"))
(if (eq system-type 'berkeley-unix)
    (setq explicit-shell-file-name "/usr/local/bin/zsh"))

;; File name associations
(add-to-list 'auto-mode-alist '("\\.elvi\\'" . sh-mode))  ;; Surfraw elvis
(add-to-list 'auto-mode-alist '("\\.elvis\\'" . sh-mode)) ;; Surfraw elvis
(add-to-list 'auto-mode-alist '("\\.nse\\'" . lua-mode))  ;; Nmap NSE

;; Calendar
;;(calendar)

;; Word count function
;; Stole this from some forum.. Was useful a few times
(defun count-words-buffer ( )
  "Count the number of words in current buffer;
print a message in the minibuffer with the result."
  (interactive)
  (save-excursion
  (let ((count 0))
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-word 1)
	(setq count (1+ count)))
      (message "Buffer contains %d words." count))))

;; Bind Menu key to be the same as M-x
(global-set-key (kbd "<menu>") 'execute-extended-command)

;; Display line and column numbers
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)

;; highlight trailing quite space
(setq-default show-trailing-whitespace 't)

;; OpenBSD style C indenting. Stole from emacswiki!
;; C-c . "openbsd" to get after it.
(c-add-style "openbsd"
	     '("bsd"
	       (indent-tabs-mode . t)
	       (defun-block-intro . 8)
	       (statement-block-intro . 8)
	       (statement-case-intro . 8)
	       (substatement-open . 4)
	       (substatement 8)
	       (arglist-cont-nonempty . 4)
	       (inclass . 8)
	       (knr-argdecl-intro . 8)))

;; C++ match VS
(defun my-c-mode-common-hook ()
 ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
 (c-set-offset 'substatement-open 0)
 ;; other customizations can go here

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 4)                  ;; Default is 2
 (setq c-indent-level 4)                  ;; Default is 2

 (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
 (setq tab-width 4)
 (setq indent-tabs-mode t)  ; use spaces only if nil
 )


(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;; golang stuff
(require 'go-mode)

;; https://www.lemoda.net/emacs/go-tab-width/index.html
(defun my-go-setup ()
  (setq tab-width 4))
(add-hook 'go-mode-hook 'my-go-setup)

;; Aliases
(defalias 'fm 'flyspell-mode) ;; toggles flyspell mode


;; Melpa!@#$
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; I use zsh, so stop asking me which program to use, ansi-term!
(defadvice ansi-term (before shell-prompt)
  (interactive (list explicit-shell-file-name)))
(ad-activate 'ansi-term)


;; Alt key isnt working on linux for some reason
(setq x-alt-keysym 'meta)
