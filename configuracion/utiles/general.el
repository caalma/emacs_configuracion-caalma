;;; general.el - Utilidades generales -*- lexical-binding: t; -*-


;;;###autoload
(defun clm:word-wrap-toggle ()
  "Conmuta el valor de la variable word-wrap"
  (interactive)
  (setq word-wrap (not word-wrap)))


;;;###autoload
(defun clm:insert-filename ()
  "Inserta el la ruta absoluta al buffer actual."
  (interactive)
  (let ( (name
	  (if (buffer-file-name)
	      (buffer-file-name)
	    (buffer-name))))
    (insert name)))


;;;###autoload
(defun clm:run-this-script ()
  "Ejecuta el buffer actual.
Debe ser un script, y poseer permisos de ejecución."
  (interactive)
  (save-buffer)
  (shell-command (buffer-file-name)))


;;;###autoload
(defun clm:reload-init ()
  "Carga nuevamente la configuración de emacs."
  (interactive)
  (load-file user-init-file))


;;; general.el ends here
