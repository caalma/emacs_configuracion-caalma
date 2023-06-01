;;; cfg-iniciar.el - Inicializar configuración  -*- lexical-binding: t; -*-


;;;; ---- VARIABLES Y CONSTANTES

(defconst config-dir (file-name-directory load-file-name))


;;;; ---- CARGA DE CONFIGURACIONES

(load (concat config-dir "cfg-seteos.el"))
(load (concat config-dir "cfg-paquetes.el"))
(load (concat config-dir "cfg-utiles"))
(load (concat config-dir "cfg-teclas"))


;;; cfg-iniciar.el ends here
