;;; multimedia.el - Utilidades para reproducir multimedia -*- lexical-binding: t; -*-


(defconst clm:mpv-interfaz " --player-operation-mode=pseudo-gui ")


;;;###autoload
(defun clm:mpv-gui ()
  "Abre la interfaz gráfica de mpv."
  (interactive)
  (call-process-shell-command "mpv --player-operation-mode=pseudo-gui -- &" nil 0))


;;;###autoload
(defun clm:mpv (path)
  "Reproduce la url o uri con mpv."
  (call-process-shell-command (concat "mpv " clm:mpv-interfaz path " &") nil 0))


;;;###autoload
(defun clm:mpv-url-at-point ()
  "Envia la url bajo el cursor a `clm:mpv'."
  (interactive)
  (clm:mpv (thing-at-point 'url t)))


;;;###autoload
(defun clm:mpv-filename-at-point ()
  "Envia la ruta de archivo bajo el cursor a `clm:mpv'."
  (interactive)
  (clm:mpv (thing-at-point 'filename t)))


;;;###autoload
(defun clm:mpv-line-at-point ()
  "Envia la linea bajo el cursor a `clm:mpv'."
  (interactive)
  (clm:mpv (thing-at-point 'line t)))


;;;###autoload
(defun clm:mpv-at-region ()
  "Envia la región actual a `clm:mpv'."
  (interactive (list (region-beginning) (region-end)) )
  (clm:mpv (buffer-substring start end)))


;;; multimedia.el ends here
