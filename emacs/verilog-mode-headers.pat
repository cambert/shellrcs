--- verilog-mode-513.el	2009-06-02 12:57:11.547149000 +0100
+++ verilog-mode.el	2009-06-02 13:29:33.910426000 +0100
@@ -6139,62 +6139,43 @@
   (interactive)
   (let ((start (point)))
   (insert "\
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
+/* ************************************************************************* *
+   Copyright (c) <copydate> by <company> 
 
+   FILE
+      <filename>
+
+   DESCRIPTION
+      <cursor>
+
+   MODIFICATIONS
+      1.0   <credate>  <user>  Created
+
+
+* ************************************************************************* */
 ")
     (goto-char start)
+    (search-forward "<copydate>") 
+    (replace-match "" t t)
+    (verilog-insert-year)
+    (goto-char start)
+    (search-forward "<company>")
+    (replace-match verilog-company t t)
+    (goto-char start)
     (search-forward "<filename>")
     (replace-match (buffer-name) t t)
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
+    (goto-char start)
+    (search-forward "<credate>")
+    (replace-match "" t t)
     (verilog-insert-date)
-    (insert " : created")
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
-
+    (search-forward "<user>")
+    (replace-match "" t t)
+    (insert (user-full-name))
+    (goto-char start)
+    (search-forward "<cursor>"))
+    (replace-match "" t t)
+)
 ;; verilog-header Uses the verilog-insert-date function
 
 (defun verilog-insert-date ()
@@ -7678,7 +7659,8 @@
 					    (file-name-directory current))
 		   chkexts (if check-ext verilog-library-extensions `("")))
 	     (while chkexts
-	       (setq fn (expand-file-name (concat filename (car chkexts))
+               ;; TCC
+	       (setq fn (expand-file-name (concat (downcase filename) (car chkexts))
 					  chkdir))
 	       ;;(message "Check for %s" fn)
 	       (if (verilog-dir-file-exists-p fn)
