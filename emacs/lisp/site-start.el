; Tcl/tk
(setq auto-mode-alist (cons '("\\.tk$" . tcl-mode) auto-mode-alist))
;;   To invoke tcl-mode automatically on .do files, do this:
(setq auto-mode-alist (cons '("\\.do$" . tcl-mode) auto-mode-alist))
; HTML helper mode
(autoload 'html-helper-mode "html-helper-mode" "HTML helper mode" t)
;;   To invoke html-helper-mode automatically on .html files, do this:
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;;   To invoke html-helper-mode automatically on .asp files, do this:
(setq auto-mode-alist (cons '("\\.asp$" . html-helper-mode) auto-mode-alist))
;;   To invoke html-helper-mode automatically on .phtml files, do this:
(setq auto-mode-alist (cons '("\\.phtml$" . html-helper-mode) auto-mode-alist))
(setq html-helper-use-expert-menu t)
(setq html-helper-htmldtd-version "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd\">
")
(setq html-helper-timestamp-hook 'my-html-helper-insert-timestamp)
(setq html-helper-new-buffer-template
  '(html-helper-htmldtd-version
    "<html> <head>\n"
    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\n" 
    "<title>" p "</title>\n</head>\n\n"
    "<body>\n"
    "<h1>" p "</h1>\n\n"
    p
    "\n\n<hr>\n"
    "<address>" html-helper-address-string "</address>\n"
    html-helper-timestamp-start
    html-helper-timestamp-end
    "\n</body> </html>\n"))

(defun my-html-helper-insert-timestamp ()
  "Default timestamp insertion function."
  (let ((time (current-time-string)))
    (insert "Last modified: "
	    (substring time 0 10)
	    " "
	    (substring time -4)
	    " ")))
; Matlab mode
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

;; VHDL mode setup
(setq vhdl-clock-edge-condition (quote function))
(setq vhdl-clock-name "CLK")
(setq vhdl-reset-active-high t)
(setq vhdl-reset-kind (quote sync))
(setq vhdl-reset-name "CLR")
(setq vhdl-standard (quote (93 nil)))
(setq vhdl-company-name "CSR Ltd.")
(setq vhdl-upper-case-enum-values t)
(setq vhdl-upper-case-types nil)
(setq vhdl-use-direct-instantiation (quote never))
(setq vhdl-compiler "Synopsys")
(setq vhdl-platform-spec "VHDL 1993; Synopsys VCS")
(setq vhdl-copyright-string "-- Copyright (c) <year> <company> CSR Ltd. All rights reserved.")

(setq vhdl-file-header "------------------------------------------------------------------------------
-- CONFIDENTIAL
<copyright>
------------------------------------------------------------------------------
-- Title       : <block_title string>
-- Project     : Digital Cellular
--
------------------------------------------------------------------------------
-- File        : <filename>
-- Author      : <author>
-- Created     : <date>
------------------------------------------------------------------------------
-- Description : <cursor>
--               
--
------------------------------------------------------------------------------
-- Modification history :
--  
--  <date> <author>.
--  Initial version.
--
------------------------------------------------------------------------------

")

;; Verilog setup
;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
(setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
