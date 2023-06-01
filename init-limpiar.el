;;; init-limpiar.el   -*- no-byte-compile: t -*-

;;;; Limpia la configuración
;; Requiere python. Solo por compatibilidad en varios sistemas operativos.
;; Este archivo debería estar ubicado en ~/.emacs.d/
;; Puede llamarse con: emacs -l ~/.emacs.d/init-limpiar.el


(defconst emacs-dir (file-name-directory load-file-name))
(defconst script-dir (concat emacs-dir "configuracion/lib-extra/"))

(defun remove_dir (path)
  "Borra la carpeta indicada."
  (shell-command (concat "python3 " script-dir "borrar_carpeta.py '" path "'")))

(defun remove_file_recursive (path filter)
  "Borra los archivos que coinciden con el pattern, recursivamente desde la raiz."
(shell-command (concat "python3 " script-dir "borrar_archivos_recursivo.py '" path "' '" filter "'")))

(defun remove_file (path)
  "Borra el archivo indicado."
(shell-command (concat "python3 " script-dir "borrar_archivo.py '" path "'")))


;;;; eliminar carpetas temporales
(remove_dir (concat emacs-dir "auto-save-list"))
(remove_dir (concat emacs-dir "transient"))
(remove_dir (concat emacs-dir "snippets"))
;;(remove_dir (concat emacs-dir "elpa")); IMPORTANTE : descomentar la siguiente linea para eliminar todos los paquetes de repositorios instaldos


;;;; eliminar archivos temporales
(remove_file (concat emacs-dir "projectile-bookmarks.eld"))
(remove_file (concat emacs-dir "recentf"))
(remove_file (concat emacs-dir "ido.last"))
(remove_file (concat emacs-dir "smex-items"))

;;;; eliminar archivos emacs-lisp compilados: "*.elc"
(remove_file_recursive emacs-dir "*.elc")

;;;; eliminar archivos de sesiones previas: "session.*"
(remove_file_recursive emacs-dir "session.*")


(princ "Limpieza finalizada!\n" #'external-debugging-output)
(kill-emacs)
