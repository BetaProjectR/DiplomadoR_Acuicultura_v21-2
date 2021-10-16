# ----------------------------------------------------------
# dplyr example: Script para manipular datos
# Jose Gallardo
# 10 octubre 2021
# Diplomado en Analisis de datos con R para la Acuicultura
# ----------------------------------------------------------

# Habilita librerías
library(readxl) # Para importar datos a R

library(dplyr) # Para manipular datos

# LIBRERÍA DPLYR: EL OPERADOR PIPE (TUBERIA).
# dplyr usa el operador pipe %>% como una tubería para enlazar un data.frame con una o más funciones.

x <- rnorm(5)
y <- rnorm(5)
dat <- data.frame(x,y)
dat
max(dat) 
dat %>% max
dat %>% arrange(y) # Ordena filas de un data.frame por el valor de alguna columna

# ESTUDIO DE CASO: MUESTREO DE PECES
peces <- read_excel("Peces.xlsx")
head(peces)
summary(peces)

# FUNCIÓN SELECT()
# Permite extraer o seleccionar variables/columnas específicas de un data.frame.
select(peces, Especie, Sexo)

# FUNCIÓN SELECT() CON PIPE
peces %>% select(Especie, Sexo)

# FUNCIÓN FILTER() CON PIPE
# **filter()**: Para filtrar desde una tabla de datos un subconjunto de filas.
# Ej. solo un nivel de de un factor, observaciones que cumplen algún criterio (ej. > 20).
peces %>% filter(Sexo == "Macho")

# MÚLTIPLES FUNCIONES Y TUBERÍAS
peces %>% select(Especie, Sexo, Peso) %>% 
  filter(Sexo == "Macho")

# FUNCIÓN SUMMARIZE()

peces %>% select(Especie, Sexo, Peso, Parasitos) %>% 
  summarize(Minimo_Peso = min(Peso), 
            Minimo_Parasitos = min(Parasitos))

# FUNCIÓN SUMMARIZE() + GROUP_BY()
# Permite agrupar filas con base a los niveles de alguna variable o factor.

peces %>% group_by(Especie) %>% 
  summarize(n = n(), 
            Minimo_Peso = max(Peso),
            Promedio_peso= mean(Peso))

# FUNCIÓN MUTATE()
# Permite calcular nuevas variables "derivadas". Util para calcular proporciones, tasas.

peces %>% select(Especie, Peso, Parasitos) %>% 
  mutate(Densidad_parasitos = Parasitos/Peso)
