;; .emacs by Daniel Roberson (daniel ( AT ) revenantlabs . net)
;;
;; This is going to be a perpetual work in progress!!! 
;;
;; Got a lot of this from ergoemacs.org -- thanks!

;; Start in daemon mode.
(server-start)

;; Color settings
(set-foreground-color "gray")
(set-background-color "black")
(set-cursor-color "yellow")
(set-mouse-color "white")

;; Don't clobber creation dates of files (Use on OSX/Windows)
;;(setq backup-by-copying t)

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
(setq explicit-shell-file-name "/usr/bin/zsh")

;; File name associations
(add-to-list 'auto-mode-alist '("\\.elvi\\'" . sh-mode))  ;; Surfraw elvis
(add-to-list 'auto-mode-alist '("\\.elvis\\'" . sh-mode)) ;; Surfraw elvis

;; Calendar
;;(calendar)

;; Word count function
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

