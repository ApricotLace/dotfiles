;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Evgeny Mukha"
      user-mail-address "Profunctorlense@gmail.com")

(setq enable-local-variables t)

(setq doom-font (font-spec :family "Iosevka" :size 16.5 :antialias="on"))

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
  (cider-add-to-alist 'cider-jack-in-dependencies
                      "org.clojure/tools.deps"
                      '(("git/sha" . "8f8fc2571e721301b6d52e191129248355cb8c5a")
                        ("git/url" . "https://github.com/clojure/tools.deps/"))))

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
  (setq lsp-idle-delay 0))

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
       (:map (js2-mode-map)
        (:prefix ("e" . "eval")
        "e" #'nodejs-repl-send-last-expression
        "b" #'nodejs-repl-send-buffer))
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
         "D" #'sp-kill-sexp
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

(setq projectile-create-missing-test-files t)


(defun clj-insert-persist-scope-macro ()
  (interactive)
  (insert
   "(defmacro persist-scope
              \"Takes local scope vars and defines them in the global scope. Useful for RDD\"
              []
              `(do ~@(map (fn [v] `(def ~v ~v))
                  (keys (cond-> &env (contains? &env :locals) :locals)))))"))


(defun persist-scope ()
  (interactive)
  (let ((beg (point)))
    (clj-insert-persist-scope-macro)
    (cider-eval-region beg (point))
    (delete-region beg (point))
    (insert "(persist-scope)")
    (cider-eval-defun-at-point)
    (delete-region beg (point))))

(setq cider-debug-use-overlays t)
(setq cider-overlays-use-font-lock nil)

(after! ivy-posframe
  (setq ivy-posframe-size-function
        (lambda ()
          (list :width 100 :height 15)))

  (defun my-posframe--display (str &optional poshandler)
    (if (not (posframe-workable-p))
        (ivy-display-function-fallback str)
      (with-ivy-window
        (apply #'posframe-show
               ivy-posframe-buffer
               :font ivy-posframe-font
               :string str
               :position (point)
               :poshandler poshandler
               :background-color (face-attribute 'ivy-posframe :background nil t)
               :foreground-color (face-attribute 'ivy-posframe :foreground nil t)
               :left-fringe 5
               :right-fringe 5
               :border-width 1
               :border-color "#969896"
               :override-parameters ivy-posframe-parameters
               :refposhandler ivy-posframe-refposhandler
               :hidehandler #'ivy-posframe-hidehandler
               (funcall ivy-posframe-size-function))
        (ivy-posframe--add-prompt 'ignore)))
    (with-current-buffer ivy-posframe-buffer
      (setq-local truncate-lines ivy-truncate-lines)))

  (defun my-posframe-display-at-frame-center (str)
    (my-posframe--display str #'posframe-poshandler-frame-center))

  (setq ivy-posframe-display-functions-alist '((t . my-posframe-display-at-frame-center))))


(defun mode-line-render (left right)
  (concat left
          (propertize " " 'display `(space :align-to (- right ,(length right))))
          right))


(defface face-faded nil
"Faded face is for information that are less important.
It is made by using the same hue as the default but with a lesser
intensity than the default. It can be used for comments,
secondary information and also replace italic (which is generally
abused anyway)."
:group 'elegance)


(setq-default header-line-format '((:eval
                                    (mode-line-render
                                     (format-mode-line (list
                                                        (propertize "☰" 'face `(:inherit mode-line-buffer-id)
                                                                    'help-echo "Mode(s) menu"
                                                                    'mouse-face 'mode-line-highlight
                                                                    'local-map   mode-line-major-mode-keymap)
                                                        " " (when buffer-file-name
                                                          (concat (file-relative-name buffer-file-name (projectile-project-root)) " "))
                                                        (if (and buffer-file-name (buffer-modified-p))
                                                            (propertize "(modified)" 'face `(:inherit face-faded)))))
                                     (format-mode-line
                                      (propertize "%4l:%2c" 'face `(:inherit face-faded)))))))

(global-hide-mode-line-mode)

(setq window-divider-default-right-width 1)

(setq window-divider-default-places 'right-only)

(window-divider-mode)

(add-hook 'clojure-mode-hook #'paredit-mode)

mode-line-misc-info

(setq crdt-tuntox-executable "/opt/homebrew/bin/tuntox")
(setq crdt-use-tuntox t)

(setq cider-print-fn 'fipp)
(setq cider-print-options '(("print-level" 1) ("level" 1)))
