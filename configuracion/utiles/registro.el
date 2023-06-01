;;; registros.el - Organizador de registros por clave -*- lexical-binding: t; -*-


;;; Ejemplo de uso:
;; (defvar notas-list nil "Lista NOTAS compuesta por pares (clave, archivo).")
;; (defun !notas (key)
;;   "Abre un buffer según la clave buscada en el registro de NOTAS (notas-list)."
;;   (interactive (list (completing-read "Clave: " (registro-keys notas-list) )))
;;   (registro-open (registro-path notas-list key))
;;   )


;;;###autoload
(defun clm:registro-keys (current-list)
  "Devuelve la lista de claves asociada al registro asignado."
  (let (
	(cnt 0)
	(keys nil)
	(tot (length current-list)))
       (while (> tot cnt)
	 (setq keys (cons (car (car (nthcdr cnt current-list))) keys))
	 (setq cnt (1+ cnt)))
       keys))


;;;###autoload
(defun clm:registro-add (list items)
  "Agrega a la lista de referencia los items pasados como plist."
  (let* (
	 (cnt 0)
	 (k nil)
	 (lis (clm:plist-keys items))
	 (tot (length lis)))
    (while (< cnt tot)
      (setq k (car (nthcdr cnt lis)) )
      ;;(message "%s" k)
      (add-to-list list (list
			  (substring (format "%s" k) 1)
			  (plist-get items k)))
      (setq cnt (+ 1 cnt)))))


;;;###autoload
(defun clm:registro-path (current-list bus)
  "Devuelve la ruta de la clave buscada en el registro asignado."
  (let (
	(cnt 0)
	(res nil)
	(tot (length current-list)))
    (while (and (< cnt tot) current-list)
      (if (equal bus (car (car (nthcdr cnt current-list))))
	  (progn
	    (setq res (car (cdr (car (nthcdr cnt current-list)))))
	    (setq current-list nil)))
      (setq cnt (1+ cnt)))
  res))


;;;###autoload
(defun clm:registro-open (path)
  "Abre un registro si existe."
  (if path
      (find-file path)
    (message "ERROR: ruta no válida !")))


;;; registro.el ends here
