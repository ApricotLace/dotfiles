;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Evgeny Mukha"
      user-mail-address "Profunctorlense@gmail.com")

(setq enable-local-variables t)

(setq doom-font (font-spec :family "Iosevka" :size 16 :antialias="on"))

(setq display-line-numbers-type nil)

(setq doom-theme 'doom-plain)

(setq initial-frame-alist
      '((top . 30) (left . 15) (width . 122) (height . 29)))

(setq-default delete-by-moving-to-trash t                      ; Delete files to trash
              uniquify-buffer-name-style 'forward              ; Uniquify buffer names
              window-combination-resize t                      ; take new window space from all other windows (not just current)
              ;; x-stretch-cursor t
              )                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…"
      )


(after! cider
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (remove-hook 'cider--debug-mode-hook #' evil-normalize-keymaps)
  (remove-hook 'cider--debug-mode-hook #' +clojure--cider-setup-debug)
  (set-popup-rule! "^\\*cider-repl*" :size 0.4 :side 'right :select t :quit nil :ttl nil)
  (set-popup-rule! "^\\*cider-error*" :size 0.4 :side 'bottom :select t :quit t)
  (setq cljr-assume-language-context 'clj)

  (setq cider-eldoc-display-for-symbol-at-point nil) ; disable cider showing eldoc during symbol at point

  (setq clojure-indent-style 'align-arguments)
  (setq clojure-align-forms-automatically nil)
  )

(after! lsp-ui
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-show-with-mouse nil)
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-lens-enable t)
  (setq lsp-semantic-tokens-enable nil)


  (setq lsp-eldoc-enable-hover nil) ; disable lsp-mode showing eldoc during symbol at point
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-modeline-code-actions-enable nil)

  )





(set-popup-rule! "^\\*help*" :size 0.4 :side 'bottom :select t :quit t)
(set-popup-rule! "^\\*info*" :size 0.7 :side 'bottom :select t :quit t)
(set-popup-rule! "^sql-result*" :size 0.6 :side 'right :select nil :quit nil)
(set-popup-rule! "^\\*Flycheck*" :size 0.3 :side 'bottom :select t :quit t)
(set-popup-rule! ".*Process.*" :size 0.3 :side 'bottom :select t :quit t)



(defun my/cl-comment ()
  (interactive)
  (insert "#_"))

(defun my/kill-insert ()
  (interactive)
  (sp-kill-sexp)
  (evil-insert 1))

(defun my/kill-insert-hybrid ()
  (interactive)
  (sp-kill-hybrid-sexp 1)
  (evil-insert 1))

(map! (:localleader
       (:map (clojure-mode-map clojurescript-mode-map)
        "=" #'cider-format-defun
        "+" #'clojure-align
        (:prefix ("e" . "eval")
         "f" #'cider-eval-defun-at-point
         "F" #'cider-insert-defun-in-repl
         ";" #'cider-pprint-eval-last-sexp-to-comment)
        (:prefix ("i")
         "p" #'cider-inspector-pop))
       (:map (sql-mode-map)
        ;; "e" #'run-sql
        :v "v" #'sql-send-region
        :n "e" #'sql-send-paragraph
        "c" #'sql-connect))
      (:leader
       (:map (clojure-mode-map clojurescript-mode-map emacs-lisp-mode-map)
        (:prefix ("l" . "lsp")
         "r" #'lsp-ui-peek-find-references)
        (:prefix ("m" . "cider")
         "e ;" #'cider-pprint-eval-last-sexp)
        (:prefix ("k" . "lisp")
         "t" #'sp-transpose-sexp
         "j" #'paredit-join-sexps
         "c" #'paredit-split-sexp
         "d" #'paredit-kill
         "<" #'paredit-backward-slurp-sexp
         ">" #'paredit-backward-barf-sexp
         "s" #'paredit-forward-slurp-sexp
         "b" #'paredit-forward-barf-sexp
         "r" #'paredit-raise-sexp
         "w" #'paredit-wrap-sexp
         "[" #'paredit-wrap-square
         "'" #'paredit-meta-doublequote
         "{" #'paredit-wrap-curly
         "y" #'sp-copy-sexp))
       (:map evil-window-map
        (:prefix "w"
         "m"       #'my/toggle-maximize-buffer
         "u"     #'winner-undo
         "r"     #'winner-redo
         "."     #'+hydra/window-nav/body
         "w"     #'ace-window
         )))
      (:after ivy
       :map ivy-minibuffer-map
       "C-d" #'ivy-switch-buffer-kill))

(map! :leader
      ;;; <leader> p --- project
      (:prefix-map ("p" . "project")
       :desc "Add new project"              "A" #'projectile-add-known-project
       :desc "implementation <-> test"      "a" #'projectile-toggle-between-implementation-and-test))

(define-key evil-normal-state-map "x" 'delete-forward-char)     ; delete to the black hole
(define-key evil-normal-state-map "X" 'delete-backward-char)

(setq mode-line-format nil)
(nano-modeline-mode 1)

(setq projectile-create-missing-test-files t)

(defun db-cfg ()
  (interactive)
  (save-excursion
    (let (p1 p2 dbcon)
      (search-backward "---- db:")
      (setq p1 (point))
      (setq p2 (line-end-position))
      (substring (buffer-substring-no-properties p1 p2) 8 ))))

(defun run-sql ()
  (interactive)
  (save-excursion
    (let (p1 p2 dbcon)
      (search-backward "----")
      (setq p1 (point))
      (search-forward "----")
      (search-forward "----")
      (setq p2 (point))

      (let (cmd output)
        (setq cmd (buffer-substring-no-properties p1 p2))
        (write-region p1 p2 "/tmp/epsql.sql")
        (setq cmd (format "psql %s -f /tmp/epsql.sql -o /tmp/epsqlresp.sql" (db-cfg) cmd))
        (setq output (shell-command-to-string cmd))
        (message output)
        (with-output-to-temp-buffer "sql-result"
          (save-current-buffer
            (set-buffer "sql-result")
            (funcall (intern "sql-mode"))
            (insert-file-contents "/tmp/epsqlresp.sql" nil nil nil t)
            (insert
             (format "----------- Result ------------\n%s-----------  End   ------------\n\n\n" output)))
          )))))

(define-key evil-normal-state-map (kbd "RET") 'run-sql)

(elcord-mode)
