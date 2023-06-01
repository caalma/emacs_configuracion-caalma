;;; online.el - Utilidades para trabajo online -*- lexical-binding: t; -*-


;;;###autoload
(defun clm:ddg-search(bus)
  "Búsca el texto especificado en DuckDuckGo"
  (interactive (list
		(read-string "DDG ?: " nil 'ddg-history "")))
  (browse-url (format "https://duckduckgo.com/?q=%s" bus)))


;;;###autoload
(defun clm:ddg-search-at-region (start end)
  "Busca el texto seleccionado en DuckDuckGo.
Utiliza `clm:ddg-search'."
  (interactive (list (region-beginning) (region-end)) )
  (clm:ddg-search (buffer-substring start end)))


;;;###autoload
(defun clm:google-translate(texto &optional lang-origen lang-destino )
  "Abre google translate con el texto a traducir.
También asigna los parámetros de lenguaje origen y destino."
  (interactive (list
		(read-string "Texto: " nil 'gtranslate-history "")
		(read-string "Idioma texto (default 'en'): " nil 'gtranslate-lang-history "")
		(read-string "Idioma a traducir (default 'es'): " nil 'gtranslate-lang-history "")))
  (setq lang-origen (or lang-origen "en"))
  (setq lang-destino (or lang-destino "es"))
  (browse-url (format
	       "https://translate.google.com/?op=translate&sl=%s&tl=%s&text=%s"
	       lang-origen lang-destino texto)))


;;;###autoload
(defun clm:gtr-esp-to-eng-at-region (start end)
  "Abre google translate online con el texto de la región actual.
Seteado para traducir de Español a Inglés.
Utiliza `clm:google-translate'."
  (interactive (list (region-beginning) (region-end)))
  (clm:google-translate (buffer-substring start end) "es" "en"))


;;;###autoload
(defun clm:gtr-eng-to-esp-at-region (start end)
  "Abre google translate online con el texto de la región actual.
Seteado para traducir de Inglés a Español.
Utiliza `clm:google-translate'."
  (interactive (list (region-beginning) (region-end)))
  (clm:google-translate (buffer-substring start end) "en" "es"))


;;;###autoload
(defun clm:pexels-search(bus)
  "Búsca el texto especificado en DuckDuckGo"
  (interactive (list
		(read-string "Pexels ? " nil 'pexels-history "")))
  (browse-url (format "https://www.pexels.com/search/%s" bus)))


;;;###autoload
(defun clm:yt-title (url)
  "Inserta el título del video de youtube pasado como url."
  (interactive "sURL: ")
  (let (
	(cmd (format "python -c \"u = '%s'; import pyquery; d = pyquery.PyQuery(url=u); t = d.find('meta[name=title]').eq(0).attr('content');c = d.find('link[itemprop=name]').eq(0).attr('content'); print(f' # [{c}] - {t}')\"" url)))
    (insert (clm:cmd-shell-output cmd))))


;;;###autoload
(defun clm:yt-title-at-point ()
  "Inserta el título del video de youtube cuya url está bajo el punto actual.
Utiliza `clm:yt-title'."
  (interactive)
  (let ((u (thing-at-point 'url t))
	(actual-point (point)))
    (end-of-line)
    (clm:yt-title u)
    (goto-char actual-point)))


;;;###autoload
(defun clm:web-page-title (url)
  "Inserta el título de la página web pasada como url."
  (interactive "sURL: ")
  (let ( (cmd (format "python -c \"u = '%s'; import pyquery; d = pyquery.PyQuery(url=u); t = d.find('title').eq(0).text(); print(f' # {t}')\"" url)))
    (insert (clm:cmd-shell-output cmd))))


;;;###autoload
(defun clm:web-page-title-at-point ()
  "Inserta el título de la página web cuya url está bajo el punto actual.
Utiliza `clm:web-page-title'."
  (interactive)
  (let ( (u (thing-at-point 'url t)))
    (end-of-line)
    (clm:web-page-title u)))


;;; online.el ends here
