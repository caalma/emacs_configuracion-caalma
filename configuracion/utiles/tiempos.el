;;; tiempos.el - Utilidades para trabajar con tiempos -*- lexical-binding: t; -*-

;;;###autoload
(defun clm:instante ()
  "Inserta el instante actual, en segundos unix"
  (interactive)
  (insert
   (concat (clm:cmd-shell-output "date +'%s'") ";")))


;;;###autoload
(defun clm:instante-fecha ()
  "Inserta la fecha actual"
  (interactive)
  (insert
   (clm:cmd-shell-output "date +'%Y-%m-%d'")))


;;;###autoload
(defun clm:instante-hora ()
  "Inserta la hora actual"
  (interactive)
  (insert (clm:cmd-shell-output "date +'%H:%M:%S'")))


;;;###autoload
(defun clm:instante-duracion (instante)
  "Inserta la duración entre dos instantes.
El formato de los instantes es en segundos, separados por ';'.
Generados normalmente por `clm:instante'. Por ejemplo: 123;234;"
  (interactive "s\"Instante;Instante;\": ")
  (let* (
	 (instante
	  (split-string instante ";"))
	 (inst-a (string-to-number (car instante)))
	 (inst-b (string-to-number (car (cdr instante))))
	 (segundos (- (abs (- inst-a inst-b )) 75600 ))
	 (cmd (format "date +'%s' --date='@%s'" "%Hh %Mm %Ss" segundos))
	 )
    (insert (clm:cmd-shell-output cmd))))


;;;###autoload
(defun clm:instante-duracion-from-region (reg-ini reg-end)
  "Inserta la duración entre los dos instantes ubicados en la región seleccionada.
Utiliza `clm:instante-duracion'.
"
  (interactive (list (region-beginning) (region-end)))
  (let ( (instante (buffer-substring reg-ini reg-end)))
    (clm:instante-duracion instante)))


;;;###autoload
(defun clm:instante-hms-a-segundos (h m s)
  "Inserta la conversiónde  Horas, Minutos y Segundos a Segundos Totales."
  (interactive "nHora: \nnMinutos: \nnSegundos: ")
  (insert (format "%s" (+ s (* 60 (+ m (* h 60 )))))))


;;;###autoload
(defun clm:sumar-tiempos ()
  "Suma los tiempos disponibles en lo que sigue del buffer.
Utilizar patrones como 1h, 20m o 25s."
  (interactive)
  (let (
	(hh (clm:list-sum (clm:list-re-match "[[:digit:]]\\{1,2\\}h") 0 -1))
	(mm (clm:list-sum (clm:list-re-match "[[:digit:]]\\{1,2\\}m") 0 -1))
	(ss (clm:list-sum (clm:list-re-match "[[:digit:]]\\{1,2\\}s") 0 -1))
	)
    (if (>= ss 60)
	(progn
	  (setq mm (+ mm (/ ss 60)))
	  (setq ss (mod ss 60))))
    (if (>= mm 60)
	(progn
	  (setq hh (+ hh (/ mm 60)))
	  (setq mm (mod mm 60))))
    (insert (format "%sh %sm %ss" hh mm ss))))


;;; tiempos.el ends here
