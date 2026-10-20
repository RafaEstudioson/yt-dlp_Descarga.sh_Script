#!/bin/bash

CarpetaRoot="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "* ¿Quieres descargar como Vídeo (1) o Audio (2)?"
read Audio

echo ""
if [ "$Audio" != "1" ] && [ "$Audio" != "2" ]
then
  echo "* Puto imbécil creyéndose gracioso VETE YA!!!!!!!!11"
else
  echo "* ¿Desea descargar a traveś de URL (1) o que busquémos el vídeo que desea? (2)"
  read Busqueda
  echo ""
  if [ "$Busqueda" = "1" ]
  then
    echo "* ¡Inserta la URL de YouTube que Deseas Descargar!"
    read Descarga
  elif [ "$Busqueda" = "2" ]
  then
    echo "* ¡Inserta el Título del Vídeo que Deseas Descargar!"
    read Descarga
  else
    echo "* Esa no es una opción... Asumiré que quieres buscar el título del video... Megalomongolo..."
    read Descarga
  fi

  echo ""
  echo "* ¿En alguna carpeta en específico?"
  read Carpeta
  if [ -d "$Carpeta" ]
  then
    echo "* Carpeta detectada correctamente..."
    cd "$Carpeta"
  elif [ -z "$Carpeta" ]
  then
    echo "* En la carpeta actual pues. (Dónde se ubica el bash)"
  else
    echo "* Error. La carpeta que ha introducido no existe."
    echo "* ¿Desea crearla? (Si o No)"
    read Eleccion
    if [ "${Eleccion,,}" = "si" ] || [ "${Eleccion,,}" = "sí" ]
    then
      echo "* Creando carpeta(s)..."
      mkdir -p "$Carpeta"
      cd "$Carpeta"
    else
      echo "* Se descargarán en la carpeta actual pues. (Dónde se ubica el bash)"
    fi
  fi

  echo ""
  echo "* Comenzando la descarga..."
  echo "..."
  echo ""
  OpcionesDescarga=(
    --js-runtime node
    --remote-components ejs:github
    --add-metadata
    --embed-thumbnail
  )
  Cookies=""$CarpetaRoot"/cookies.txt"
  if [ -f $Cookies ]
  then
    OpcionesDescarga+=(--cookies "$Cookies")
  fi
  if [ "$Audio" = "1" ]
  then
    OpcionesDescarga+=(--remux-video mp4)
    OpcionesDescarga+=(--embed-subs)
    OpcionesDescarga+=(--sub-langs all)
    OpcionesDescarga+=(--embed-chapters)
    OpcionesDescarga+=(--sponsorblock-mark all)
  else
    OpcionesDescarga+=(-x --audio-format mp3)
    OpcionesDescarga+=(--parse-metadata "%(playlist_uploader,artist|)s:^(?P<first_artist>[^,]+)")
    OpcionesDescarga+=(--parse-metadata "%(album_artist,first_artist|)s:%(meta_album_artist)s")
    OpcionesDescarga+=(--parse-metadata "playlist_index:%(track_number)s")
    OpcionesDescarga+=(--ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"")
    OpcionesDescarga+=(--sponsorblock-remove all)
  fi
  if [ "$Busqueda" = "1" ]
  then
    yt-dlp "${OpcionesDescarga[@]}" "$Descarga"
  else
    yt-dlp "${OpcionesDescarga[@]}" "ytsearch:$Descarga"
  fi
  echo ""
  echo "* ¡Descarga finalizada correctamente!"
fi
