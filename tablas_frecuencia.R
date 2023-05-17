
#TABLAS DE FRECUENCIA

#-----------------------------------------------------------------------------

#Ejemplo: Nacimientos en 2017 y 2018
#Fuente de datos: https://microdatos.dane.gov.co/index.php/catalog/652/get-microdata

library(pacman)
p_load(dplyr)

read.csv("C:\Users\User\Documents\Big_Data\Datasets_personal\NACIMIENTOS\nac2018.csv")

base2018 <- read.csv("~/Big_Data/Datasets_personal/NACIMIENTOS/nac2018.csv")

base2018
glimpse(base2018)
variable.names(base2018)

#1 - Tabla de frecuencia absoluta

mytab <- base2018 %>% select(N_HIJOSV)
mytab2 <- table(mytab) %>% as.data.frame()

View(mytab2)

#2 - Tabla de frecuencia relativa

mytab3 <- prop.table(table(mytab)) %>% as.data.frame()

View(mytab3)

#3 - Histograma