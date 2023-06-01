;;; cfg-teclas.el - Atajos de teclado -*- lexical-binding: t; -*-


;;;; desactivación de funciones
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x f"))

;;;; ventana
;; movimiento
(when (fboundp 'windmove-default-keybindings)
  (global-set-key (kbd "C-. <left>")  'windmove-left)
  (global-set-key (kbd "C-. <right>") 'windmove-right)
  (global-set-key (kbd "C-. <up>")    'windmove-up)
  (global-set-key (kbd "C-. <down>")  'windmove-down))

;; ajuste
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)

;;;; buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)  ;; No pregunta antes de matar un buffer.

;;;; textos
;; correcciones
(global-set-key (kbd "s-'") 'clm:conmutar-tilde-en-vocales)

;; encomillados
;; (global-set-key (kbd "C-,") 'clm:encomillar-palabra)
;; (global-set-key (kbd "C-M-,") 'clm:encomillar-bloque-lisp)

;; visualizacion de textos y lineas
(global-set-key (kbd "<f9>") 'toggle-truncate-lines)
(global-set-key (kbd "M-<f9>") 'clm:word-wrap-toggle)
(global-set-key (kbd "C-c C-d") 'clm:duplicate-line)

;; momentos: instante, fecha y hora
(global-set-key (kbd "C-c i i") 'clm:instante)
(global-set-key (kbd "C-c i f") 'clm:instante-fecha)
(global-set-key (kbd "C-c i h") 'clm:instante-hora)
(global-set-key (kbd "C-c i d") 'clm:instante-duracion-region)

;; completados / scrap
(global-set-key (kbd "C-c y") 'clm:yt-title-at-point)
(global-set-key (kbd "C-c t") 'clm:web-page-title-at-point)

;;;; navegacion por archivos
;;(global-set-key (kbd "C-c RET") 'clm:open-file)
;;(global-set-key (kbd "C-c SPC") 'clm:open-file)
;;(global-set-key (kbd "C-c M-RET") 'browse-url-at-point)
(global-set-key (kbd "<f2>") 'clm:open-folder)

;;;; tamaño de texto en buffer
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-<mouse-4>") 'text-scale-increase)
(global-set-key (kbd "C-<mouse-5>") 'text-scale-decrease)


;;;; búsquedas
;;(global-set-key (kbd "C-c o") 'occur)

;;;; ejecuciones, script
(global-set-key (kbd "s-z") 'clm:run-this-script)


;;; cfg-teclas.el ends here
