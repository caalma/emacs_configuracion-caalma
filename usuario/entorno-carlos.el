;;; cfg-entorno.el - Seteos y Entorno de para este Usuario  -*- lexical-binding: t; no-byte-compile: t; -*-

;;; variables de configuración
(defconst password_user (car (nthcdr 1 (split-string (shell-command-to-string "echo -n $(cat ~/Datos/Cuentas/usuario.txt)") ";" ))))

;;;; registros propios
(defvar notas-list nil "Lista NOTAS compuesta por pares (clave, archivo).")
(defun notas (key)
  "Abre un buffer según la clave buscada en el registro de NOTAS (notas-list)."
  (interactive (list (ido-completing-read "Clave: " (clm:registro-keys notas-list) )))
  (clm:registro-open (clm:registro-path notas-list key)))

(defvar ayudas-list nil "Lista AYUDAS compuesta por pares (clave, archivo).")
(defun ayudas (key)
  "Abre un buffer según la clave buscada en el registro de AYUDAS (ayudas-list)."
  (interactive (list (ido-completing-read "Clave: " (clm:registro-keys ayudas-list) )))
  (clm:registro-open (clm:registro-path ayudas-list key)))

;;; asignar claves para archivos comunes
(if t
    (progn
      (clm:registro-add
       'notas-list (list
                    :servicios "/home/carlos/Escritorio/0_Cotidiano/notas/servicios.org"
                    :salud "/home/carlos/Escritorio/0_Cotidiano/notas/salud.org"
                    :peliculas-series "/home/carlos/Escritorio/0_Cotidiano/notas/peliculas_series.org"
                    :manualidades "/home/carlos/Escritorio/0_Cotidiano/notas/manualidades.org"
                    :musica "/home/carlos/Escritorio/0_Cotidiano/notas/musica.org"
                    :recetas-alimentos "/home/carlos/Escritorio/0_Cotidiano/notas/recetas-alimentos.org"
			        :aprendizaje "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/tecnicas_de_estudio/info.org"
			        :desafios "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/desafios/info.org"
			        :emacs "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/emacs_lisp/info.org"
                    :lisp "/home/carlos/Datos/Archivo/Documentos/Organizado/programacion/lenguajes/lisp/info.org"
			        :lojban "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/idiomas/lenguajes_logicos/lojban/info.org"
			        :matematicas "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/matematicas/info.org"
		            :nim "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/nim/info.org"
			        :programacion "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/programacion/info.org"
			        :python "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/python/info.org"
		            :astronomia "/home/carlos/Datos/Archivo/Documentos/Organizado/ciencia/astronomia/info.org"
		            :calistenia "/home/carlos/Datos/Archivo/Documentos/Organizado/salud/calistenia/info.org"
		            :javascript "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/programacion/lenguajes/javascript/info.org"
		            :prog-lang "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/programacion/lenguajes/0__bases/info.org"
		            :suscripciones-yt "/home/carlos/Datos/Programas/nodos/suscripciones_yt/suscripciones_yt.txt"
		    ))
      (clm:registro-add
       'ayudas-list (list
		     :emacs "/home/carlos/Escritorio/0_Cotidiano/aprendiendo/emacs_lisp/ayuda.org"
		     :matematicas "/home/carlos/Datos/Archivo/Documentos/Organizado/matematicas/ayudas.org"
		     :org-mode "/home/carlos/Datos/Archivo/Documentos/Organizado/programacion/lenguajes/lisp/emacs_lisp/ayuda-orgmode.org"
   		     ))
      ))

;;; archivos de uso básico
(if t
    (progn
      ;; personalización de scratch
      (setq initial-scratch-message "* NOTAS \n\n"
	    initial-major-mode 'org-mode)

      ;; carga de documentos básicos
      (find-file "~/.emacs.d/usuario/entorno-carlos.el")
      (find-file "~/Escritorio/0_Cotidiano/tareas.org")
      (find-file "~/Escritorio/0_Cotidiano/datos/dat-00.txt")

      ;; composición inicial de ventana
      (split-window-right)
      (switch-to-buffer "tareas.org")
      (other-window 1)
      (switch-to-buffer "*scratch*")
      (other-window 1)
      ))

;;; cfg-entorno.el ends here
