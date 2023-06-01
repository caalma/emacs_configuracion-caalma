;;; cfg-utiles.el - Administración de utilidades -*- lexical-binding: t; -*-


;;;; ---- CONSTANTES Y VARIABLES

(defconst utiles-dir (concat config-dir "utiles/"))
(defconst clm:os-linux (string-equal system-type "gnu/linux"))
(defconst clm:os-windows (string-equal system-type "windows-nt"))
(defconst clm:os-file-explorer
  (cond
   (clm:os-linux "xdg-open")
   (clm:os-windows "explorer.exe")))


;;;; ---- CARGA

(load (concat utiles-dir "general"))
(load (concat utiles-dir "listas"))
(load (concat utiles-dir "textos"))
(load (concat utiles-dir "tiempos")) ; FALTA - especificar variante de date para windows
(load (concat utiles-dir "online"))
(load (concat utiles-dir "registro"))
(load (concat utiles-dir "sistema-operativo"))
(if clm:os-linux (load (concat utiles-dir "sistema-operativo-linux")))
;(if clm:os-linux (load (concat utiles-dir "multimedia")))


;;; cfg-utiles.el ends here
