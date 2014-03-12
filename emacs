;; .emacs by Daniel Roberson (daniel ( AT ) revenantlabs . net)
;;
;; This is going to be a perpetual work in progress!!! 
;;

;; Start in daemon mode.
(require 'server)
(unless (server-running-p)
  (server-start))

;; Type y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Stop to show startup message
(setq inhibit-startup-message t)

;; Stop to show toolbar
(if window-system (tool-bar-mode -1))

;; Use mouse in xterms
;; TODO: make it recognize if in X, console, or xterm if possible
(require 'xt-mouse)
(xterm-mouse-mode t)
(moise-wheel-mode t)

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

;; Set default terminal
(if (eq system-type 'gnu/linux)
    (setq explicit-shell-file-name "/usr/bin/zsh")
)
(if (eq system-type 'berkeley-unix)
    (setq explicit-shell-file-name "/usr/local/bin/zsh")
)

;; File name associations
(add-to-list 'auto-mode-alist '("\\.elvi\\'" . sh-mode))  ;; Surfraw elvis
(add-to-list 'auto-mode-alist '("\\.elvis\\'" . sh-mode)) ;; Surfraw elvis

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

;; Aliases
(defalias 'fm 'flyspell-mode) ;; toggles flyspell mode

