;;; cfg-seteos.el - Seteos generales -*- lexical-binding: t; -*-


;;;; custom
(setq custom-file (concat config-dir "custom.el"))
(load custom-file)


;;;; codificacion
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)


;;;; confirmaciones
(fset 'yes-or-no-p 'y-or-n-p)  ; reajuste de confirmaciones
(setq
 confirm-kill-emacs nil  ; no pregunta al cerrar emacs
 confirm-kill-processes nil  ; no pregunta al eliminar processo
 )


;; respaldos
(setq
 auto-save-default nil  ; previene autograbado
 create-lockfiles nil  ; previene la creación de respaldos pre-grabado
 make-backup-files nil  ; previene backups
 )


;;; rutas
(setq
  default-directory "~/" ; directorio por defecto
  )


;;;; interfaz
(setq
 ring-bell-function 'ignore  ; Elimina el sonido de la campana
 use-dialog-box nil  ; desactiva visualizacion de confirmaciones en gui - x11
 visible-bell t  ; activa la alerta visual
 inhibit-startup-screen t ; impide que se cargue la pantalla de bienvenida
 scroll-error-top-bottom t ; ignora errores de exceso de scroll
 initial-scratch-message ""
 )

(blink-cursor-mode nil) ; cursor estático
(column-number-mode t) ; muestra número de columna en barra de buffer
(line-number-mode 1) ; muestra número de linea en la barra de buffer


(global-font-lock-mode t) ; Siempre mostra resaltado de sintaxis
(global-hl-line-mode t) ; habilita hiqghligth para la linea actual

(set-fringe-mode nil) ; define el padding del buffer

(size-indication-mode nil) ; deshabilita peso del documento en barra de buffer
(global-linum-mode t) ; números de linea
(delete-selection-mode t) ; sobreescribir texto seleccionado al pegar

(scroll-bar-mode 0) ; desabilitación de la barra de scroll
(toggle-scroll-bar -1)

(menu-bar-mode 0) ; desabilitación de la barra de menu
(tool-bar-mode 0) ; desabilitación de la barra de herramientas
(tooltip-mode 0) ; deshabilita la ayuda de texto en botones gui

;;;; carga de archivos
(setq
 gc-cons-threshold 50000000  ; reduccion de frecuencia de actualización de garbage collection, hasta alcanzar 50Mb
 large-file-warning-threshold 10000000  ; alerta para archivos mayores a 100MB
 )


;;;; portapapeles
(setq
 select-enable-clipboard t  ; sistema de fusión y portapapeles de Emacs.
 )


;;;; textos
(show-paren-mode 1) ; activar modo de paréntesis

(setq-default
 truncate-lines nil
 indent-tabs-mode nil ; Prefers spaces over tabs, tabs are evil
 tab-width 4 ; Set width for tabs
 )

(setq
 show-paren-delay 0 ; retardo de indicación de paréntesis asociado
 show-paren-style 'parenthesis ; estilo de paréntesis
 word-wrap t  ; activa el corte de palabras
 )


;;;; rastreo de documentos
(setq
  find-file-existing-other-name t  ; Encuentra un búfer existente, incluso si tiene un nombre diferente. Esto evita problemas con los enlaces simbólicos.
)


;;;; formatos comunes
(display-time-mode 1) ; Display time in the mode-line
(setq
  display-time t ; muestra el reloj
  display-time-24hr-format t ; formato 24 horas
  display-time-format "%H:%M" ; formato a la hora
  )


;;;; hooks
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ; ajustes específicos de modos
(add-hook 'text-mode-hook 'visual-line-mode) ; corte de línea sensible


;;;; pantalla completa
(set-frame-parameter nil 'fullscreen 'fullboth) ; activa la visualización en pantalla completa


;;;; explorador de archivos. dired
(setq
 dired-listing-switches "-agho --group-directories-first"  ; Sort Dired buffers
 dired-dwim-target t  ; Copy and move files netween dired buffers
 delete-by-moving-to-trash t  ; Move deleted files to trash
 image-dired-external-viewer "/usr/bin/xdg-open"  ; abre las imagenes con visor del sistema
 )
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "C-t C-d") 'image-dired)
    (define-key dired-mode-map (kbd "C-<return>") 'image-dired-dired-display-external))


;;;; habilitación de funciones
(put 'narrow-to-region 'disabled nil) ; regiones acotadas
(put 'upcase-region 'disabled nil) ; modificadores de mayúsculas
(put 'downcase-region 'disabled nil) ; modificadores de minúsculas
(put 'capitalize-region 'disabled nil) ; modificadores de capitalizaciones
(put 'dired-find-alternate-file 'disabled nil) ; abre dired en el mismo buffer


;;; cfg-seteos.el ends here
