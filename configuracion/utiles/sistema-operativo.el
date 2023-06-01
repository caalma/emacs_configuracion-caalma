;;; sistema-operativo.el - Utilidades para interactuar con el sistema operativo -*- lexical-binding: t; -*-


;;;###autoload
(defun clm:cmd-shell-output(cmd)
  "Ejecuta un comando bash y devuelve el resultado sin espacios
en los extremos"
  (replace-regexp-in-string "\n*\s*$" ""
			    (shell-command-to-string cmd)))

;;;###autoload
(defun clm:open-folder()
  "Abre la carpeta actual en el file browser nativo."
  (interactive)
  (call-process-shell-command (concat clm:os-file-explorer " .") nil 0))


;;;###autoload
(defun clm:open-file ()
  "Mostrar archivo con visor nativo."
  (interactive)
  (let ((fn (thing-at-point 'filename t)))
    (call-process-shell-command  (concat clm:os-file-explorer " " fn) nil 0)))


;;; sistema-operativo.el ends here
