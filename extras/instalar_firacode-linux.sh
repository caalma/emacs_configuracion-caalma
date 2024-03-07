#!/usr/bin/env bash

fonts_dir="${HOME}/.fonts/FiraCode/"


version=6.2
zip=Fira_Code_v${version}.zip


mkdir -p "${fonts_dir}"
echo "Creada carpeta destino : ${fonts_dir}"

curl --fail --location --show-error https://github.com/tonsky/FiraCode/releases/download/${version}/${zip} --output ${zip}
unzip -o -q -d ${fonts_dir} ${zip}
echo "Descargados y descomprimidos los archivos de la fuente"

rm ${zip}
rm -rf ${fonts_dir}woff
rm -rf ${fonts_dir}woff2
rm ${fonts_dir}fira_code.css
rm ${fonts_dir}specimen.html
echo "Borrados: paquete original, fuentes para web."

fc-cache -f
echo "Actualizado cache de tipografía"
