(setq org-hide-leading-stars t
      org-startup-indented t
      ; org-use-fast-todo-selection t
      org-display-inline-images t
      org-export-allow-bind-keywords t)

(setq org-todo-keywords
        '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")
          (sequence "TASK(f)" "|" "DONE(d)")
          (sequence "QUESTION(q)" "|" "ANSWERED(a)")
          (sequence "MAYBE(m)" "|" "CANCELLED(c)")))

(setq org-agenda-files
      '(;"~/studium/MasterThesis/report/Schedule.org"
        ;"~/studium/MasterThesis/report/report.org"
        "~/selfemployment/agenda.org"
        ))

(setq org-time-clocksum-use-effort-durations t)
(setq org-effort-durations
      '(("min" . 1)
        ("h" . 60)
        ("d" . 480)
        ("w" . 2400)
        ("m" . 10435.2)
        ("y" . 125222.4)))
