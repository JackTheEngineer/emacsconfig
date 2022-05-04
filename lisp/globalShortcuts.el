(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(global-set-key (kbd "C-|") 'toggle-window-split)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'join-line)
(global-set-key (kbd "C-DEL") 'kill-whitespace)


(keyboard-translate ?\C-n ?\C-j)
(keyboard-translate ?\C-j ?\C-n)
(keyboard-translate ?\C-l ?\C-p)
(keyboard-translate ?\C-p ?\C-l)

(global-linum-mode 1)
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(capitalized-words-mode 1)
(blink-cursor-mode 0)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore) ;; shut up the bell
(set-face-attribute 'default nil :family "Source Code Pro")
(setq initial-scratch-message "")
(set-face-attribute 'default nil :height 120)
(setq indent-tabs-mode nil)
(setq default-tab-width 4)

(setq smerge-command-prefix "C-c C-v")

(defun kill-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
        (progn
          (re-search-backward "[^ \t\r\n]" nil t)
          (re-search-forward "[ \t\r\n]+" nil t)
          (replace-match " " nil nil))))))
