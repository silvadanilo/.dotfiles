;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ####################### LOOK ################################
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

(tab-bar-mode)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq evil-vsplit-window-right t)
(after! which-key (setq which-key-idle-delay 0.5))
(custom-set-faces! '(ivy-minibuffer-match-face-1 :foreground "#fafafa"))

;; (modify-syntax-entry ?: "($")

;;######################## ORG ##################################
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (require 'org-tempo)
  (require 'org-bullets)  ; Nicer bullets in org-mode
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq   org-directory "~/org/"
          org-agenda-files (directory-files-recursively "~/org/" "\\.org$")
          org-default-notes-file (expand-file-name "notes.org" org-directory)
          org-ellipsis " ▼ "
          org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
          org-log-done 'time)

  (setq   org-journal-dir "~/org/journal/"
          org-journal-date-prefix "#+TITLE: "
          org-journal-time-prefix "* "
          org-journal-date-format "%a, %Y-%m-%d"
          org-journal-file-format "%Y-%m-%d.org")

  (setq
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/")
            ("wikit" . "https://it.wikipedia.org/wiki/")
            ("yts" . "https://www.youtube.com/results?search_query="))))

;; ####### ORG-CAPTURE
;; (setq org-capture-templates
;;       '(("g" "Grocery today" checkitem (file+datetree "~/org/grocery.org")
;;          "[ ] %?")))

;; (defun schedule-grocery-hook ()
;;   (if (string= (org-capture-get :description)
;;                "Grocery today")     ;Must match the description in the template
;;       (org-schedule 0 (format-time-string "%Y-%m-%d"))))

;; (add-hook 'org-capture-before-finalize-hook 'schedule-grocery-hook)


;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
;;          "* TODO %?\n  %i\n  %a")
;;         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;          "* %?\nEntered on %U\n  %i\n  %a")))

;; (setq org-capture-templates `(
;; 	("p" "Protocol" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
;;         "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;; 	("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
;;         "* %? [[%:link][%:description]] \nCaptured On: %U")
;; ))

(use-package org-protocol
  :demand
  :config
  (add-to-list 'org-capture-templates
               '("g" "Grocery List" checkitem (file+headline "~/org/deft/grocery-list.org" "Grocery List")
                 "[ ] %? \n"))
  (add-to-list 'org-capture-templates
               '("e" "Event" entry (file+headline "~/org/deft/events.org" "Task")
                 "** %? \n %^T \n"))
  (add-to-list 'org-capture-templates
               '("l" "Link" entry (file+headline "~/org/deft/articles.org" "Da Organizzare")
                 "** %? \n%c\n")))


(use-package ob-http :ensure t)

;; ########################### JIRA #############################
(setq jiralib-url "https://casavo.atlassian.net")


;; ######################## KEY BINDING #########################
(defun evil-save-and-enter-normal-state ()
        "Save buffer and go to normal state."
        (interactive)
        (save-buffer)
        (evil-normal-state))

(defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))


(global-set-key [f12] 'neotree-project-dir)
(global-set-key (kbd "<backtab>") 'neotree-project-dir)
(global-set-key (kbd "C-<") 'neotree-toggle)

(define-key evil-normal-state-map (kbd "C-l") 'evil-ex-nohighlight)
(define-key evil-normal-state-map (kbd "L") 'tab-next)
(define-key evil-normal-state-map (kbd "H") 'tab-previous)
(define-key evil-normal-state-map (kbd "Q") 'kill-buffer-and-window)
(define-key evil-normal-state-map (kbd "M-z") 'zoom-window-zoom)
(define-key evil-insert-state-map (kbd "C-\\") 'evil-save-and-enter-normal-state)
(define-key evil-normal-state-map (kbd "C-\\") 'evil-save-and-enter-normal-state)
(define-key evil-motion-state-map (kbd "C-\\") 'evil-save-and-enter-normal-state)
(define-key evil-insert-state-map (kbd "C-s") 'evil-save-and-enter-normal-state)
(define-key evil-normal-state-map (kbd "C-s") 'evil-save-and-enter-normal-state)
(define-key evil-motion-state-map (kbd "C-s") 'evil-save-and-enter-normal-state)
(define-key evil-motion-state-map (kbd "_") 'string-inflection-underscore)
(define-key evil-motion-state-map (kbd "_") 'string-inflection-underscore)

;; ### string-inflection keymapping
(map! :leader
      ;;; <leader> _ --- string inflection
      (:prefix-map ("_" . "string inflection")
       :desc "Force to snake_case"         "_" #'string-inflection-underscore
       :desc "Force to CamelCase"                 "C" #'string-inflection-camelcase
       :desc "Force to lowerCamelCase"          "c" #'string-inflection-lower-camelcase
       :desc "Force to ...(cycle)"      "y" #'string-inflection-all-cycle
       :desc "Force to kebab-case"                "k" #'string-inflection-kebab-case)

      ;;; <leader> % --- editing doom config files
      (:prefix-map ("%" . "doom config files")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/org/agenda.org"))
       :desc "Edit doom config.el" "c" #'(lambda () (interactive) (find-file "~/.doom.d/config.el"))
       :desc "Edit eshell aliases" "e" #'(lambda () (interactive) (find-file "~/.doom.d/aliases"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.doom.d/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el")))

      ;;; <leader> r --- register
      (:prefix-map ("r" . "register")
       :desc "Copy to register" "c" #'copy-to-register
       :desc "Frameset to register" "f" #'frameset-to-register
       :desc "Insert contents of register" "i" #'insert-register
       :desc "Jump to register" "j" #'jump-to-register
       :desc "List registers" "l" #'list-registers
       :desc "Number to register" "n" #'number-to-register
       :desc "Interactively choose a register" "r" #'counsel-register
       :desc "View a register" "v" #'view-register
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :desc "Increment register" "+" #'increment-register
       :desc "Point to register" "SPC" #'point-to-register))
;; ################################################

;; ################# NEOTREE ##########################
(use-package! neotree
  :config
  (map! :map neotree-mode-map
        :n "r" #'neotree-refresh
        :n (kbd "<f5>")   #'neotree-refresh
        :n "A"  #'neotree-stretch-toggle))
;; ####################################################

;; ################# THESAURUS ##########################
(setq thesaurus-bhl-api-key "f5c45671e37b120e529e965d7144de6b")
(setq deft-directory "~/org/deft/"
      deft-extensions '("txt" "org")
      deft-recursive t)

;; ########################################################################
;; ######################## PROGRAMIING LANGUAGES #########################
;; ########################################################################
(setq projectile-project-search-path '("~/sviluppo/"))
;; ######################## ELIXIR ##########################
(add-hook 'elixir-mode-hook #'lsp!)
(add-to-list 'exec-path "/home/ubuntu/.elixir-ls/release")
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(after! lsp-ui
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-doc-max-height 13
          lsp-ui-doc-max-width 80
          lsp-ui-sideline-ignore-duplicate t
          lsp-ui-doc-header t
          lsp-ui-doc-include-signature t
          lsp-ui-doc-position 'bottom
          lsp-ui-doc-use-webkit nil
          lsp-ui-flycheck-enable t
          lsp-ui-imenu-kind-position 'left
          lsp-ui-sideline-code-actions-prefix "💡"
          ;; fix for completing candidates not showing after “Enum.”:
          company-lsp-match-candidate-predicate #'company-lsp-match-candidate-prefix
          ))

(use-package! flycheck-credo
              :after flycheck
              :config
              (flycheck-credo-setup)
              (after! lsp-ui
                      (flycheck-add-next-checker 'lsp 'elixir-credo)))

(defvar my/use-exunit-custom t)
(defvar my/exunit-custom-mix-cmd "docker exec -it worms mix")

(defun my/exunit-compile (orig-fun &rest args)
  (if t
      (let* ((directory (cadr args))
             (default-directory (or directory (exunit-project-root)))
             (compilation-environment exunit-environment)
             (args (car args)))
        (exunit-do-compile
         (s-join " " (append (list my/exunit-custom-mix-cmd "test") exunit-mix-test-default-options args))))
    (apply orig-fun args)))

(advice-add 'exunit-compile :around #'my/exunit-compile)


;; ((elixir-mode ((my/use-exunit-custom t)
;;                (my/exunit-custom-mix-cmd "docker exec -it worms mix"))))

(add-hook 'elixir-mode-hook '(lambda ( )
                               (modify-syntax-entry ?: "." elixir-mode-syntax-table)
                               (modify-syntax-entry ?_ "w" elixir-mode-syntax-table)))

(with-eval-after-load 'lsp-mode
        (dolist (dir '(
                        "[/\\\\]\\.git"
                        "[/\\\\]\\.cache"
                        "[/\\\\]\\.elixir_ls"
                        "[/\\\\]\\.volumes"
                        "[/\\\\]assets"
                        "[/\\\\]_build"
                        "[/\\\\]deps"
                        "[/\\\\]docker-compose"
                        "[/\\\\]kubernetes"
                        "[/\\\\]priv"
                        "[/\\\\]rel"
                        ))
                (push dir lsp-file-watch-ignored)))


;; ############# OPEN A FILE IN VERTICAL (C-o |) OR HORIZONTAL (C-o %) SPLIT IN IVY MINIBUFFER ###############
(use-package! ivy
  :config
        (defun find-file-right (filename)
                (interactive)
                (split-window-right)
                (other-window 1)
                (find-file filename))

        (defun find-file-below (filename)
                (interactive)
                (split-window-below)
                (other-window 1)
                (find-file filename))

        (defun find-file-new-tab (filename)
                (interactive)
                (tab-bar-new-tab)
                (find-file filename))

        (define-key! ivy-minibuffer-map "C-v" #'ivy-dispatching-done)

        (ivy-set-actions
         'counsel-find-file
         '(("|" find-file-right "open right")
           ("v" find-file-right "open right")
           ("%" find-file-below "open below")
           ("t" find-file-new-tab "open in a new tab")))

        (ivy-set-actions
         'counsel-recentf
         '(("|" find-file-right "open right")
           ("v" find-file-right "open right")
           ("%" find-file-below "open below")
           ("t" find-file-new-tab "open in a new tab")))

        (ivy-set-actions
         'counsel-buffer-or-recentf
         '(("|" find-file-right "open right")
           ("v" find-file-right "open right")
           ("%" find-file-below "open below")
           ("t" find-file-new-tab "open in a new tab")))

        (ivy-set-actions
         'ivy-switch-buffer
         '(("|" find-file-right "open right")
           ("v" find-file-right "open right")
           ("%" find-file-below "open below")
           ("t" find-file-new-tab "open in a new tab")))
        )
;; ##########################################################################################################
