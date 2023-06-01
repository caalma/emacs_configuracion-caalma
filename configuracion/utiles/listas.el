;;; listas.el - Utilidades para listas -*- lexical-binding: t; -*-


;;;###autoload
(defun clm:index-in-list (elem list)
  "Verfica si el item está en la lista."
  (let ((res nil)
	(cnt 0)
	(tot (length list)))
    (while (< cnt tot)
      (if (equal elem (car (nthcdr cnt list)))
	  (progn
	    (setq res cnt)
	    (setq cnt tot)))
      (setq cnt (+ 1 cnt)))
    res))


;;;###autoload
(defun clm:plist-keys (list)
  "Devuelve la lista de keys de una plist."
  (let ( (cnt 0)
	 (keys nil))
    (while (< cnt (length list))
      (setq keys (cons (car (nthcdr cnt list)) keys) )
      (setq cnt (+ 2 cnt)))
    (reverse keys)))


;;; listas.el ends here
