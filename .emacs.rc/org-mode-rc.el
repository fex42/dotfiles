(global-set-key (kbd "C-x a") 'org-agenda)

(setq org-agenda-files (list "~/Documents/Agenda/"))

(setq org-export-backends '(md))

(custom-set-variables
 '(org-modules
   (quote
    (org-bbdb
     org-bibtex
     org-docview
     org-gnus
     org-habit
     org-info
     org-irc
     org-mhe
     org-rmail
     org-w3m)))
 '(org-enforce-todo-dependencies t)
 '(org-agenda-exporter-settings
   (quote ((org-agenda-tag-filter-preset (list "+personal"))))))

(defun rc/org-increment-move-counter ()
  (interactive)

  (defun default (x d)
    (if x x d))

  (let* ((point (point))
         (move-counter-name "MOVE_COUNTER")
         (move-counter-value (-> (org-entry-get point move-counter-name)
                                 (default "0")
                                 (string-to-number)
                                 (1+))))
    (org-entry-put point move-counter-name
                   (number-to-string move-counter-value)))
  nil)

(defun rc/org-get-heading-name ()
  (nth 4 (org-heading-components)))

(defun rc/org-kill-heading-name-save ()
  (interactive)
  (let ((heading-name (rc/org-get-heading-name)))
    (kill-new heading-name)
    (message "Kill \"%s\"" heading-name)))

(global-set-key (kbd "C-x p w") 'rc/org-kill-heading-name-save)

(setq org-agenda-custom-commands
      '(("u" "Unscheduled" tags "+personal-SCHEDULED={.+}-DEADLINE={.+}/!+TODO"
         ((org-agenda-sorting-strategy '(priority-down))))
        ("p" "Personal" ((agenda "" ((org-agenda-tag-filter-preset (list "+personal"))))))
        ("w" "Work" ((agenda "" ((org-agenda-tag-filter-preset (list "+work"))))))
        ))
