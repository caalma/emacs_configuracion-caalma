;;; init-compilar.el   -*- no-byte-compile: t -*-

;;;; Compila todos los .el anidados en la carpeta actual
;; Este archivo debería estar ubicado en ~/.emacs.d/
;; Puede llamarse con: emacs -l ~/.emacs.d/init-compilar.el

(byte-recompile-directory (concat (file-name-directory load-file-name) "/configuracion") 0)
;(byte-recompile-directory (concat (file-name-directory load-file-name) "/elpa") 0)

(princ "Compilación finalizada!\n" #'external-debugging-output)
(kill-emacs)
