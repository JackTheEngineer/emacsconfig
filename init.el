(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/")
	     )
(eval-when-compile (require 'use-package))

(add-to-list 'load-path "~/.emacs.d/lisp/")

(load "globalShortcuts")
(load "helperFunctions")
(load "latexStuff")
(load "hledgerConfig")
(load "orgConfig")
(load "htmlExporter")

(add-to-list 'auto-mode-alist '("\\.ucbuild\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))

(use-package deadgrep
  :ensure t
  :init
  :config
  (global-set-key (kbd "<f5>") #'deadgrep))

(use-package exec-path-from-shell
  :ensure t
  :init
  :config
  (when (daemonp)
    (exec-path-from-shell-initialize))
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  )

(use-package ztree
  :ensure t)

(use-package package-utils
  :ensure t
  :init)

(use-package ledger-mode
  :ensure t
  :init)

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("C-o" . ace-window)
  )

(use-package nix-mode
  :ensure t
  :init)

(use-package shakespeare-mode
  :ensure t
  :init)

(use-package elpy
  :ensure t
  :init
  :config
  (elpy-enable)
  :hook (python-mode))

;; The package is "python" but the mode is "python-mode":
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :bind ("M-*" . pop-tag-mark))

(use-package projectile
  :ensure t
  :init
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package ace-jump-mode
  :ensure t
  :init
  :bind ("C-." . ace-jump-mode))

(use-package auto-complete
  :ensure t
  :init (ac-config-default))

(use-package helm
  :ensure t
  :init (helm-mode t)
  :bind (("M-x" . helm-M-x)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-buffers-list)))


(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  (projectile-global-mode)
  (helm-projectile-on)
  :config)

(use-package ggtags
  :ensure t
  :init)

;; (use-package helm-gtags
;;   :ensure t
;;   :init
;;   (setq
;;    helm-gtags-ignore-case t
;;    helm-gtags-auto-update t
;;    helm-gtags-use-input-at-cursor t
;;    helm-gtags-pulse-at-cursor t
;;    helm-gtags-prefix-key "\C-cg"
;;    helm-gtags-suggested-key-mapping t
;;    )
;;   (add-hook 'dired-mode-hook 'helm-gtags-mode)
;;   (add-hook 'eshell-mode-hook 'helm-gtags-mode)
;;   (add-hook 'c-mode-hook 'helm-gtags-mode)
;;   (add-hook 'c++-mode-hook 'helm-gtags-mode)
;;   (add-hook 'asm-mode-hook 'helm-gtags-mode)

;;   (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;;   (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
;;   (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
;;   (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;;   (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
;;   (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
;; )

(use-package flycheck
  :ensure t
  :init)

(use-package helm-flycheck
  :ensure t
  :init)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package haskell-mode
  :ensure t
  :hook ((lsp)
         (interactive-haskell-mode))
  :config
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp))

(use-package which-key
  :ensure t
  :init)

(use-package company
  :ensure t
  :init)

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((haskell-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :init (lsp-ui-mode)
  :config (setq lsp-ui-sideline-show-code-actions nil
                lsp-ui-sideline-update-mode t
                lsp-ui-sideline-show-hover t
                lsp-ui-sideline-show-diagnostics nil
                lsp-ui-peek-show-directory t
;;                lsp-ui-peek-enable t
                lsp-ui-doc-enable nil)
  )

(use-package lsp-haskell
  :ensure t
  :init
  :ensure t)

(use-package yaml-mode
  :ensure t
  :init )

(use-package pdf-tools
  :ensure t
  :init )

(use-package rainbow-delimiters
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-list
   '(("zgl" "makeglossaries %T && %`%l%(mode)%' %T && %V" TeX-run-command nil
      (latex-mode doctex-mode))
     ("ABLTV" "biber %(O?aux) && biber %(O?aux) && %`%l%(mode)%' %T && %V" TeX-run-command nil
      (latex-mode doctex-mode)
      :help "Run BibTex twice, Latex Once")
     ("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %(output-dir) %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %(extraopts) %(o-dir) %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo %(extraopts) %(o-dir) --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "amstex %(PDFout) %`%(extraopts) %S%(mode)%' %(output-dir) %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "%(cntxcom) --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "bibtex %(O?aux)" TeX-run-BibTeX nil
      (plain-tex-mode latex-mode doctex-mode context-mode texinfo-mode ams-tex-mode)
      :help "Run BibTeX")
     ("Biber" "biber %s %(output-dir)" TeX-run-Biber nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run Biber")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-dvips t
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Generate PostScript file")
     ("Dvips" "%(o?)dvips %d -o %f " TeX-run-dvips nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Convert DVI file to PostScript")
     ("Dvipdfmx" "dvipdfmx %d -o %(O?pdf)" TeX-run-dvipdfmx nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Convert DVI file to PDF with dvipdfmx")
     ("Ps2pdf" "ps2pdf %f %(O?pdf)" TeX-run-ps2pdf nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Convert PostScript file to PDF")
     ("Glossaries" "makeglossaries %(O?aux)" TeX-run-command nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run makeglossaries to create glossary file")
     ("Index" "makeindex %(O?idx)" TeX-run-index nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run makeindex to create index file")
     ("upMendex" "upmendex %(O?idx)" TeX-run-index t
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run upmendex to create index file")
     ("Xindy" "texindy %s" TeX-run-command nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run xindy to create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for common mistakes")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(helm-completion-style 'helm)
 '(indent-tabs-mode nil)
 '(ledger-binary-path "/usr/bin/hledger")
 '(lsp-haskell-server-wrapper-function 'identity)
 '(package-selected-packages
   '(fzf ggtags deadgrep ace-window exec-path-from-shell ztree shakespeare-mode nix-mode ledger-mode package-utils hledger-mode which-key mu4e-alert mu4e-column-faces mu4e-conversation mu4e-jump-to-list mu4e-maildirs-extension mu4e-marker-icons mu4e-overview mu4e-query-fragments ox-pandoc ox-report ox-reveal hamlet-mode yaml-mode use-package realgud rainbow-delimiters pdf-tools magit lsp-ui lsp-haskell latexdiff latex-unicode-math-mode latex-pretty-symbols latex-math-preview latex-extra laas helm-projectile helm-lsp helm-flycheck elpy cdlatex bibtex-utils bibtex-completion auctex-lua auctex-latexmk))
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "gray21" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "ADBO" :family "Source Code Pro")))))
