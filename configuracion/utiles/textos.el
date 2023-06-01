;;; textos.el - Utilidades para trabajar con textos -*- lexical-binding: t; -*-


;;;###autoload
(defun clm:new-buffer-from-region (start end)
  "Create new buffer with contents of region from START to END."
  (interactive "r")
  (let ((buf (generate-new-buffer (format "*extracto de <%s>*" (buffer-name))))
        (text (buffer-substring start end)))
    (with-current-buffer buf (insert text))
    (display-buffer buf)))



;;;###autoload
(defun clm:duplicate-line ()
  "Duplicate actual line below."
  (interactive)
  (beginning-of-line)
  (let ((start (point)))
    (end-of-line)
    (insert (concat "\n" (buffer-substring start (point))))))


;;;###autoload
(defun clm:md-to-org ()
  "Convertir estructura Markdown a Org"
  (interactive)
  (save-excursion
    (let ((niveles 6))
      (while (> niveles 0)
	(goto-char 1)
	(replace-regexp
	 (format "^%s " (s-repeat niveles "#"))
	 (format "%s " (s-repeat niveles "*")))
	(setq niveles (- niveles 1)))
      (goto-char 1)
      (replace-regexp "^+ " "  + "))))


;;;###autoload
(defun clm:normalizar-texto (tex &optional ree)
  "Reemplaza signos no permitidos por '_' . "
  (let (
	(ree (or ree "_"))
	(val (split-string "abcdefghijklmnopqrstuvwxyz0123456789_" ""))
	(alt-k (split-string "áéíóúñ" ""))
	(alt-v (split-string "aeioun" ""))
	(tex (split-string (downcase tex) ""))
	(res nil)
	(cnt 0)
	(tot (length tex))
	(sig nil)
	(pas nil)
	)
    (while (< cnt tot)
      (setq sig (car (nthcdr cnt tex)))
      (setq pas (index-in-list sig val))
      (setq alt-pas (index-in-list sig alt-k))
      (setq res (cons (cond
		       (alt-pas (car (nthcdr alt-pas alt-v)) )
		       (pas sig)
		       (t ree))
		      res ))
      (setq cnt (+ 1 cnt)))
    (apply 'concat (reverse res))))


;;;###autoload
(defun clm:normalizar-texto-at-region (start end)
  "Normaliza la región.
Utilizar `clm:normalizar-texto'."
  (interactive
   (list (region-beginning) (region-end)))
  (let ( (text (buffer-substring start end)))
    (kill-region start end)
    (insert (clm:normalizar-texto text))))


;;;###autoload
(defun clm:encomillar-palabra (start end)
  "Encomilla con `, la región seleccionada"
  (interactive
   (list (region-beginning) (region-end)))
  (save-excursion
    (let ((s "`"))
      (goto-char start)
      (insert s)
      (goto-char (+ end 1))
      (insert s))))


;;;###autoload
(defun clm:encomillar-bloque-lisp (start end)
  "Encomilla con ```, la región seleccionada"
  (interactive
   (list (region-beginning) (region-end)))
  (save-excursion
    (let ((ini "```lisp\n") (fin "\n```\n"))
      (goto-char start)
      (insert ini)
      (goto-char (+ end (length ini)))
      (insert fin)
      )))


;;;###autoload
(defun clm:conmutar-tilde-en-vocales ()
  "Acentuar o des-acentuar vocales"
  (interactive)
  (let (
	(a (char-to-string (char-after)))
	(po (point))
	(signos '(
		  ("a" "á")
		  ("e" "é")
		  ("i" "í")
		  ("o" "ó")
		  ("u" "ú")
		  ("A" "Á")
		  ("E" "É")
		  ("I" "Í")
		  ("O" "Ó")
		  ("U" "Ú")
		  )))
    (while signos
      (setq s (car signos))
      (if (equal (car s) a)
	  (progn
	    (delete-char 1)
	    (insert (car (cdr s)))
	    (goto-char po)
	    )
	(if (equal (car (cdr s)) a)
	    (progn
	      (delete-char 1)
	      (insert (car s))
	      (goto-char po)
	      )))
      (setq signos (cdr signos))
      )))


;;;###autoload
(defun clm:yt-url-minify ()
  "Minimiza la URL normal de youtube.com en todo el buffer o región-acotada."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "https://www.youtube.com/watch?v=" nil t)
      (replace-match "https://youtu.be/" t))))


;;;###autoload
(defun clm:list-re-match (re)
  (let (
	(mm nil)
	(pi nil)
	(pf nil)
	)
    (save-excursion
      (while (re-search-forward re nil t)
	(setq pf (point))
	(backward-word)
	(setq pi (point))
	(setq mm (cons (buffer-substring-no-properties pi pf) mm))
	(goto-char pf)))
    mm))


;;;###autoload
(defun clm:list-sum (li in fi)
  (let ((re 0))
    (while li
      (setq re (+ re (string-to-number (substring (car li) in fi))))
      (setq li (cdr li)))
    re))


;;; textos.el ends here
