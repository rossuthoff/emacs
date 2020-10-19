;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; use-package setup
(require 'package)
(setq package-enable-at-startup nil) ; dont do it immediately
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
			 ("Marmalade" . "http://marmalade-repo.org/packages/")
			 ;("elpy" . "http://jorgenschaefer.github.io/packages/")
			 ))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents) ; update archives
  (package-install 'use-package)) ; grab the newest use-package

;; Define packages
(require 'use-package)

;; Always download if not available
(setq use-package-always-ensure t)

                                     

(use-package which-key 
  :commands which-key-mode
  :config (which-key-mode)
  )
  
  
;; Ivy
(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper))
)
		 
		 
		 
; Let ivy use flx for fuzzy-matching

(use-package flx
  :config
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
)

;; Slim down ivy display
(setq ivy-count-format ""
      ivy-display-style nil
      ivy-minibuffer-faces nil)
  
  
(setq explicit-shell-file-name "C:/Program Files/git/bin/bash.exe")
(setq explicit-bash.exe-args '("--login" "-i"))

(defun git-bash () (interactive)
  (let ((explicit-shell-file-name "C:/Program Files/git/bin/bash"))
    (call-interactively 'shell)))
   

(add-to-list 'exec-path "C:/hunspell/bin/")
(setq ispell-program-name "hunspell")
;; "en_US" is key to lookup in `ispell-local-dictionary-alist`.
;; Please note it will be passed as default value to hunspell CLI `-d` option
;; if you don't manually setup `-d` in `ispell-local-dictionary-alist`
(setq ispell-local-dictionary "en_US") 
(setq ispell-local-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

(use-package elpy
  :config
  (progn
    (elpy-enable)

    ;;Fixes prompt in IPython new versions
    (setq python-shell-interpreter "C:\Python\Python38\python"
		python-shell-interpreter-args " -i"
		elpy-shell-echo-input nil
		elpy-shell-echo-output nil
		elpy-eldoc-show-current-function nil
		elpy-shell-display-buffer-after-send t
		)
	)
  )
 ;;(remove-hook 'elpy-modules 'elpy-module-flymake)

(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
;;    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

	   
(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  ;(setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-save-query nil)
  (setq-default TeX-master nil)
  (setq font-latex-fontify-script nil)
  (setq doc-view-ghostscript-program "C:/Program Files/gs/gs9.21/bin/gswin64.exe")
  (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
 ; (setq TeX-engine 'xetex)
  (setq TeX-PDF-mode t)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (visual-line-mode)
			  ;(LaTeX-math-mode)
              ;(TeX-source-correlate-mode)))
 ;             (rainbow-delimiters-mode)
 ;             (company-mode)
 ;             (smartparens-mode)
 ;             (turn-on-reftex)
 ;             (setq reftex-plug-into-AUCTeX t)
 ;             (reftex-isearch-minor-mode)
 ;             (setq TeX-PDF-mode t)
 ;             (setq TeX-source-correlate-method 'synctex)
 ;             (setq TeX-source-correlate-start-server t)))
)))
 
 
(require 'tex-mik)
;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
           #'TeX-revert-document-buffer)

;; Company for autocomplete
(use-package company
  :init (global-company-mode)
  :config
  (progn
    (add-hook 'prog-mode-hook 'company-mode)
    (setq-default
     company-backends
    '(company-auctex
      company-jedi		
      ;company-anaconda)

       )
     )
    )
  )

(use-package company-auctex
  :after (:all company (:any auctex tex-site))
  )

(use-package company-jedi
  :after (:all company (:any python elpy))
  )


  


;;HTML CSS
;(use-package web-mode
;  :ensure t
;  :mode
;  ("\\.html?\\'" . web-mode)
;  ("\\.scss?\\'" . web-mode)
;  ("\\.erb\\'" . web-mode)
;  ("\\.djhtml\\'" . web-mode)
;  :config
;  (setq web-mode-engines-alist
;        '(("Django" . "\\.djhtml'"))))

;(use-package scss-mode
;  :ensure t
;  :mode
;  ("\\.css\\'". css-mode)
;  ("\\.scss\\'" . scss-mode))

;;Visual Basic mode
;(add-to-list 'load-path "~/.emacs.d/lisp")
;(require 'visual-basic-mode)
; (autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
; (setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\|frs\\|vb\\)$" .
;                                  visual-basic-mode)) auto-mode-alist))

								  
;; Matlab mode
;(setq auto-mode-alist
;      (cons
;       '("\\.m$" . octave-mode)
;       auto-mode-alist))		


; ReST mode
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.txt\\'" . rst-mode)
                ("\\.rst\\'" . rst-mode)
                ("\\.rest\\'" . rst-mode)) auto-mode-alist))
								  

;;Markdown mode
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
  
;;YAML mode
(use-package yaml-mode
  :config   
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
            (lambda ()
            (setq yaml-indent-offset 4)
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
)
			
			
			
;; TCL mode
(autoload 'tcl-mode "tcl" "Tcl mode." t)
 (setq tcl-font-lock-keywords
   (eval-when-compile
     (list
      ;;
      ;; Function name declarations.
      '("\\<\\(itcl_class\\|class\\|method\\|proc\\|body\\)\\>[ \t]*\\(\\sw+\\)?"
	(1 font-lock-keyword-face) (2 font-lock-function-name-face nil t))
      ;;
      ;; Keywords.
 ;(make-regexp '("if" "then" "else" "elseif" "for" "foreach" "break"
 ;	       "continue" "while" "eval" "case" "in" "switch" "default"
 ;	       "exit" "error" "proc" "return" "uplevel" "constructor"
 ;	       "destructor" "itcl_class" "loop" "for_array_keys"
 ;	       "for_recursive_glob" "for_file"))
      (concat "\\<\\("
	      "break\\|c\\(ase\\|on\\(structor\\|tinue\\)\\)\\|de\\(fault\\|structor\\)"
	      "\\|e\\(lse\\(\\|if\\)\\|rror\\|val\\|xit\\)"
	      "\\|for\\(\\|_\\(array_keys\\|file\\|recursive_glob\\)"
	      "\\|each\\)\\|i\\([fn]\\|tcl_class\\)\\|loop"
	      "\\|namespace e\\(val\\|xport\\)"
	      "\\|p\\(ackage \\(provide\\|require\\)\\|roc\\)"
	      "\\|return\\|switch\\|then\\|uplevel\\|while"
		  "\\|display_hw_ila_data\\|program_hw_devices"
		  "\\|refresh_hw_device\\|set_property\\|current_hw_device\\|open_hw_target"
		  "\\|start_gui\\|open_hw\\|connect_hw_server"
		  "\\|run_hw_ila\\|wait_on_hw_ila\\|set"
	      "\\)\\>")
      ;;
      ;; Types.
 ;   (make-regexp '("global" "upvar" "variable" "inherit" "public"
 ;		   "private" "protected" "common"))
      (cons (concat "\\<\\("
		    "common\\|global\\|inherit\\|p\\(r\\(ivate\\|otected\\)\\|ublic\\)"
		    "\\|upvar\\|variable"
		    "\\)\\>")
	    'font-lock-type-face))))
		

 (add-hook 'tcl-mode-hook 
  (lambda ()
   (set (make-local-variable 'font-lock-defaults)
    '(tcl-font-lock-keywords nil nil ((?_ . "w") (?: . "w"))))))
			
(use-package hl-todo
       :ensure t
       ;;:custom-face
       ;;(hl-todo ((t (:inherit hl-todo :italic t))))
       :hook ((prog-mode . hl-todo-mode)
              (python-mode . hl-todo-mode)
              (yaml-mode . hl-todo-mode))
       :config
       (setq hl-todo-highlight-punctuation ":"
             hl-todo-keyword-faces
             `(("TODO"       warning bold)
             ("FIXME"      error bold)
             ("HACK"       font-lock-constant-face bold)
             ("REVIEW"     font-lock-keyword-face bold)
             ("NOTE"       success bold)
             ("DEPRECATED" font-lock-doc-face bold)))
       )


(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'python-mode-hook '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed)))


(which-key-mode)

(load-theme 'solarized-dark t)


(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake

;(setq 
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
;(setq initial-scratch-message " ") ; print a default message in the empty scratch buffer opened at startup
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;;(let ((font "Operator Mono Book-12"))
(let ((font "Hack-12"))
  (set-frame-font font)
  (add-to-list 'default-frame-alist
               `(font . ,font)))

(global-hl-line-mode) ;makes the current line highlighted
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;start fullscreen

;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box nil) ;don't use dialog box

;; Some extra keybindings ;;
(bind-key "C-z" #'undo) ;make ctrl-z undo instead of minimize


(global-set-key (kbd "<M-down>") 'uelpy-nav-move-line-or-region-down)
(global-set-key (kbd "<M-up>") 'uelpy-nav-move-line-or-region-up)

(defun uelpy-nav-move-line-or-region-down (&optional beg end)
  "Move the current line or active region down."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list nil nil)))
  (if beg
      (uelpy--nav-move-region-vertically beg end 1)
    (uelpy--nav-move-line-vertically 1)))

(defun uelpy-nav-move-line-or-region-up (&optional beg end)
  "Move the current line or active region down."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list nil nil)))
  (if beg
      (uelpy--nav-move-region-vertically beg end -1)
    (uelpy--nav-move-line-vertically -1)))

(defun uelpy--nav-move-line-vertically (dir)
  "Move the current line vertically in direction DIR."
  (let* ((beg (point-at-bol))
         (end (point-at-bol 2))
         (col (current-column))
         (region (delete-and-extract-region beg end)))
    (forward-line dir)
    (save-excursion
      (insert region))
    (goto-char (+ (point) col))))

(defun uelpy--nav-move-region-vertically (beg end dir)
  "Move the current region vertically in direction DIR."
  (let* ((point-before-mark (< (point) (mark)))
         (beg (save-excursion
                (goto-char beg)
                (point-at-bol)))
         (end (save-excursion
                (goto-char end)
                (if (bolp)
                    (point)
                  (point-at-bol 2))))
         (region (delete-and-extract-region beg end)))
    (goto-char beg)
    (forward-line dir)
    (save-excursion
      (insert region))
    (if point-before-mark
        (set-mark (+ (point)
                     (length region)))
      (set-mark (point))
      (goto-char (+ (point)
                    (length region))))
    (setq deactivate-mark nil)))


(setq set-language-environment "UTF-8")
(setq prefer-coding-system 'utf-8)
(setq set-terminal-coding-system 'utf-8)
(setq set-keyboard-coding-system 'utf-8)
(setq set-buffer-file-coding-system 'utf-8)
(setq set-default-coding-systems 'utf-8)  ; use utf-8 by default
(setq coding-system-for-read 'utf-8)	
(setq coding-system-for-write 'utf-8-unix)


;;set mouse scrolling
(setq mouse-wheel-scroll-amount '(0.07))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq-default indent-tabs-mode nil) ;dont use tabs, just spaces
	   

	   
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))	   


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(fci-rule-color "#073642")
 '(font-latex-fontify-script nil t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(ivy-count-format "(%d/%d) " t)
 '(ivy-use-virtual-buffers t t)
 '(ivy-virtual-abbreviate (quote full))
 '(lsp-ui-doc-border "#FFFFEF")
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (auctex-lua hl-todo flycheck el-init use-package general auto-package-update ivy counsel swiper projectile magit company-jedi company-auctex elpy markdown-mode yaml-mode auctex auctex-latexmk org org-journal which-key smartparens solarized-theme)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c9485ddd1797")
     (60 . "#bf7e73b30bcb")
     (80 . "#b58900")
     (100 . "#a5a58ee30000")
     (120 . "#9d9d91910000")
     (140 . "#9595943e0000")
     (160 . "#8d8d96eb0000")
     (180 . "#859900")
     (200 . "#67119c4632dd")
     (220 . "#57d79d9d4c4c")
     (240 . "#489d9ef365ba")
     (260 . "#3963a04a7f29")
     (280 . "#2aa198")
     (300 . "#288e98cbafe2")
     (320 . "#27c19460bb87")
     (340 . "#26f38ff5c72c")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
	
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-math-face ((t (:foreground "#6c71c4"))))
 '(font-latex-script-char-face ((t (:foreground "salmon")))))
