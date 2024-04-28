;; -*- lexical-binding: t; -*-
(setq mouse-wheel-progressive-speed nil)

(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  (elpaca-use-package-mode)
  (setq elpaca-use-package-by-default t))

(elpaca-wait)


;; evil
;;
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)

  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-undo-sysetm 'undo-fu)
  (setq evil-search-module 'evil-search)
  (setq evil-auto-indent nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-motion-state-map "_" 'evil-end-of-line)
  (define-key evil-motion-state-map "0" 'evil-beginning-of-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (defun ekk/evil-dont-move-cursor (orig-fn &rest args)
    (save-excursion (apply orig-fn args)))
  (advice-add 'evil-indent :around #'ekk/evil-dont-move-cursor)
  )

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-magit-use-z-for-folds nil)
  :config
  (evil-collection-init '(dashboard dired ibuffer vterm)))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package evil-nerd-commenter
  :after evil)

(with-eval-after-load 'evil-maps
	'("SPC" "RET" "TAB"))

(setq org-return-follows-link t)

(setq history-lenght 25)
(savehist-mode 1)

(setq use-dialog-box nil)
(setq create-lockfiles nil)

(global-auto-revert-mode t)
(delete-selection-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


(setq frame-title-format "%b - ekk")
(setq mouse-autoselect-window t)
(fset 'yes-or-no-p 'y-or-n-p)


(setq make-backup-files nil
      auto-save-default nil)

(setq select-enable-clipboard t
      select-enable-primary t
      save-interprogram-paste-before-kill t)

(setq visible-bell t
      rign-bell-function #'ignore)
(setq minibuffer-prompt-properties '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))
(setq history-delete-duplicates t)
(setq completion-ignore-case t)

(setq-default show-trailing-whitespace t)

(setq sentence-end-double-space nil)

(prefer-coding-system 'utf-8)

(transient-mark-mode 1)

(electric-pair-mode 1)

(use-package all-the-icons
  :ensure t)

(use-package centered-cursor-mode
  :diminish centerd-cursor-mode
  :config (global-centered-cursor-mode))

;(eval-after-load 'evil-collection-unimpaired '(diminish 'evil-collection-unimpaired-mode))

(use-package evil-tutor)

  ;(ekk/leader-keys
  ;  "f" (:ignore t :wk "Find") "f c"
  ; '((lambda ()
  ;     (interactive)
  ;     (find-file "~/.emacs.d/init.el"))
  ;   :wk "Edit Emacs configuration")
  ; "f f" '(find-file :wk "Find file")
  ; "f r" '(counsel-recentf :wk "Find recent files")))

;  (ekk/leader-keys
;   "SPC" '(counsel-M-x :wk "Counsel M-x")
;   "TAB TAB" '(comment-line :wk "Comment lines"));

;  (ekk/leader-keys
;   "b" '(:ignore t :wk "Buffer")
;   "b b" '(switch-to-buffer :wk "Switch buffer")
;   )

;  (ekk/leader-keys
 ;  "d" '(:ignore t :wk "Dired")))


(use-package general
  :ensure (:wait t)
  :demand t
  ;:custom
  ;(general-use-package-emit-autoloads t)
  :config
  (general-evil-setup)

  (general-create-definer ekk/leader-keys
   :states '(normal insert visual emacs)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix (concat "C-SPC")
   :global-prefix "M-SPC")

  (general-create-definer ekk/local-leader-keys
    :states '(normal visual)
    :keymaps 'override
    :prefix ","
    :global-prefix "SPC m")

  (general-nmap
    "gD" '(xref-find-references :wk "references"))

  (ekk/leader-keys
    "." '(find-file :wk "Find file")
    "f r" '(counsel-recentf :wk "Find recent files"))

  (ekk/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "TAB TAB" '(comment-line :wk "Comment lines"))

  (ekk/leader-keys
    "b" '(:ignore t :wk "Buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b i" '(ibffuer :wk "Ibuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")

    "g" #'magit-status
    "n" #'narrow-or-widen-dwim
    )

  (ekk/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open Dired")
    "d j" '(dired-jump :wk ""))

  (ekk/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t m" '(treemacs :wk "Toggle Treemacs")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle Vterm")
    )

  (ekk/leader-keys
    "w" '(:ignore t :wk "Windows")
    "w c" '(evil-window-delete :wk "")
    "w n" '(evil-window-new :wk "")
    "w s" '(evil-window-split :wk "")
    "w v" '(evil-window-vsplit :wk "")
    "w h" '(evil-window-left :wk "")
    "w j" '(evil-window-down :wk "")
    "w k" '(evil-window-up :wk "")
    "w l" '(evil-window-right :wk "")
    "w w" '(evil-window-next :wk "")
    "w H" '(buf-move-left :wk "")
    "w J" '(buf-move-down :wk "")
    "w K" '(buf-move-up :wk "")
    "w L" '(buf-move-right :wk "")
    )

  )

(use-package doom-themes
  :init
  (load-theme 'doom-material-dark t))

(use-package nerd-icons)
(use-package nerd-icons-completion
  :after (nered-icons marginalia)
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup)
  :config
  (nerd-icons-completion-mode))


(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package doom-modeline
  :hook
  (emacs-startup . doom-modeline-mode)
  :custom
  (doom-modeline-buffer-file-name-style 'relative-to-project))


;; macos
(use-package emacs
  :ensure nil
  :init
  (setq inhibit-startup-screen t
	initial-scratch-message nil
	sentence-end-double-space nil
	ring-bell-function 'ignore
	frame-resize-pixelwise t)
		 (defun ekk/is-macos ()
		   (and (eq system-type 'darwin)
			(= 0 (length (shell-command-to-string "uname -a | grep iPad")))))
		 (when (ekk/is-macos)
		   (setq mac-command-modifier 'super)
		   (setq mac-option-modifier 'meta)
		   (setq mac-control-modifier 'control))
		 (when (fboundp 'mac-auto-operator-composition-mode)
		   (mac-auto-operator-composition-mode)
		   (global-set-key [(s c)] 'kill-ring-save)
		   (global-set-key [(s v)] 'yank)
		   (global-set-key [(s x)] 'kill-ring)
		   (global-set-key [(s q)] 'kill-emacs)))



(use-package transient)

(use-package magit
  :commands magit-get-top-dir
  :bind (("C-c g" . magit-status))
  :hook
  (git-commit-mode . magit-commit-mode-init)
  :init
  (progn
    (defadvice magit-status (around magit-fullscreen activate)
      (window-configuration-to-register :m)
      ad-do-it
      (delete-other-windows))

    (defadvice git-commit-commit (after delete-window activate)
      (delete-window))
    (defadvice git-commit-abort (after delete-window activate)
      (delete-window))

    (defun magit-commit-mode-init ()
      (when (looking-at "\n")
        (open-line 1))))
  :config
  (progn
    (defadvice magit-quit-window (around magit-restore-screen activate)
      (let ((current-mode major-mode))
        ad-do-it
        (when (eq 'magit-status-mode current-mode)
          (jump-to-register :m))))
    (defun magit-maybe-commit (&optional show-options)
      (interactive "P")
      (if show-options
          (magit-key-mode-popup-committing)
        (magit-commit)))
    (define-key magit-mode-map "c" 'magit-maybe-commit)

    (transient-insert-suffix 'magit-pull "-r" '("-f" "Overwrite local branch" "--force"))
    (setq
     magit-default-tracking-name-function 'magit-default-tracking-name-branch-only
     magit-status-buffer-switch-function 'switch-to-buffer
     magit-diff-refine-hunk t
     magit-rewrite-inclusive 'ask
     magit-save-some-buffesr nil
     magit-process-popup-time 10
     magit-set-upstream-on-push 'askifnotset)))

(use-package forge
  :after magit
  :init
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(use-package pos-tip)

(use-package jsonrpc)


(use-package which-key
  :defer 't
  :init (which-key-mode))

;(use-package counsel
;  :after ivy
;  :diminish
;  :config (counsel-mode))

;(use-package ivy
;  :bind
;  (("C-c C-r" . ivy-resume)
;   ("C-x B" . ivy-switch-buffer-other-window))
;  :diminish
;  :custom
;  (setq ivy-use-virtual-buffers t)
;  (setq ivy-count-format "(%d/%d) ")
;  (setq enable-recursive-minibuffers t)
;  :config (ivy-mode))

;(use-package all-the-icons-ivy-rich
;  :init (all-the-icons-ivy-rich-mode 1))

;(use-package ivy-rich
;  :after ivy
;  :init
;  (ivy-rich-mode 1)
;  :config
;  (defun ivy-rich-switch-buffer-icon (candidate)
;    (with-current-buffer
;        (get-buffer candidate)
;      (let ((icon (all-the-icons-for-mode major-mode)))
;        (if (symbolp icon)
;            (all-the-icon-for-mode 'fundamental-mode)
;          icon))))
;  (setq ivy-rich-display-transformers-list
;        '(ivy-switch-buffer
;          (:columns
;           ((ivy-rich-switch-buffer-icon (:width 2)))
;           :predicate
;           (lambda (cand) (get-buffer cand)))))
;  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
;  (setq ivy-rich-path-style 'abbrev))


;; theme


(require 'windmove)
(defun buf-move-up ()
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      (set-window-buffer (selected-window) (window-buffer other-win))
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))


;; completion
(savehist-mode 1)

(use-package marginalia
		 :after vertico
		 :init
		 (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
		 (marginalia-mode)
		 (with-eval-after-load 'projectile
		   (add-to-list 'marginalia-command-categories '(projectile-find-file . file))))

(use-package embark
		 :after vertico
		 :general
		 (general-nmap "C-l" 'embark-act)
		 (vertico-map
		  "C-l" #'embark-act)
		 (:keymaps 'embark-file-map
			   "x" 'ekk/dired-open-externally)
     :bind
     (("C-." . embark-act)
      ("C-;" . embark-dwim)
      ("C-h B" . embark-bindings))
		 :init
		 (setq prefix-help-command #'embark-prefix-help-command)
		 (add-to-list 'display-buffer-alist
			      '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package consult
		 :commands (consult-ripgrep)
     :after projectile
		 :general
		 (general-nmap
		   :states '(normal insert)
       "C-s" 'consult-line
       "C-c M-x" 'consult-mode-command
       "C-x M-:" 'consult-complex-command
		   "C-p" 'consult-yank-pop)
		 (ekk/leader-keys
		   "r r" '(consult-bookmark :wk "go to bookmark")
		   "s i" '(consult-isearch :wk "isearch"))
		 :init
     (defun remove-items (x y)
       (setq y (cl-remove-if (lambda (item) (memq item x)) y)) y)
     (setq consut-themes (custom-available-themes))
     (setq consult-project-function (lambda (_) (projectile-project-root)))
		 (setq xref-show-xrefs-function #'consult-xref
		       xref-show-definitions-function #'consult-xref)

     (defun ekk/consult-line (&optional arg)
       (interactive "p")
       (let ((cmd (if current-prefix-arg '(lambda (arg) (consult-line-multi t arg)) 'consult-line)))
         (if (use-region-p)
             (let ((regionp (buffer-substring-no-properties (region-beginning) (region-end))))
               (deactivate-mark)
               (funcall cmd regionp))
           (funcall cmd ""))))

		 :config
		 (autoload 'projectile-project-root "projectile")
     (use-package consult-xref)
     (consult-customize
      consult-theme
      :preview-key '(:debounce 0.2 any)
      consult-ripgrep
      consult-git-grep
      consult-bookmark
      consult-recent-file
      consult-xref
      :preview-key '(:debounce 0.4 any))
		 (setq consult-project-root-function #'projectile-project-root)
		 (with-eval-after-load 'selectrum
		   (require 'consult-selectrum)))

(use-package embark-consult
	:after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vertico
		 :ensure (:files (:defaults "extensions/*"))
;		 :demand
		 :general
		 (:keymaps 'vertico-map
			   "C-j" #'vertico-next
			   "C-k" #'vertico-previous
         "<escape>" #'keyboard-escape-quit)
		 (ekk/leader-keys
		   "s ." '(vertico-repeat-previous :wk "repeat search"))
		 :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
		 :init
     (vertico-mode)
		 (setq vertico-grid-separator "         ")
		 (setq vertico-grid-lookahead 50)
		 (setq vertico-count 20)
		 (setq vertico-cycle t)
		 :config
     (vertico-mode 1)
     (defun +completion-category-highlight-files (cand)
       (let ((len (length cand)))
         (when (and (> len 0)
                    (eq (aref cand (1- len)) ?/))
           (add-face-text-property 0 len 'dired-directory 'append cand)))
       cand)

     (defun +completion-category-highlight-commands (cand)
       (let ((len (length cand)))
         (when (and (> len 0)
                    (with-current-buffer (nth 1 (buffer-list))
                      (or (eq major-mode (intern cand))
                          (seq-contains-p local-minor-modes (intern cand))
                          (seq-contains-p global-minor-modes (intern cand)))))
           (add-face-text-property 0 len '(:foreground "red") 'append cand)))
       cand)

     (defun +completion-category-truncate-files (cand)
       (if-let ((type (get-text-property 0 'multi-category cand))
                ((eq (car-safe type) 'file))
                (response (ivy-rich-switch-buffer-shorten-path cand 30)))
           response
        cand))

     (defun sort-directories-first (files)
       (setq files (vertico-sort-history-alpha files))
       (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
              (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))

     (defvar +vertico-transform-functions nil)
     (defun +vertico-transform (args)
       (dolist (fun (ensure-list +vertico-transform-functions) args)
         (setcar args (funcall fun (car args)))))
     (advice-add #'vertico--format-candidate :filter-args #'+vertico-transform)

     (setq vertico-multiform-commands
           '((describe-symbol (vertico-sort-function . vertico-sort-alpha))))
     
     (setq vertico-multiform-categories
           '((symbol (vertico-sort-function . vertico-sort-alpha))
             (command (+vertico-transform-functions . +completion-category-highlight-commands))
             (file (vertico-sort-function . sort-directories-first)
                   (+vertico-transform-functions . +completion-category-highlight-files))
             (multi-category (+vertico-transform-functions . +completion-category-truncate-files))))
		 (require 'vertico-directory))

(use-package vertico-posframe
  :init
  (vertico-posframe-mode 1)
  :config
  (add-hook 'vertico-posframe-mode-hook 'vertico-posframe-cleanup)
  (vertico-multiform-mode 1)
  (setq vertico-multiline-commands
        '((consult-line (:not posframe))
          (consult-ripgrep (:not posframe))
          (t posframe))))
;  :hook (vertico-mode . vertico-posframe-mode)
;  :init
;  (setq vertico-posframe-poshandler
;        #'posframe-poshandler-frame-center
;        vertico-posframe-parameters
;        '((left-fringe . 8)
;          (right-fringe . 8))))

(use-package orderless
  :after consult
	:init
  :custom
  (completion-styles '(orderless basic))
	(setq completion-styles '(orderless)
;		    completion-category-defaults nil
		    completion-category-overrides '((file (styles partial-completion)))))

;(use-package corfu
;  :hook (corfu-mode . corfu-popupinfo-mode)
;	:bind
;	(:map corfu-map
;		    ("C-j" . corfu-next)
;		    ("C-k" . corfu-previous))
;  :config
;  (setq corfu-auto-delay 0.1
;        corfu-auto 't
;        corfu-auto-prefix 2
;        corfu-min-width 40
;        corfu-min-height 20)
;	:general
;	(evil-insert-state-map "C-k" nil)
;	:init
	;(setq corfu-auto nil)
	;(setq corfu-cycle t)
	;(setq corfu-min-width 80)
	;(setq corfu-max-width corfu-min-width)
	;(setq corfu-preselect-first t)
;	(defun corfu-enable-always-in-minibuffer ()
;    (unless (or (bound-and-true-p mct--active)
;                (bound-and-true-p vertico--input))
;      (setq-local corfu-auto nil)
;      (corfu-mode 1)))
;  (custom-set-faces '(corfu-current ((t :inherit region :background "#2d2844"))))
;  (custom-set-faces '(corfu-popupinfo ((t :inherit corfu-default))))
;	(add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-popupinfo-mode)
  (corfu-on-exact-match 'insert)
  (corfu-quit-no-match t)
  :init
  (setq corfu-exclude-modes '(eshell-mode))
  (global-corfu-mode))

(use-package cape
  :init
  (setq cape-dabbrev-min-length 2)
  (setq cape-dabbrev-check-other-buffers 'some)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)

  (defun corfu-enable-always-in-minibuffer ()
    (unless (or (bound-and-true-p mct--active)
                (bound-and-true-p vertico--input)
                (eq (current-local-map) read-passwd-map))
      (setq-local corfu-echo-delay nil
                  corfu-popupinof-delay nil)
      (corfu-mode 1)))

  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)
  :bind ("C-c SPC" . cape-dabbrev))

(use-package kind-icon
  :after corfu
  :init
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  :custom
  (kind-icon-default-face 'corfu-default)
  (kind-icon-default-styles '(:padding 0 :stroke 0 :margin 0 :radius 0 :height 0.8 :scale 1.0)))
;		 :after corfu
;		 :demand
;		 :init
;		 (setq kind-icon-default-face 'corfu-default)
;		 (setq kind-icon-blend-background nil)
;		 (setq kind-icon-blend-frac 0.08)
;		 :config
;		 (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
;		 (with-eval-after-load 'modus-themes
;		   (add-hook 'modus-themes-after-load-theme-hook #'(lambda () (interactive) (kind-icon-reset-cache)))))

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  ;(global-company-mode t)
  :commands (compant-manualbegin)
  :bind ("C-<tab>" . company-manual-begin))
;  :config
;  (setq company-tooltip-align-annotations t
;        company-minimum-prefix-length 1
;        company-idle-delay 0))

;(use-package yasnippet
;  :init (yas-global-mode))

;(use-package yasnippet-snippets
;  :after yasnippet)

;(use-package yasnippet-capf
;  :commands yas-capf-minor-mode
;  :ensure (:type git :host github :repo "justinbarclay/yasnippet-capf")
;  :init
;  (add-hook 'yas-minor-mode-hook #'yas-capf-minor-mode))

(use-package treemacs
  :config
  (setq treemacs-width 42)
  (setq treemacs-expand-after-init t)
  (treemacs-load-theme "all-the-icons")
  :hook
  (server-after-make-frame
   .
   (lambda ()
     (save-selected-window (treemacs))))
  (dired-mode
   .
   (lambda ()
     (when (treemacs-get-local-window)
       (treemacs)))))

(use-package projectile
  :config
  (projectile-mode 1))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)


(use-package vterm
  :ensure (vterm :post-build
                 (progn
                   (setq vterm-always-compile-module t)
                   (require 'vterm)
                   (with-current-buffer (get-buffer-create vterm-install-buffer-name)
                     (goto-char (point-min))
                     (while (not (eobp))
                       (message "%S"
                                (buffer-substring
                                 (line-beginning-position) (line-end-position)))
                       (forward-line)))
                   (when-let ((so (expand-file-name "./vterm-module.so"))
                              ((file-exists-p so)))
                     (make-symbolic-link so
                                         (expand-file-name (file-name-directory
                                                            so)
                                                           "../../builds/vterm")
                                         'ok-if-already-exists))))
  :config
  (setq shell-file-name "/bin/zsh"
        vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list
   'display-buffer-alist
   '((lambda (buffer-or-name _)
       (let ((buffer (get-buffer buffer-or-name)))
         (with-current-buffer buffer
           (or (equal major-mode 'vterm-mode)
               (string-prefix-p
                vterm-buffer-name (buffer-name buffer))))))
     (display-buffer-reuse-window display-buffer-at-bottom)
     (reusable-frames . visible)
     (window-height . 0.3))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0" "de8f2d8b64627535871495d6fe65b7d0070c4a1eb51550ce258cd240ff9394b0" "0f220ea77c6355c411508e71225680ecb3e308b4858ef6c8326089d9ea94b86f" default))
 '(package-selected-packages
   '(which-key vertico-posframe rainbow-mode quelpa-use-package projectile orderless no-littering neotree marginalia magit link-hint ido-vertical-mode helpful git-gutter gcmh flycheck flx-ido exec-path-from-shell evil embark-consult doom-modeline diminish corfu consult-eglot consult-ag company color-theme-sanityinc-tomorrow cape bind-map all-the-icons-completion)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(corfu-current ((t :inherit region :background "#2d2844")))
 '(corfu-popupinfo ((t :inherit corfu-default))))
