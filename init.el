;;; init.el   -*- no-byte-compile: t -*-


;;;; tiempo de carga - iniciar
(defvar startup-time (current-time))


;;;; Carpeta de configuración de emacs
(defconst emacs-dir (file-name-directory load-file-name))
(defconst usuario-dir (concat emacs-dir "usuario/"))


;;;; Carga de configuración
(load (concat emacs-dir "configuracion/cfg-iniciar"))
(load (concat usuario-dir "entorno-base"))


;;;; tiempo de carga - finalizar
(message "Control de tiempo: %.2fs (total) | %s (interno)"  (float-time (time-subtract (current-time) startup-time)) (emacs-init-time))


;;; init.el ends here
