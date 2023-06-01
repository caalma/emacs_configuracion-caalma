;;; entorno.el - Entorno para usuario actual  -*- lexical-binding: t; no-byte-compile: t; -*-

;; Aquí deben colocarse las personalizaciones de inicio
;; Por ejemplo.


(setq
 initial-scratch-message "* NOTAS \n\n"
 initial-major-mode 'org-mode
 )

;; carga de documentos básicos
(find-file "~/tareas.org")

;; composición inicial de ventana
(split-window-right)
(switch-to-buffer "tareas.org")
(other-window 1)
(switch-to-buffer "*scratch*")
(other-window 1)


;;; entorno.el ends here
