;;; cfg-paquetes.el - Administración de paquetes -*- lexical-binding: t; -*-

;;;; --------------- PAQUETES
(setq load-prefer-newer t) ; Don't load outdated byte code
(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives nil)
;; ---- FALTA - averiguar que repositorios son necesarios
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
;;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)


;;;; gestion de use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))


;;;; ---- UTILIDADES BÁSICAS

(use-package diminish
  :defer 0)

;;;; ---- PROJECTOS

;;;; Projectile - Gestor de proyectos.
(use-package projectile
  :defer 0
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))


;;;; ---- ESTILO VISUAL - THEME

;;;; doom
(use-package doom-themes
  :defer 0
  :init
  (load-theme 'doom-monokai-classic t))

(use-package doom-modeline
  :defer 0
  :hook
  (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-mode t))



;;;; ---- FUNCIONALIDADES


;;;; Autorevert - Recarga los archivos al ser modificados
(use-package autorevert
  :defer 3
  :hook (after-init . global-auto-revert-mode))


;;;; Which-Key - ayuda de teclas
(use-package which-key
  :defer 3
  :config
  (which-key-mode)
  (setq which-key-idle 0.5 which-key-idle-dely 50)
  (which-key-setup-minibuffer))


;;;; multiple cursores
(use-package multiple-cursors
  :defer 1
  :config
  (with-eval-after-load 'multiple-cursors
      (setq mc/list-file (concat usuario-dir ".mc-lists.el"))
    )
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c M-<" . 'mc/mark-all-like-this)
  ("<C-down-mouse-1>" . mc/add-cursor-on-click))


;;;; manejo de buffers - ibuffer
(use-package ibuffer
  :defer 1
  :config
  (global-set-key (kbd "C-x C-b") #'ibuffer)
  (setq ibuffer-saved-filter-groups
	(quote (("default"
		 ("dired" (mode . dired-mode))
		 ("org" (name . "^.*org$"))
		 ("web" (or (mode . web-mode) (mode . js2-mode)))
		 ("shell" (or
			   (mode . eshell-mode)
			   (mode . shell-mode)))
		 ("programming" (or
				 (mode . python-mode)))
		 ("emacs" (or
			   (name . "^\\*scratch\\*$")
			   (name . "^\\*Messages\\*$")
			   (name . "^entorno.el$")
			   ))
		 )))
	ibuffer-show-empty-filter-groups nil  ; Evita visualizar grupos vacios
	ibuffer-expert t  ; No confirma el cerrado de buffers marcados
	)
  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (ibuffer-auto-mode 1)
	      (ibuffer-switch-to-saved-filter-groups "default"))))


;;;; ido
(use-package ido
  :defer 2
  :config
  (setq
   ido-enable-flex-matching t
   ido-everywhere t
   ido-create-new-buffer 'always)
  (ido-mode t))



;;;; ---- USO DE TEXTO

;;;; Espacios en Blanco
(use-package whitespace
  :defer 2
  :hook (before-save . delete-trailing-whitespace))


(use-package hungry-delete
  :defer 2
  :delight
  :config (global-hungry-delete-mode))


;;;; Paréntesis
;; Muestra el padre y colorea los grupos de paréntesis de diferente color
(use-package rainbow-delimiters
  :defer 2
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package smartparens
  :defer 2
  :delight
  :custom (sp-escape-quotes-after-insert nil)
  :config
  (smartparens-global-mode t)
  :init
  (add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode)
  (add-hook 'js-mode-hook #'smartparens-mode))



;;;; ---- AUTOCOMPLETADO

;;;; Company - Autocompletado.
(use-package company
  :defer 1
  :config
  (setq company-idle-delay 0
	company-minimum-prefix-length 3
	company-selection-wrap-around t)
  (global-company-mode t)
  :init
  (add-hook 'after-init-hook 'global-company-mode))


;;;; ---- BÚSQUEDA


;;;; smex - Mejora para M-x
(use-package smex
  :defer 1)


;;;; Ivy - autocompletado
(use-package ivy
  :ensure t
  :defer t
  :bind (
	 ("s-b" . counsel-switch-buffer)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("M-j" . ivy-next-line)
	 ("M-k" . ivy-previous-line)
	 ("C-d" . ivi-switch-buffer-kill))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy--truncate-lines t)
  (ivy-wrap t)
  (ivy-use-selectable-promt t)
  (ivy-count-format " [%d/%d] ")
  (enable-recursive-minibuffers t)
  :init
  (ivy-mode 1))



;;;; Counsel - búsqueda de comandos dentro del mini-buffer.
(use-package counsel
  :defer 1
  :after ivy
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f1> l" . counsel-find-library)
  ("C-<f2> i" . counsel-info-lookup-symbol)
  ("C-<f2> u" . counsel-unicode-char)
  ("C-x f" . counsel-recentf)
  :config
  (counsel-mode 1))


;;;; Swiper - búsqueda de texto dentro de un fichero
(use-package swiper
  :defer 3
  :bind
  ("C-s" . swiper)
  :after ivy )


;;;; Emmet
(use-package emmet-mode
  :after(web-mode css-mode scss-mode)
  :commands (emmet-mode emmet-expand-line yas/insert-snippet yas-insert-snippet company-complete)
  :config
  (setq emmet-move-cursor-between-quotes t)
  (add-hook 'emmet-mode-hook (lambda () (setq emmet-indent-after-insert nil)))
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
                                        ;(setq emmet-indentation 2)
  (unbind-key "C-M-<left>" emmet-mode-keymap)
  (unbind-key "C-M-<right>" emmet-mode-keymap)
  :bind
  ("C-j" . emmet-expand-line)
  ((:map emmet-mode-keymap
         ("C-c [" . emmet-prev-edit-point)
         ("C-c ]" . emmet-next-edit-point)))
  )


(use-package yasnippet-snippets
  :defer t)


;;;; Yasnippet
(use-package yasnippet
  :defer 4
  :hook
  ((prog-mode . yas-minor-mode))
  ;:diminish yas-minor-mode
  :bind
  ("C-c C-n" . yas-new-snippet)
  :config
  (require 'yasnippet-snippets)
  (yas-reload-all)
  (setq
   yas-verbosity 1
   yas-wrap-around-region t)

  (with-eval-after-load 'yasnippet
    (setq yas-snippet-dirs
	  (list (concat config-dir "snippets")))
    (yas-reload-all)
    )
  (define-key yas-keymap [remap wakib-next] 'yas-next-field)
  (define-key yas-keymap [remap wakib-previous] 'yas-prev-field)
  :init
  (yas-global-mode)
  )

(use-package ivy-yasnippet
  :bind ("C-c C-y" . ivy-yasnippet))


;;;; ---- CONTROL DE VERSIONES

(use-package magit
  :defer 5
  :bind
  (("C-x g" . magit-status )))


;;;; ---- LENGUAJE

;; Markdown
(use-package markdown-mode
  :defer 5
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "markdown"))


;;;; Web - Html
(use-package web-mode
  :defer 5
  :config
  (add-to-list 'auto-mode-alist
               (cons (concat "\\." (regexp-opt '("html" "htm") t) "\\'")
                     'web-mode)))


;;;; Css
(use-package less-css-mode
  :defer 5)

(use-package sass-mode
  :defer t)


;;;; Javascript
(use-package rjsx-mode
  :defer 5)


;;;; Php
(use-package php-mode
  :defer 5)


;;;; Yaml
(use-package yaml-mode
  :defer 5)


;;;; Json
(use-package json-mode
  :defer 5)


;;;; Haskell
(use-package haskell-mode
  :defer 5)


;;;; Nim
(use-package nim-mode
  :defer 5
  :config
  (add-hook 'nim-mode-hook 'nimsuggest-mode))


;;;; Python
(use-package ob-ipython
  :defer 5)

(use-package elpy
  :defer 5)

(use-package python-mode
  :defer 5
  :config
  (setq py-split-window-on-execute nil))

;;;; Spray - Lectura veloz
;(use-package spray  :defer 5)


;;;; pomidor - timer de tecnica pomodro
(use-package pomidor
  :defer 5
  :bind (("<f12>" . pomidor))
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil
                pomidor-seconds (* 25 60)
                pomidor-break-seconds (* 5 60)
                pomidor-breaks-before-long 4
                pomidor-long-break-seconds (* 20 60)
                )
  :hook (pomidor-mode . (lambda ()
                          (display-line-numbers-mode -1) ; Emacs 26.1+
                          (setq left-fringe-width 0 right-fringe-width 0)
                          (setq left-margin-width 2 right-margin-width 0)
                          ;; force fringe update
                          (set-window-buffer nil (current-buffer)))))


;; ;; This assumes you've installed the package via MELPA.
;; (use-package ligature
;;   :config
;;   ;; Enable the "www" ligature in every possible major mode
;;   (ligature-set-ligatures 't '("www"))
;;   ;; Enable traditional ligature support in eww-mode, if the
;;   ;; `variable-pitch' face supports it
;;   (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
;;   ;; Enable all Cascadia Code ligatures in programming modes
;;   (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
;;                                        ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
;;                                        "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
;;                                        "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
;;                                        "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
;;                                        "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
;;                                        "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
;;                                        "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
;;                                        ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
;;                                        "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
;;                                        "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
;;                                        "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
;;                                        "\\\\" "://"))
;;   ;; Enables ligature checks globally in all buffers. You can also do it
;;   ;; per mode with `ligature-mode'.
;;   (global-ligature-mode t))


;; ;;;; typst
;; (use-package polymode)
;; (use-package rx)
;; (push (expand-file-name "modules/languages/typst-mode" user-emacs-directory) load-path)
;; (require 'typst-mode)



;; cfg-paquetes.el ends here
