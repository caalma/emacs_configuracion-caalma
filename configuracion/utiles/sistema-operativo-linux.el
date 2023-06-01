;;; sistema-operativo-linux.el - Utilidades para interactuar exclusivamente Linux -*- lexical-binding: t; -*-

;;;###autoload
(defun clm:audio-volumen-general (valor)
  "Ajusta el volumen general del audio al porcentaje pasado"
  (interactive "nPorcentaje: ")
  (let ((cmd (format "amixer -q -D pulse sset 'Master' %s%%" (int-to-string valor) )))
    (shell-command cmd)))


;;;###autoload
(defun clm:pantalla-hdmi-brillo (valor)
  "Pantalla HDMI: ajustar brillo al porcentaje pasado"
  (interactive "nPorcentaje: ")
  (let ((cmd (format "xrandr --output HDMI-1 --brightness %1.2f" (/ valor 100.0))))
    (shell-command cmd)))


;;;###autoload
(defun clm:pantalla-brillo (valor)
  "Pantalla NOTEBOOK: ajustar brillo al porcentaje pasado"
  (interactive "nPorcentaje: ")
  (let ((cmd (format "echo %d > /sys/class/backlight/intel_backlight/brightness" (/ (* valor 7500 ) 100) )))
    (clm:sudo-shell-command password_user cmd nil)))


;;;###autoload
(defun clm:sudo-shell-command (password command buffer)
  "Ejecuta un comando que como superusuario"
  (let ((proc (start-process-shell-command
               "*sudo*"
               buffer
               (concat "sudo bash -c "
                       (shell-quote-argument command)))))
    (process-send-string proc password)
    (process-send-string proc "\r")
    (process-send-eof proc)))



;;;###autoload
(defun clm:os-settings ()
  "Lanzador de seteos GUI del sistema operativo."
  (interactive)
  (let* ((options '(
		    :sonido "cinnamon-settings sound"
		    :audio "cinnamon-settings sound"
		    :brillo  "cinnamon-settings power -t 1"
		    :red "cinnamon-settings network"
		    :fondo "cinnamon-settings backgrounds"
		    :pantalla "cinnamon-settings display"
		    :monitor "gnome-system-monitor %s"
		    ))
	 (ll (clm:plist-keys options))
	 (cc 0)
	 (tt (length ll))
	 (kk nil)
	 (key nil)
	 (cmd nil))
    (while (< cc tt)
      (setq kk (cons (substring (format "%s" (car (nthcdr cc ll))) 1) kk))
      (setq cc (+ 1 cc)))
    (setq key (ido-completing-read "Seteo: " kk))
    (setq cmd (plist-get options (intern (format ":%s" key))))
    (if cmd (call-process-shell-command (concat cmd " &") nil 0))))


;;;###autoload
(defun clm:clipboard-get-htmltext ()
  "Pega al contenido del clipboard en formato html.
El contenido debe ser copiado inmediatamente antes de pegarlo."
  (interactive)
  (let* ((cmd (format
	       "python3 %slib-extra/clipboard_text_html.py"
	       caalma-pkg-directory))
	 (text (shell-command-to-string cmd)))
    (if text
	(insert text))))

;;; sistema-operativo-linux.el ends here
