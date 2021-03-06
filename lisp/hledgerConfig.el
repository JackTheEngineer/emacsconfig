;; (use-package hledger-mode
;;   :ensure t
;;   :init)

;; ;; To open files with .journal extension in hledger-mode
;; (add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))

;; ;; Provide the path to you journal file.
;; ;; The default location is too opinionated.
;; (setq hledger-jfile "/home/jakov/selfemployment/bookkeeping/hledger.journal")

;; ;;; Auto-completion for account names
;; ;; For company-mode users,
;; ;; (add-to-list 'company-backends 'hledger-company)

;; (add-hook 'hledger-mode-hook
;;           (lambda () ((local-set-key (kbd "C-c e") 'hledger-jentry)
;;                       (local-set-key (kbd "C-c j") 'hledger-run-command))))

(use-package hledger-mode
  :pin manual
  :after htmlize
  :load-path "packages/rest/hledger-mode/"
  :mode ("\\.journal\\'" "\\.hledger\\'")
  :commands hledger-enable-reporting
  :preface
  (defun hledger/next-entry ()
    "Move to next entry and pulse."
    (interactive)
    (hledger-next-or-new-entry)
    (hledger-pulse-momentary-current-entry))

  (defface hledger-warning-face
    '((((background dark))
       :background "Red" :foreground "White")
      (((background light))
       :background "Red" :foreground "White")
      (t :inverse-video t))
    "Face for warning"
    :group 'hledger)

  (defun hledger/prev-entry ()
    "Move to last entry and pulse."
    (interactive)
    (hledger-backward-entry)
    (hledger-pulse-momentary-current-entry))

  :bind (("C-c j" . hledger-run-command)
         :map hledger-mode-map
         ("C-c e" . hledger-jentry)
         ("M-p" . hledger/prev-entry)
         ("M-n" . hledger/next-entry))
  :init
  (setq hledger-jfile "/home/jakov/selfemployment/bookkeeping/hledger.journal")
  ;; Expanded account balances in the overall monthly report are
  ;; mostly noise for me and do not convey any meaningful information.
  (setq hledger-show-expanded-report nil)

  (when (boundp 'my-hledger-service-fetch-url)
    (setq hledger-service-fetch-url
          my-hledger-service-fetch-url))

  :config
  (add-hook 'hledger-view-mode-hook #'hl-line-mode)
  (add-hook 'hledger-view-mode-hook #'center-text-for-reading)

  ;; (add-hook 'hledger-view-mode-hook
  ;;           (lambda ()
  ;;             (run-with-timer 1
  ;;                             nil
  ;;                             (lambda ()
  ;;                               (when (equal hledger-last-run-command
  ;;                                            "balancesheet")
  ;;                                 ;; highlight frequently changing accounts
  ;;                                 (highlight-regexp "^.*\\(savings\\|cash\\).*$")
  ;;                                 (highlight-regexp "^.*credit-card.*$"
  ;;                                                   'hledger-warning-face))))))

  (add-hook 'hledger-mode-hook
            (lambda ()
              (make-local-variable 'company-backends)
              (add-to-list 'company-backends 'hledger-company))))

(use-package hledger-input
  :pin manual
  :load-path "packages/rest/hledger-mode/"
  :bind (("C-c e" . hledger-capture)
         :map hledger-input-mode-map
         ("C-c C-b" . popup-balance-at-point))
  :preface
  (defun popup-balance-at-point ()
    "Show balance for account at point in a popup."
    (interactive)
    (if-let ((account (thing-at-point 'hledger-account)))
        (message (hledger-shell-command-to-string (format " balance -N %s "
                                                          account)))
      (message "No account at point")))

  :config
  (setq hledger-input-buffer-height 20)
  (add-hook 'hledger-input-post-commit-hook #'hledger-show-new-balances)
  (add-hook 'hledger-input-mode-hook #'auto-fill-mode)
  (add-hook 'hledger-input-mode-hook
            (lambda ()
              (make-local-variable 'company-idle-delay)
              (setq-local company-idle-delay 0.1))))
