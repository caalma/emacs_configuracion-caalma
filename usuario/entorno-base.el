;;; entorno.el - Entorno para usuario actual  -*- lexical-binding: t; no-byte-compile: t; -*-

;; Aquí deben colocarse las personalizaciones de inicio
;; Por ejemplo.


;;; archivos de uso básico
(if t
    (progn
      (setq
       initial-scratch-message "* NOTAS \n\n"
       initial-major-mode 'org-mode
       )

      ;; carga de documentos básicos
      (find-file "~/tareas.org")

      ;; composición inicial de ventana
      (switch-to-buffer "tareas.org")

      ;; activar modo deamon - server
      (server-start)

      ;; tipografia
      (set-face-attribute 'default nil :font "FiraCode" :height 100)
      (set-frame-font "FiraCode" nil t)

      ))
;;; entorno.el ends here
