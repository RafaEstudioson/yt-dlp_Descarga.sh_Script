# Descarga.sh
Descarga.sh es una bazofía creada por mí (Rafa) en Bash que permite descargar canciones de una forma simple y agradable.
Lo actualizaré cada tanto en tanto añadiendo cosas que yo considere agradables o necesarias, pero cero promesas de nada porque Bash me tiene enfrentado.

## Instalación

### yt-dlp

Descarga pipx y luego descarga yt-dlp.
```bash
sudo apt install -y pipx
pipx install --force "yt-dlp[default]"
```

## Cookies

Las Cookies son la manera con la que YouTube verifica tu identidad, lo que permite descargar canciones que requieran de dicha verificación.
Recomiendo utilizar un plugin como [YouTube Cookies Exporter](https://github.com/reiarseni/youtube-cookies-exporter) para extraer las Cookies, y extraerlas de una cuenta basura que no te importe si es baneada (¡pues esta actividad de descargas ilegítimas no está bien vista por YouTube!)

Las opciones de las Cookies solo se añadirán si existe un fichero cookies.txt en la carpeta raíz de donde se ubica el proyecto, por lo que no debería dar problemas si eligues no utilizar Cookies. Espero. Ruego.
