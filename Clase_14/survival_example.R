# ----------------------------------------------------------
# Survival example: Uso de librerias para análisis de sobrevivencia.
# Jose Gallardo
# 06 noviembre 2021
# Diplomado en Analisis de datos con R para la Acuicultura
# ----------------------------------------------------------

# Habilita librería read.
library(survival)
library(ggplot2)
library(survminer)
library(ggpubr)
library(readxl)
library(dplyr)
library(tidyverse)

# Importa, explora set de datos y transforma variables de sobrevivencia
larv <- read_excel("surv_dat.xlsx", sheet = 1)
head(larv)
larv$sample_id = as.factor(larv$sample_id)
larv$antibiotico = as.factor(larv$antibiotico)
summary(larv)

# Crea objeto tipo sobrevivencia
surv_obj <- Surv(larv$stime, larv$status) # library(surviva)
class(surv_obj)
surv_obj

# Cálcula probabilidad de sobrevivencia de Kaplan-Meier y otras.
ps = survfit(formula=Surv(stime, status) ~ 
               strata(antibiotico), data=larv, na.action= na.exclude,type="kaplan-meier")

summary(ps)

# Permite probar si existen o no diferencias entre dos o más curvas de sobrevivencia

test_surv <- survdiff(formula=Surv(stime, status) ~ antibiotico, data=larv)
test_surv

# Grafica de sobrevivencisa con survminer
ggsurvplot(test_surv,conf.int = TRUE, ggtheme = theme_bw())
