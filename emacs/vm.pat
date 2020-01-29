--- verilog-mode-735.el.orig	2011-12-23 11:11:24.953550000 +0000
+++ verilog-mode-735.el	2011-12-23 11:14:23.423486000 +0000
@@ -6436,15 +6436,20 @@
 	       ((or (and verilog-indent-declaration-macros
 			 (looking-at verilog-declaration-re-2-macro))
 		    (looking-at verilog-declaration-re-2-no-macro))
-		(let ((p (match-end 0)))
+		(let ((p (match-end 0)) mbits)
 		  (set-marker m1 p)
 		  (if (verilog-re-search-forward "[[#`]" p 'move)
 		      (progn
 			(forward-char -1)
 			(just-one-space)
+                        (setq mbits (point))
 			(goto-char (marker-position m1))
 			(just-one-space)
-			(indent-to ind))
+                        (if (< (current-column) ind)
+                            (let ((spaces (- ind (current-column))))
+                              (goto-char mbits)
+                              (indent-to (+ (current-column) spaces)))
+                          (indent-to ind)))
 		    (progn
 		      (just-one-space)
 		      (indent-to ind)))))
@@ -6610,29 +6615,39 @@
 	      (indent-line-to val)
 	      (if (and verilog-indent-declaration-macros
 		       (looking-at verilog-declaration-re-2-macro))
-		  (let ((p (match-end 0)))
+		  (let ((p (match-end 0)) mbits)
 		    (set-marker m1 p)
 		    (if (verilog-re-search-forward "[[#`]" p 'move)
 			(progn
 			  (forward-char -1)
 			  (just-one-space)
+			  (setq mbits (point))
 			  (goto-char (marker-position m1))
 			  (just-one-space)
-			  (indent-to ind))
+			  (if (< (current-column) ind)
+			      (let ((spaces (- ind (current-column))))
+				(goto-char mbits)
+				(indent-to (+ (current-column) spaces)))
+			  (indent-to ind)))
 		      (if (/= (current-column) ind)
 			  (progn
 			    (just-one-space)
 			    (indent-to ind)))))
 		(if (looking-at verilog-declaration-re-2-no-macro)
-		    (let ((p (match-end 0)))
+		    (let ((p (match-end 0)) mbits)
 		      (set-marker m1 p)
 		      (if (verilog-re-search-forward "[[`#]" p 'move)
 			  (progn
 			    (forward-char -1)
 			    (just-one-space)
+			    (setq mbits (point))
 			    (goto-char (marker-position m1))
 			    (just-one-space)
-			    (indent-to ind))
+			    (if (< (current-column) ind)
+				(let ((spaces (- ind (current-column))))
+				  (goto-char mbits)
+				  (indent-to (+ (current-column) spaces)))
+			      (indent-to ind)))
 			(if (/= (current-column) ind)
 			    (progn
 			      (just-one-space)
@@ -7323,66 +7338,58 @@
   "Insert a standard Verilog file header.
 See also `verilog-sk-header' for an alternative format."
   (interactive)
-  (let ((start (point)))
-  (insert "\
-//-----------------------------------------------------------------------------
-// Title         : <title>
-// Project       : <project>
-//-----------------------------------------------------------------------------
-// File          : <filename>
-// Author        : <author>
-// Created       : <credate>
-// Last modified : <moddate>
-//-----------------------------------------------------------------------------
-// Description :
-// <description>
-//-----------------------------------------------------------------------------
-// Copyright (c) <copydate> by <company> This model is the confidential and
-// proprietary property of <company> and the possession or use of this
-// file requires a written license from <company>.
-//------------------------------------------------------------------------------
-// Modification history :
-// <modhist>
-//-----------------------------------------------------------------------------
+  (let 
+      ((start (point))
+       (end 0))
+    (insert "\
+/* ************************************************************************* *
+   COMMERCIAL IN CONFIDENCE
+   Copyright (c) <copydate> by <company> 
+   All rights reserved
+
+   ATTRIBUTES
+      $Id: <filename>$
+      $Change: $
+      $Author: $
+      $DateTime: $
+
+   DESCRIPTION
+      <cursor>
+
+   MODIFICATIONS
+      1.0   <credate>  <user>  Created
 
+
+* ************************************************************************* */
 ")
+    (setq end (point))
+    (goto-char start)
+    (while (search-forward "<copydate>" end t) 
+      (replace-match "" end t)
+      (verilog-insert-year))
+    (goto-char start)
+    (while (search-forward "<company>" end t)
+      (replace-match verilog-company end t))
     (goto-char start)
-    (search-forward "<filename>")
-    (replace-match (buffer-name) t t)
-    (search-forward "<author>") (replace-match "" t t)
-    (insert (user-full-name))
-    (insert "  <" (user-login-name) "@" (system-name) ">")
-    (search-forward "<credate>") (replace-match "" t t)
-    (verilog-insert-date)
-    (search-forward "<moddate>") (replace-match "" t t)
-    (verilog-insert-date)
-    (search-forward "<copydate>") (replace-match "" t t)
-    (verilog-insert-year)
-    (search-forward "<modhist>") (replace-match "" t t)
-    (verilog-insert-date)
-    (insert " : created")
+    (while (search-forward "<filename>" end t)
+      (replace-match (buffer-name) end t))
     (goto-char start)
-    (let (string)
-      (setq string (read-string "title: "))
-      (search-forward "<title>")
-      (replace-match string t t)
-      (setq string (read-string "project: " verilog-project))
-      (setq verilog-project string)
-      (search-forward "<project>")
-      (replace-match string t t)
-      (setq string (read-string "Company: " verilog-company))
-      (setq verilog-company string)
-      (search-forward "<company>")
-      (replace-match string t t)
-      (search-forward "<company>")
-      (replace-match string t t)
-      (search-forward "<company>")
-      (replace-match string t t)
-      (search-backward "<description>")
-      (replace-match "" t t))))
+    (while (search-forward "<credate>" end t)
+      (replace-match "" end t)
+      (verilog-insert-date))
+    (goto-char start)
+    (while (search-forward "<year>" end t)
+      (replace-match "" end t)
+      (verilog-insert-year))
+    (goto-char start)
+    (while (search-forward "<user>" end t)
+      (replace-match (user-full-name) end t))
+    (goto-char start)
+    (search-forward "<cursor>" end t)
+    (replace-match "" t t)
+    ))
 
 ;; verilog-header Uses the verilog-insert-date function
-
 (defun verilog-insert-date ()
   "Insert date from the system."
   (interactive)
@@ -9108,7 +9115,8 @@
 					    (file-name-directory current))
 		   chkexts (if check-ext verilog-library-extensions `("")))
 	     (while chkexts
-	       (setq fn (expand-file-name (concat filename (car chkexts))
+               ;; TCC
+	       (setq fn (expand-file-name (concat (downcase filename) (car chkexts))
 					  chkdir))
 	       ;;(message "Check for %s" fn)
 	       (if (verilog-dir-file-exists-p fn)
