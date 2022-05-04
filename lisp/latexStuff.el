;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; (require 'tex-mik)
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)

;; (require 'tex)
;; (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;; (setq TeX-PDF-mode t
;;       TeX-source-correlate-method 'synctex
;;       TeX-source-correlate-start-server t)

;; (fset 'latex-inline-math
;;    (kmacro-lambda-form [?$ ?$ ?\C-b] 0 "%d"))
