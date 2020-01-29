(defun find-file-dialog-box ()
  "Pop open a dialog box to locate a file, for windows users."
  (interactive)
  (progn (let (dialog-file-name tmp-buf)
	   (save-excursion
	     (setq dialog-file-name
		   (eval
		    (condition-case err 
			(progn
			  (setq tmp-buf (generate-new-buffer "dialog-tmp"))
			  (shell-command "xgetfile" tmp-buf)
			  (set-buffer tmp-buf)
			  (buffer-substring-no-properties 
			   (point-min) (progn (end-of-line) (point))))
		      (error nil))))
	     (kill-buffer tmp-buf)
	     (if dialog-file-name (find-file dialog-file-name))))))
