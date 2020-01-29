
;; remove tabs in verilog mode
(add-hook 'verilog-mode-hook '(lambda ()
    (add-hook 'local-write-file-hooks (lambda()
       (untabify (point-min) (point-max))))
;;    (setq compilation-error-regexp-alist
;;        (cons '("[ \t]+\"\\([^ \t\n,]+\\)\",[ \t\n,]+\\([0-9]+\\): " 1 2)
;;              compilation-error-regexp-alist))
))
;; remove tabs in python mode
(add-hook 'verilog-mode-hook '(lambda ()
    (add-hook 'local-write-file-hooks (lambda()
       (untabify (point-min) (point-max))))))

(setq load-path (cons (expand-file-name "~/emacs") load-path))
(setq load-path (cons (expand-file-name "~/emacs/nxml-mode-20041004") load-path))
(setq load-path (cons (expand-file-name "~/emacs/color-theme-6.6.0") load-path))
;; (setq load-path (cons (expand-file-name "~tc07/emacs") load-path))
;; (setq load-path (cons (expand-file-name "~tc07/emacs/nxml-mode-20041004") load-path))
;; (setq load-path (cons (expand-file-name "~tc07/emacs/color-theme-6.6.0") load-path))

;;(require 'p4)
(require 'color-theme)
(require 'linum)


; yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))


; determine system
(setq winntp (string-equal "windows-nt" system-type))
(setq unixp (not winntp))
(if winntp 
    (progn
      ;; default frame size and font
      (setq default-font "-outline-courier new-normal-r-normal-normal-13-97-96-96-c-*-iso10646-1")
      (setq default-frame-alist
                '((width . 90) (height . 62)
                  (cursor-color . "purple")
                  (cursor-type . box)
                  (foreground-color . "wheat")
                  (background-color . "black")
                  (font . "-outline-courier new-normal-r-normal-normal-13-97-96-96-c-*-iso10646-1")
                  ))
      ;; gnuserv
      (require 'gnuserv)
      (gnuserv-start)
      (setq gnuserv-frame (selected-frame))
      ;; allow bash to run as shell in emacs under windows
      (add-hook 'comint-output-filter-functions
                'shell-strip-ctrl-m nil t)
      (add-hook 'comint-output-filter-functions
                'comint-watch-for-password-prompt nil t)
      (setq explicit-shell-file-name "bash.exe")
      ;; for ses invoked via the shell
      ;; (e.g., "shell -c command")
      (setq shell-file-name explicit-shell-file-name)
      (defun my-shell-setup ()
        "for bash (cygwin) under emacs 20"
        (setq comint-scroll-show-maximum-output 'this)
        (setq comint-completion-addsuffix t)
        (setq comint-eol-on-send t)
        (setq w32-quote-process-args ?\")
        (make-variable-buffer-local 'comint-completion-addsuffix))

      (setq shell-mode-hook 'my-shell-setup)

      (setq process-coding-system-alist (cons '("bash" . raw-text-unix)
                                              process-coding-system-alist))
      ;; setup ediff
      (setq ediff-diff-program "c:\\\\cygwin\\\\bin\\\\diff")
      (setq ediff-diff3-program "c:\\\\cygwin\\\\bin\\\\diff3.exe")
      (setq ediff-diff3-options "--diff-program=c:/cygwin/bin/diff")
      (setq ediff-cmp-program "c:\\\\cygwin\\\\bin\\\\cmp")
      ;; fix tcl/tk
      (add-hook 'inferior-tcl-mode-hook
                (lambda ()
                  (tcl-send-string (inferior-tcl-proc) "set ::tcl_interactive 1\n")))

	))
(if unixp (progn
            (server-start)
            (setq default-font "-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso8859-1")
            (setq default-frame-alist
                  '((cursor-color . "purple")
                    (width . 90) (height . 82)
                    (cursor-type . box)
                    (foreground-color . "wheat")
                    (background-color . "black")
                    (font . "-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso8859-1")
                    ))
            ))

;; Email
(setq user-mail-address "Robert.Walczyk@arm.com")
(setq user-full-name "Robert Walczyk")

;; Gnus
(setq 
 gnus-select-method '(nntp "intnews")
 gnus-use-generic-from nil
 gnus-local-domain "arm.com"
 gnus-local-organization "Digital Design"
 gnus-auto-select-first nil
)

;;(setq initial-frame-alist default-frame-alist)
; some bindings
;(pc-bindings-mode)
;(pc-selection-mode)
(global-set-key [f5] 'goto-line)
(global-set-key [f9] 'toggle-read-only)
(global-set-key [C-f4] 'kill-this-buffer)
(global-set-key [f12] 'font-lock-fontify-buffer)
(global-set-key [f11] 'fix-buffer-menu-when-broken)
(defun revert-buffer-without-asking ()
  "revert un-modified buffer without asking"
  (interactive)
  (revert-buffer nil (not (buffer-modified-p))))
(defun fix-buffer-menu-when-broken ()
  "when the buffer menu fails to update correctly, this fixes it"
  (interactive)
  (add-hook 'menu-bar-update-hook 'menu-bar-update-buffers)
)

(setq html-helper-use-expert-menu t)
(setq html-helper-htmldtd-version "<!doctype html public \"-//w3c//dtd html 4.01 transitional//en\" \"http://www.w3.org/tr/1999/rec-html401-19991224/loose.dtd\">
")
(setq html-helper-address-string "robert walczyk (<a href=\"mailto:robert.walczyk@arm.com\">robert.walczyk@arm.com</a>)")


; choose my own title-bar string
; %f is filename, %b is buffer name
(setq default-frame-title-format
      (list ""
            (concat "emacs@"
                    (substring (system-name) 0
                               (string-match "\\..+" (system-name)))
                    " --  %f")))
(setq frame-title-format default-frame-title-format)
(setq icon-title-format default-frame-title-format)

; postscript printing setup
(set 'ps-paper-type 'a4)
;(setq ps-print-color-p nil) ; don't print in colour
(setq ps-print-use-faces t) ; use faces by default
(setq ps-bold-faces '(font-lock-keyword-face))
(setq ps-italic-faces '(font-lock-comment-face))
(setq ps-number-of-columns 2)
(setq ps-landscape-mode t)    
(setq completion-ignore-case t)
(setq completion-ignored-extensions (delete ".log" completion-ignored-extensions))
;(setq printer-name "hp-colourlj-5550-pcl6-stjohns-2-w")
;(setq ps-printer-name "hp-colourlj-5550-pcl6-stjohns-2-w")
;;; smtp sending
;; (setq send-mail-function 'smtpmail-send-it)
;; (setq smtpmail-default-smtp-server "wolf")
;; (setq smtpmail-smtp-service "smtp")
;; (setq smtpmail-local-domain "arm.com")
;; (setq smtpmail-debug-info t)
;; (load-library "smtpmail")
;; (setq smtpmail-code-conv-from nil)
;;; mail header hacking
(setq user-mail-address "robert.walczyk@arm.com")
(setq user-full-name "Robert Walczyk")

;configuration of woman interface
(setq woman-manpath '("c:/cygwin/usr/man" "c:/cygwin/usr/x11r6/man"))

;auto-load makefile mode
(setq auto-mode-alist (cons '("\\.mak$" . makefile-mode) auto-mode-alist))

;enable up and down keys within bash embedded in emacs
(add-hook 'shell-mode-hook 'n-shell-mode-hook)
(defun n-shell-mode-hook ()
  "12jan2002 - sailor, shell mode customizations."
  (local-set-key '[up] 'comint-previous-input)
  (local-set-key '[down] 'comint-next-input)
  (local-set-key '[(shift tab)] 'comint-next-matching-input-from-input)
  (setq comint-input-sender 'n-shell-simple-send)
  )

;enable clear command to work within shell mode of emacs
(defun n-shell-simple-send (proc command)
  "17jan02 - sailor. various commands pre-processing before sending to shell."
  (cond
   ;; checking for clear command and execute it.
   ((string-match "^[ \t]*clear[ \t]*$" command)
    (comint-send-string proc "\n")
    (erase-buffer)
    )
   ;; checking for man command and execute it.
   ((string-match "^[ \t]*man[ \t]*" command)
    (comint-send-string proc "\n")
    (setq command (replace-regexp-in-string "^[ \t]*man[ \t]*" "" command))
    (setq command (replace-regexp-in-string "[ \t]+$" "" command))
    ;;(message (format "command %s command" command))
    (funcall 'woman command)
    )
   ;; send other commands to the default handler.
   (t (comint-simple-send proc command))
   )
  )

; compilation in c/c++ modes
(defun compile-buffer ()
  (interactive)
  (let (
        (tcc-cc  (concat "make -k -j6 ";(setq woman-manpath '("c:/cygwin/usr/man" "c:/usr/man" "c:/usr/local/man"))
 (file-name-sans-extension buffer-file-name)))
        (tcc-old-cc compile-command)
        )
    (compile tcc-cc)
    (setq compile-command tcc-old-cc)
)
)

;(load "/home/ab10/.xemacs/lisp/tabbar.el")
(require 'tabbar)
(tabbar-mode t)

(add-hook 'c-mode-common-hook (function (lambda () (local-set-key "\C-c\C-\M-k" 'compile-buffer))))
(add-hook 'c-mode-common-hook (function (lambda () (local-set-key "\C-c\C-k" 'compile))))
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (if (or (file-exists-p "makefile")
			(file-exists-p "Makefile"))
              (set (make-local-variable 'compile-command) "make -k -j6 sw")
	      (set (make-local-variable 'compile-command)
		   (concat "make -k "
			   (file-name-sans-extension buffer-file-name)))
              )))


;; Gnus
(setq 
 gnus-select-method '(nntp "intnews")
 gnus-use-generic-from nil
 gnus-local-domain "arm.com"
 gnus-local-organization "Digital Design"
 gnus-auto-select-first nil
)

;;{{{ NXML mode setup
(load-library "rng-auto")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))
(add-hook 'nxml-mode-hook (function (lambda ()
                                      (local-set-key "\C-c\C-c" 'comment-region)
                                      (make-local-variable 'truncate-lines)
                                      (setq truncate-lines t)
                                      )))

;;}}}

;; Camel case handling
(defconst camelCase-regexp "\\([A-Z]?[a-z0-9]+\\|[A-Z]+[0-9]*\\)"
  ;; capital must be before uppercase
  "regular expression that matches a CamelCase word, defined as
Capitalized, or UPPERCASE sequence of letters,
or sequence of digits.")

(defun camelCase-forward-word (count)
  "move point foward COUNT camelCase words"
  (interactive "p") 
  ;; search forward increments point until some match occurs;
  ;; extent of match is as large as possible at that point.
  ;; point is left at END of match.
  (if (< count 0)
      (camelCase-backward-word (- count))
    (let ((old-case-fold-search case-fold-search)
	  (case-fold-search nil)) ;; search case sensitively
      (unwind-protect 
	  (when (re-search-forward camelCase-regexp nil t count)
	    ;; something matched, just check for special case.
	    ;; If uppercase acronym is in camelCase word as in "URLNext",
	    ;; search will leave point after N rather than after L.
	    ;; So if match starting back one char doesn't end same place,
	    ;; then back-up one char.
	    (when (save-excursion     
		    (let ((search-end (point)))
		      (forward-char -1)
		      (and (looking-at camelCase-regexp)
			   (not (= search-end (match-end 0))))))
	      (forward-char -1))
	    (point))
	(setq case-fold-search old-case-fold-search)))))

(defun camelCase-backward-word (count) 
  "move point backward COUNT camelCase words"
  (interactive "p") 
  ;; search backward decrements point until some match occurs;
  ;; extent of match is as large as possible at that point.
  ;; So once point is found, have to keep decrementing point until we cross
  ;; into another word, which changes the match end.
  ;; for multiple words, have to do whole thing COUNT times.
  (if (< count 0)
      (camelCase-forward-word (- count))
    (let ((start-position (point))
	  (old-case-fold-search case-fold-search)
	  (case-fold-search nil)) ;; search case-sensitively
      (unwind-protect 
	  (while (< 0 count) 
	    (setq count (1- count))
	    (let ((start (point)))
	      (when (re-search-backward camelCase-regexp nil t)
		(let ((end-word (match-end 0)))
		  (forward-char -1)
		  (while (save-excursion
			   ;;like looking-at, but stop match at start
			   (let ((position (point)))
			     (re-search-forward camelCase-regexp start t)
			     (and (= position (match-beginning 0))
				  (= end-word (match-end 0)))))
		    (forward-char -1))
		  (forward-char 1)))))
	(setq case-fold-search old-case-fold-search))
      (if (= start-position (point)) nil (point)))))

(defun camelise-string (s)
  "Convert under_score or UNDER_SCORE string S to CamelCase string."
  (interactive)
  (mapconcat 'identity (mapcar
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))

(defun camelise () 
  "Convert under_score or UNDER_SCORE string at point to CamelCase string."
  (interactive)
  
  (if (looking-at "\\([A-Za-z_0-9]+\\)\\(_\\(IN\\|OUT\\)\\)\\([^A-Za-z0-9]\\|$\\)")
      (progn 
;;        (message "S1: %S, S2: %S, S3: %S S4: %S" (match-string-no-properties 1) (match-string-no-properties 2) (match-string-no-properties 3) (match-string-no-properties 4) )
;;        (message "MB0: %S ME0: %S ME1: %S ME2: %S" (match-beginning 0) (match-end 0) (match-end 1) (match-end 2))
        (setq s (match-string-no-properties 1))
        (delete-region (match-beginning 0) (if (match-end 2) (match-end 2) (match-end 1)))
        (insert (camelise-string s))
;;        (replace-match (camelise-string s) t nil nil)
        )
    (if (looking-at "\\([A-Za-z_0-9]+\\)")
        (progn
          (setq s (match-string-no-properties 1))
          (delete-region (match-beginning 0) (match-end 0))
          (insert (camelise-string s))
          )
    )))



(defun camel-to-upper-underscore ()
  "Convert CamelCase to UPPER_CASE_WITH_UNDERSCORES."
  (interactive)
  (let ((old-case-fold-search case-fold-search)
        (case-fold-search nil)) ;; search case-sensitively
    (unwind-protect 
        (progn 
          (setq beg 0)
          (setq fin 0)
          (while (looking-at camelCase-regexp)
            (progn
              (setq beg (match-beginning 0))
              (setq fin (match-end 0))
              ;; something matched, just check for special case.
              ;; If uppercase acronym is in camelCase word as in "URLNext",
              ;; search will leave point after N rather than after L.
              ;; So if match starting back one char doesn't end same place,
              ;; then back-up one char.
              (when (save-excursion     
                      (let ((search-end (match-end 0)))
                        (goto-char (1- search-end))
                        (and (looking-at camelCase-regexp)
                             (not (= search-end (match-end 0))))))
                (setq fin (1- fin))
                )
              (insert (upcase (delete-and-extract-region beg fin)))
              (when (looking-at camelCase-regexp)
                (insert "_"))
              ))    
    )))
  )

(global-set-key [f4] `camelise)
(global-set-key [S-f4] `camel-to-upper-underscore)


(defun copy-current-line ()
  "Copy current line."
  (interactive)
  (kill (buffer-substring (point-at-bol) (point-at-eol))))




;; (require 'tabbar)
;; (tabbar-mode)
;; (setq tabbar-buffer-groups-function
;;           (lambda ()
;;             (list "All Buffers")))
;;


;; remove all the buffers starting with "*"
 (setq tabbar-buffer-list-function
     	(lambda ()
     	  (remove-if
     	   (lambda(buffer)
     	     (find (aref (buffer-name buffer) 0) " *"))
     	   (buffer-list))))


;; global linum-mode
;;(add-hook 'find-file-hook (lambda () (linum-mode 1)))
