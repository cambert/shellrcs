(setq inhibit-default-init t)
(load "~/.my_emacs")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(asm-comment-char 92)
 '(auto-compression-mode t nil (jka-compr))
 '(backup-by-copying-when-privileged-mismatch nil)
 '(blink-cursor-mode nil)
 '(browse-url-browser-function (quote browse-url-kde))
 '(buffers-menu-max-size 20)
 '(c-echo-syntactic-information-p t)
 '(c-offsets-alist (quote ((substatement-open . 0))))
 '(canlock-password "15e1f94f9892bf8c2956df144de24f5ad8781b73")
 '(case-fold-search t)
 '(compilation-read-command nil)
 '(current-language-environment "English")
 '(default-input-method "latin-1-prefix")
 '(delete-selection-mode t nil (delsel))
 '(display-time-mail-file (quote none))
 '(display-time-mode t nil (time))
 '(find-file-visit-truename t)
 '(focus-follows-mouse nil)
 '(font-lock-support-mode (quote jit-lock-mode))
 '(global-font-lock-mode t nil (font-lock))
 '(gnus-permanently-visible-groups nil)
 '(gnus-summary-ignore-duplicates t)
 '(imenu-max-items 40)
 '(indent-tabs-mode nil)
 '(matlab-fill-code nil)
 '(mouse-avoidance-nudge-dist 5)
 '(mouse-avoidance-nudge-var 2)
 '(mouse-avoidance-threshold 2)
 '(mouse-wheel-mode t nil (mwheel))
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (5 ((shift) . 1) ((control)))))
 '(pc-selection-mode t nil (pc-select))
 '(ps-n-up-printing 1)
 '(scroll-bar-mode (quote right))
 '(scroll-conservatively 10000)
 '(scroll-down-aggressively 0.01)
 '(scroll-margin 1)
 '(shift-select-mode t)
 '(show-paren-mode t nil (paren))
 '(speedbar-use-images nil)
 '(standard-indent 2)
 '(tabbar-mode t nil (tabbar))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(truncate-partial-width-windows nil)
 '(uniquify-buffer-name-style nil nil (uniquify))
 '(verilog-auto-lineup (quote declarations))
 '(verilog-auto-newline nil)
 '(verilog-auto-star-expand nil)
 '(verilog-case-indent 0)
 '(verilog-cexp-indent 3)
 '(verilog-highlight-grouping-keywords nil)
 '(verilog-highlight-p1800-keywords t)
 '(verilog-indent-begin-after-if nil)
 '(verilog-indent-level-declaration 3)
 '(verilog-indent-level-module 3)
 '(verilog-simulator "verilog-IES")
 '(verilog-tab-always-indent t)
 '(vhdl-reset-kind (quote none) t)
 '(vhdl-source-file-menu t)
 '(vhdl-speedbar-display-mode (quote project))
 '(vhdl-speedbar-save-cache (quote (hierarchy)))
 '(vhdl-speedbar-scan-limit (quote (10000000 (10000000 50))))
 '(vhdl-testbench-architecture-name (quote (".*" . "BENCH")))
 '(vhdl-testbench-declarations "\"  signal CLK_RUNNING: boolean := true;\"")
 '(vhdl-testbench-dut-name (quote (".*" . "UUT")))
 '(vhdl-testbench-entity-name (quote (".*" . "\\&_TB")))
 '(vhdl-testbench-include-configuration nil t)
 '(vhdl-testbench-initialize-signals t)
 '(vhdl-testbench-statements "  -- clock generation
  CLK <= not clk after 10 ns;
  CLR <= '0' after 25 ns;
  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here.
    
    wait until CLK = '1';
  end process WaveGen_Proc;
")
 '(vhdl-use-direct-instantiation (quote standard) t))
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(setq make-backup-files         nil) ; Don't want any backup files 
(setq auto-save-list-file-name  nil) ; Don't want any .saves files 
(setq auto-save-default         nil) ; Don't want any auto saving 

(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  ;; (if (and (not (region-active-p)) (not (looking-at "[ \t]*$"))) ; use this line to put comments at the end of the active line
  (if (and (not (region-active-p))) ; use this condition to comment current line every time
      (comment-or-uncomment-region (line-beginning-position) (line-end-position)) 
    (comment-dwim arg)))

(setq column-number-mode t)


;;(setq server-host (system-name)
;;                server-use-tcp t)
;;(server-start)
;; (require 'smooth-scrol)
;; (add-to-list 'load-path "/path/to/drag-stuff")
(require 'drag-stuff)
;; (setq drag-stuff-mode t)
;; (setq drag-stuff-global-mode t)

;; (defun aj-toggle-fold ()
;;   "Toggle fold all lines larger than indentation on current line"
;;   (interactive)
;;   (let ((col 1))
;;     (save-excursion
;;       (back-to-indentation)
;;       (setq col (+ 1 (current-column)))
;;       (set-selective-display
;;        (if selective-display nil (or col 1))))))
;; ;; (global-set-key [(M C i)] 'aj-toggle-fold)

;; ;; if emacs hook will be stucked agai,
;; ;; uncomment the code below, evaluate and byte compile, load 
;; (add-hook 'post-command-hook
;;           (lambda ()
;;             (let ((drag-stuff-commands '(drag-stuff-up drag-stuff-down drag-stuff-left drag-stuff-right)))
;;               (if (member this-command drag-stuff-commands))
;;               (setq dragging-stuff t)
;;               (unless dragging-stuff
;;                 (deactivate-mark)))))

;;(add-hook 'post-command-hook
;;          (lambda ()
;;            (let ((drag-stuff-commands '(drag-stuff-up drag-stuff-down drag-stuff-left drag-stuff-right)))
;;              (unless (member this-command drag-stuff-commands)
;;                  (setq dragging-stuff nil))
;;              (unless dragging-stuff
;;                (deactivate-mark)))))
;;kinda works...
;;(add-hook 'post-command-hook
;;          (lambda ()
;;            (let ((drag-stuff-commands '(drag-stuff-up drag-stuff-down drag-stuff-left drag-stuff-right)))
;;              (if (member this-command drag-stuff-commands)
;;                  (setq dragging-stuff nil))
;;              (unless dragging-stuff
;;                (deactivate-mark)))))
;;                (deactivate-mark)))))
;;                (deactivate-mark)))))


(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun my-horizontal-recenter ()
  "make the point horizontally centered in the window"
  (interactive)
  (let ((mid (/ (window-width) 2))
        (line-len (save-excursion (end-of-line) (current-column)))
        (cur (current-column)))
    (if (< mid cur)
        (set-window-hscroll (selected-window)
                            (- cur mid)))))
(global-set-key (kbd "C-S-l") 'my-horizontal-recenter)




(defun tabbar-move-tab (&optional right)
  "Move current tab to the left or to the right if RIGHT is set."
  (let* ((ctabset nil)
         (ctabs nil)
         (ctab nil)
         (hd nil)
         (tl nil))
    (and 
     (setq ctabset (tabbar-current-tabset 't))
     (setq ctabs (tabbar-tabs ctabset))
     (setq ctab (tabbar-selected-tab ctabset))
     (setq tl ctabs)
     (setq hd '())) ;; nil
    (while (and (cdr tl) (not (eq ctab (car tl))) (not (eq ctab (cadr tl))))
      (setq hd (append hd (list (car tl)))
            tl (cdr tl)))
    (set ctabset
         (cond 
          ((and (not right) (null hd) (eq ctab (car tl)))
           (append (cdr tl) (list (car tl))))
          ((not right)
           (append hd (list (cadr tl)) (list (car tl)) (cddr tl)))
          ((and right (not (cddr tl)))
           (append (list (cadr tl)) hd (list (car tl))))
          ((and right (eq ctab (car tl)))
           (append hd (list (cadr tl)) (list (car tl)) (cddr tl)))
          (right
           (append hd (list (car tl)) (list (caddr tl)) (list (cadr tl)) (cdddr tl)))
          ))
    (put ctabset 'template nil)
    ;; (tabbar-display-update)
    ))

(defun tabbar-move-tab-right ()
  "Move tab right."
  (interactive)
  (tabbar-move-tab t))
(defun tabbar-move-tab-left ()
  "Move tab left."
  (interactive)
  (tabbar-move-tab))

(fset 'go-to-imenu-function
   [S-f2 ?` ?\M-x ?i ?m ?e ?n ?u return ?c ?l ?a tab ?f ?p tab return return])
(global-set-key (kbd "<S-f3>") 'go-to-imenu-function)

;; use home button to go to very beginning of the line
;; change required for emacs 24.3
(define-key global-map [home] 'beginning-of-line)

;; self defined macros
(fset 'move-text-up
   [?\C-w up home ?\C-v])
(fset 'move-text-down
   [?\C-w down home ?\C-v])
(fset 'comment-curr-line
   [home S-down ?\M-x ?c ?o ?m ?m tab ?e tab ?d ?w tab return up home])
(fset 'goto-prev-buffer
   [?\C-x ?b return])
(fset 'delete-current-line
      [?\M-x ?m ?o ?v ?e ?- ?b ?e ?g ?i tab return S-down backspace])
(fset 'select_complete_word_macro
      ;; emacs 24.1
      ;; ['left-word 'set-mark-command 'forward-sexp 'copy-region-as-kill]
      ;; ;; emacs 23.1.1
      [?\C-s ?\C-w C-left ?\C-\M-@ ?\M-w ?\C-s ?\M-y ?\C-r ?\C-x])

(fset 'go-to-file
   [?\M-x ?f ?f ?a ?p return return])
(fset 'go-to-file-with-register
   [?\M-x ?p ?o ?i ?n ?t ?- ?t ?o ?- ?r ?e tab return ?` ?\M-x ?g ?o ?- ?t ?o ?- ?f ?i ?l tab return])

(fset 'gen-dot-graph
   [?\M-x ?s ?h ?e ?l tab return ?d ?o ?t ?  ?- ?T ?p ?d ?f ?  ?u ?n ?i ?f ?i ?e tab ?g ?v ?  ?- ?o ?  ?u ?n ?i ?f tab ?p ?d ?f return M-left])

;; added global-font-lock toggle at the end to make sure YAML is also syntax highlighted in Emacs 26.2 - nasty hack!
(fset 'map-bindings
      [?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-. ?c ?o ?m ?m ?e tab ?d ?w tab ?- tab tab return ?\M-x ?g ?l ?o ?b tab ?s ?e tab return S-delete ?b ?a ?c ?k ?w tab ?d ?e ?l tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-/ ?c ?o ?m ?m tab ?e ?d backspace tab ?d ?w ?i tab ?- tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-, ?c ?o ?m ?m tab ?e tab ?d ?w tab ?- tab return ?\M-x ?g ?l ?o tab ?s ?e tab return M-left ?g ?o ?t tab ?p ?r ?e tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\M-  ?d ?a ?b ?b tab ?e ?x tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\S-\C-d ?d ?e ?l ?e tab ?c ?u ?r ?r tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\M-c ?s ?h ?e tab ?- ?c ?o ?m tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\S-\M-w ?c ?l ?i tab ?k ?i tab ?i return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-e ?s ?e ?l ?e tab ?_ tab return  ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-< ?p ?y ?t tab ?s ?h ?i tab ?l tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-> ?p ?y ?t tab ?s ?h ?i tab ?r tab return  ?\M-x ?g ?l ?o tab ?s ?e tab return f9 ?g ?e ?n ?- ?d ?o tab return ?\M-x ?g ?l ?o tab ?f ?o ?n tab return  ?\M-x ?g ?l ?o tab ?f ?o ?n tab return])

(fset 'convert-hex-to-readmemh
   [C-S-right S-right S-right delete C-S-right ?\C-w delete C-right ?\C-v return delete C-S-right ?\C-w delete C-right ?\C-v right])


;; [?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-. ?c ?o ?m ?m ?e tab ?d ?w tab ?- tab tab return ?\M-x ?g ?l ?o ?b tab ?s ?e tab return S-delete ?b ?a ?c ?k ?w tab ?d ?e ?l tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-/ ?c ?o ?m ?m tab ?e ?d backspace tab ?d ?w ?i tab ?- tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-, ?c ?o ?m ?m tab ?e tab ?d ?w tab ?- tab return ?\M-x ?g ?l ?o tab ?s ?e tab return M-left ?g ?o ?t tab ?p ?r ?e tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\M-  ?d ?a ?b ?b tab ?e ?x tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\S-\C-d ?d ?e ?l ?e tab ?c ?u ?r ?r tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\M-c ?s ?h ?e tab ?- ?c ?o ?m tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\S-\M-w ?c ?l ?i tab ?k ?i tab ?i return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-e ?s ?e ?l ?e tab ?_ tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?g ?o ?- tab return])
;; the first function is for x-clipboard-yank, removed in ARM
;; [?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-\S-v ?x ?- ?c tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-. ?c ?o ?m ?m ?e tab ?d ?w tab ?- tab tab return ?\M-x ?g ?l ?o ?b tab ?s ?e tab return S-delete ?b ?a ?c ?k ?w tab ?d ?e ?l tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-/ ?c ?o ?m ?m tab ?e ?d backspace tab ?d ?w ?i tab ?- tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-, ?c ?o ?m ?m tab ?e tab ?d ?w tab ?- tab return ?\M-x ?g ?l ?o tab ?s ?e tab return M-left ?g ?o ?t tab ?p ?r ?e tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\M-  ?d ?a ?b ?b tab ?e ?x tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\S-\C-d ?d ?e ?l ?e tab ?c ?u ?r ?r tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\M-c ?s ?h ?e tab ?- ?c ?o ?m tab return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\S-\M-w ?c ?l ?i tab ?k ?i tab ?i return ?\M-x ?g ?l ?o tab ?s ?e tab return ?\C-e ?s ?e ?l ?e tab ?_ tab return])
(fset 'highlight-selection
      [?\M-x ?h ?i ?g ?h tab ?r ?e tab return up return return ?\M-x ?u ?n ?h ?i ?g ?h tab ?r ?e return return ?\C-e ?\M-x ?h ?i ?g ?h tab ?r ?e tab return ?\C-v return])
(fset 'unhighlight-selection
      [?\M-x ?u ?n ?h ?i ?g ?h tab ?r ?e tab return down up return])
(global-set-key "\C-a" 'highlight-selection)
;; the way to use in combination with shift
(global-set-key [?\S-\C-a] 'unhighlight-selection)

(global-set-key (kbd "<C-M-right>") 'tabbar-move-tab-right) 
(global-set-key (kbd "<C-M-left>") 'tabbar-move-tab-left) 

(global-set-key (kbd "<C-tab>") 'next-multiframe-window) 
(global-set-key (kbd "<C-S-tab>") 'previous-multiframe-window) 
;; (global-set-key (kbd "<C-S-up>") 'move-text-up)
;; (global-set-key (kbd "<C-S-down>") 'move-text-down)
(global-set-key (kbd "<C-backspace>") 'backward-kill-word)
(global-set-key (kbd "<S-delete>") 'backward-delete-char)
;; (global-set-key "\M-S-d" 'kill-whole-line)
(global-set-key "\M-d" 'duplicate-current-line-or-region)
(global-set-key "\M-;" 'comment-dwim-line)
(global-set-key "\C-b" 'switch-to-buffer)
;; (global-set-key "\M-." 'dabbrev-expand)
(global-set-key "\M-." 'comment-dwim-line)
(global-set-key "\M-c" 'shell-command)

(global-set-key [f7] 'comment-dwim-line)
(global-set-key "\M-1" 'tabbar-backward-tab)
(global-set-key "\M-2" 'tabbar-forward-tab)
(global-set-key "\M-3" 'tabbar-backward-group)
(global-set-key "\M-4" 'tabbar-forward-group)
;; (require 'bookmark+)
;; (require 'bm)
;; (global-set-key [S-f2] 'bookmark-set)
;; (global-set-key [f2] 'bookmark-jump)
;; (global-set-key [f3] 'bookmark-jump)
(global-set-key [S-f2] 'point-to-register)
(global-set-key [f2] 'jump-to-register)
(global-set-key [f3] 'go-to-file-with-register)
(require 'linum)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#444") 
;; (set-face-background 'hl-line "#330") 
(global-set-key "\M-a" 'align-regexp)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-v" 'yank)
;; NOTE: shift key wont work using assignments below, use executable macro instead
;;(global-set-key (kbd "<C-S-n>") 'x-clipboard-yank)
;;(global-set-key (kbd "C-N") 'select-next-window)
;; (global-set-key "\C-l" 'global-linum-mode)
;; (global-set-key "\C-k" 'scroll-bar-mode)
(global-linum-mode)
;; (toggle-truncate-lines)
(setq-default word-wrap 0)
(setq verilog-auto-endcomments nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-margin 0
      scroll-conservatively 1
      scroll-down-aggressively 0.01
      scroll-up-aggressively 0.01)
;; ;; previous settings
;; (setq scroll-margin 1
;;       scroll-conservatively 0
;;       scroll-down-aggressively 0.01
;;       scroll-up-aggressively 0.01)
(setq visible-bell t)
(tool-bar-mode -1)
(scroll-bar-mode 1)
;; do not create temp autosave files
(setq auto-save-default nil) 
(setq-default truncate-lines 0)
;; (menu-bar-mode -1)
(desktop-save-mode 1)
(global-auto-revert-mode t)
;; (setq load-path (cons (expand-file-name "~/emacs") load-path))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(hl-line ((t (:inherit highlight :background "#444"))))
 '(tabbar-default ((t (:Inherit Variable-pitch :background "gray70" :foreground "black" :box (:line-width 1 :color "grey30") :height 1.1))))
 '(tabbar-default-face ((t (:Inherit Variable-pitch :background "gray72" :foreground "gray10" :height 1.2))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "gray10" :foreground "gray90" :box (:line-width 3 :color "grey10") :height 1.0))))
 '(tabbar-selected-face ((t (:inherit variable-pitch :height 1.2))))
 '(tabbar-unselected ((t (:inherit tabbar-default :box (:line-width 4 :color "gray70"))))))
;; (put 'downcase-region 'disabled nil)


;; ;; https://elpy.readthedocs.io/en/latest/introduction.html
;; ;; python package
;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))




;; MOVE TEXT UP AND DOWN
;; https://stackoverflow.com/questions/2423834/move-line-region-up-and-down-in-emacs
(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))
(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))
(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))
;; ;; USING DRAG-STAFF
;; (global-set-key (kbd "<C-S-up>") 'drag-stuff-up)
;; (global-set-key (kbd "<C-S-down>") 'drag-stuff-down)
;; (global-set-key (kbd "<M-up>") 'drag-stuff-up)
;; (global-set-key (kbd "<M-down>") 'drag-stuff-down)

(global-set-key (kbd "<C-S-up>") 'move-text-up)
(global-set-key (kbd "<C-S-down>") 'move-text-down)
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)

;; use this macro to toggle global-font-lock mode off and on when not applied automatically to YAML files
(fset 'macro-global-font-lock
   [?\M-x ?g ?l ?o ?b tab ?f ?o ?n tab return ?\M-x ?g ?l ?o ?b ?a tab ?f ?o ?n tab return])
(global-set-key "\M-q" 'macro-global-font-lock)

;; Pull from PRIMARY (same as middle mouse click)
;; https://stackoverflow.com/questions/28403647/emacs-25-yank-from-x-windows-primary-clipboard-buffer-with-keyboard
(defun get-primary ()
  (interactive)
  (insert
   (gui-get-primary-selection)))

;; USE THE FOLLOWING TO DIFFERENTIATE BETWEEN CTRL-V AND CTRL-SHIFT-V
;; (global-set-key "\C-S-v" 'get-primary)
(global-set-key (kbd "C-S-v") 'get-primary)
(global-set-key (kbd "C-v") 'yank)
