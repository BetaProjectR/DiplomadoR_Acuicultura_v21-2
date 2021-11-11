# ----------------------------------------------------------
# dplyr example: Uso del comando gather para re-ordenar columnas a filas
# Jose Gallardo
# 16 octubre 2021
# Diplomado en Analisis de datos con R para la Acuicultura
# ----------------------------------------------------------

# Habilita librería read.
library(readxl)
library(dplyr)

# Importa y explora set de datos Copepodos
dat_cop <- read_excel("Copepodos.xlsx", sheet = 1)
head(dat_cop)

# El siguiente comando gather re-ordena 4 columnas en filas:
# Nauplio, Copepodito, Hembra y Macho.
# Es necesario dar un nombre a las 4 columnas: "Estado de desarrollo"
# Es necesario nombrar la nueva variable: "Densidad"
# Es necesario indicar que columnas deseo reordenar en fila: 3-6

new_dat_cop <- dat_cop %>% 
  tidyr::gather("Estado de desarrollo", "Densidad", 3:6)

new_dat_cop
