# ----------------------------------------------------------
# R script example
# Jose Gallardo
# 02 octubre 2021
# Diplomado en Analisis de datos con R para la Acuicultura
# ----------------------------------------------------------

# Version R
R.version.string

# ¿Como citar R?
citation()

# Remover objetos de la sesion de trabajo
rm(list = ls())

# En que directorio estoy
getwd()

# Listar archivos en el directorio actual
list.files()

# Crear un objeto
NewFolder <- "directorio"

# Listar objetos 
ls()

# Crear un directorio o carpeta llamada directorio
dir.create(file.path("/cloud/project/", NewFolder))

# Configurar en que directorio trabajar
setwd("/cloud/project/directorio")

# En que directorio estoy
getwd()

# Listar archivos en el directorio actual
list.files()

# Listar librerías o packages disponibles en mi entorno de trabajo
search()

# Obtener ayuda de un comando
help(plot)

# Graficar un objeto preexistente
plot(BOD)

# Observar un objeto preexistente
BOD

# Obtener la clase de un objeto
class(BOD)
