(defun do-html-export ()
  (interactive)
  (save-buffer)
  (revert-buffer nil t nil)
  (org-update-all-dblocks)
  (setq filename (org-html-export-to-html nil nil nil t nil))
  (message "%s" dbconnstring)
  (shell-command (format "statusDeployment -f %s -c %s -d %s" filename clientname dbconnstring))
  )
