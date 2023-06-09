
#TABLAS DE FRECUENCIA----

#-----------------------------------------------------------------------------

#Ejemplo: Información de Nacimientos en 2017 y 2018 del DANE
#Fuente de datos: https://microdatos.dane.gov.co/index.php/catalog/652/get-microdata
#En esta misma página se puede encontrar el diccionario de datos de los archivos

#1 - Alistamiento----

  #Cargamos paquetes y librerías necesarios
  library(pacman)
  library(RColorBrewer) #La usaremos para paletas de colores
  p_load(dplyr)

  #Cargamos y limpiamos los datos que trabajaremos
  base2018 <- read.csv("~/Big_Data/Datasets_personal/NACIMIENTOS/nac2018.csv")

  #Una breve visualización de los datos y los campos que los campos que componen el archivo
  base2018                  #Opción 1
  glimpse(base2018)         #Opción 2 (revisar este método de visualización)
  variable.names(base2018)  #Opción 3

#2 - Tablas de frecuencia absoluta----
  
  ##Tabla de 1 Variable----

  #Seleccionamos una variable para trabajar. Algunos ejemplos:
  
  base2018$SEXO        #Importante: revisar las convenciones para cada valor que toma la variable  
  base2018$MES
  base2018$EDAD_MADRE
  base2018$TIPO_PARTO
  
  #Generamos una tabla por cada variable
  #Resulta útil revisar si el campo a trabajar contiene valores NA
  
  table(x = base2018$SEXO,  #nombre del campo/variable/objeto
        exclude = NULL,     #niveles a remover de la tabla
        useNA = 'always')   #instrucción de lo que se desea con los NA
  
  table(base2018$MES)
  table(base2018$EDAD_MADRE)
  table(base2018$TIPO_PARTO)
  table(base2018$SEG_SOCIAL)
  
  #Agregamos el nombre de los factores en cada variable para hacer las tablas más comprensibles, según corresponda.
  base2018$SEXO = factor(base2018$SEXO,levels=c(1,2,3),labels=c("Masculino", "Femenino", "Indeterminado"))
  base2018$TIPO_PARTO = factor(base2018$TIPO_PARTO,levels=c(1,2,3,4,9),
                               labels=c("Espontáneo", "Cesárea", "Instrumentado", "Ignorado", "Sin información"))
  base2018$SEG_SOCIAL = factor(base2018$SEG_SOCIAL,levels=c(1,2,3,4,5,9),
                               labels=c("Contributivo", "Subsidiado", "Excepción", "Especial","No asegurado", "Sin información"))
  
  
  #Visualizamos nuevamente las tablas con el nombre de los factores
  table(base2018$SEXO)
  table(base2018$TIPO_PARTO)
  table(base2018$SEG_SOCIAL)
  
  ##Tabla de 2 variables----
  
  #Ejemplo Tabla 1
  table(base2018$SEXO, base2018$TIPO_PARTO)
  
  #Ejemplo Tabla 2
  base2018$AREA_RES = factor(base2018$AREA_RES,levels=c(1,2,3,9),labels=c("Cabecera municipal", "Centro poblado", "Rural disperso", "Sin información"))
  table(base2018$TIPO_PARTO, base2018$AREA_RES)
  table(base2018$AREA_RES, base2018$TIPO_PARTO) #Tabla anterior invertida
  table(base2018$SEG_SOCIAL, base2018$TIPO_PARTO)
  table(base2018$SEG_SOCIAL, base2018$AREA_RES)
  
  
#3 - Tablas de frecuencia relativa----
  
  ##Tabla de 1 variable-----
  
  #Cuando no tenemos una tabla específica creada
  prop.table(table(base2018$SEXO))  
  prop.table(table(base2018$SEXO))*100  #Esta es una forma de acercar el resultado a un valor porcentual (aun falta el signo %)
  
  #Utilizando una tabla específica
  tab1 <- table(base2018$SEXO)
  tab1
  prop.table(tab1)
  
  
  ##Tabla de 2 variables----
  
  tab2 <- table(base2018$SEG_SOCIAL, base2018$AREA_RES)
  tab2
  
  #Porcentajes globales
  prop.table(x = table(base2018$SEG_SOCIAL, base2018$AREA_RES))
  prop.table(tab2)
  
  #Porcentajes por fila (1)
  prop.table(x = table(base2018$SEG_SOCIAL, base2018$AREA_RES),margin = 1)
  prop.table(tab2, margin = 1)
  
  #Porcentajes por columna (2)
  prop.table(x = table(base2018$SEG_SOCIAL, base2018$AREA_RES),margin = 2)
  prop.table(tab2, margin = 2)

  ##Estilo porcentaje (opción rápida)
  prop.table(tab2)*100
  prop.table(tab2, margin = 1)*100
  prop.table(tab2, margin = 2)*100
  
#4 - Tablas con totales----
  
  #Cuando no tenemos una tabla específica
  addmargins(table(base2018$SEXO, base2018$TIPO_PARTO))    #Totales globales
  addmargins(table(base2018$SEXO, base2018$TIPO_PARTO), 1) #Totales en columnas
  addmargins(table(base2018$SEXO, base2018$TIPO_PARTO), 2) #Totales en filas
  
  #Con una tabla creada
  addmargins(tab2)    #Totales globales
  addmargins(tab2, 1) #Totales en columnas
  addmargins(tab2, 2) #Totales en filas
  
  #Tabla de 1 variable
  addmargins(tab1)   #Total global (es una variable, será el total de fila)


#5 - Diagramas----
#En otro script profundizaré respecto a diagramas
  
  #Diagramas de barras
  barplot(table(base2018$SEXO), col=c("#00008B","#CD3333", "#458B00"), #Ejemplo 1
          xlab="Sexo", ylab="Frecuencia", 
          main="Estudio de Nacimientos.\n Distribución por sexos.")
  
  barplot(table(base2018$AREA_RES),                                   #Ejemplo 2
          xlab="Area de Residencia", ylab="Frecuencia", 
          main="Estudio de Nacimientos.\n Distribución según área de residencia.")
  
  #Diagrama circular
  pie(table(base2018$SEXO), col=c("lightblue","pink", "#F0E68C"),
      main="Estudio de Nacimientos.\n Distribución por sexos.")

  coul1 <- brewer.pal(5, "Pastel2")
  pie(table(base2018$AREA_RES),col=coul1,
      main="Estudio de Nacimientos.\n Distribución según área de residencia.")
  
  #Diagrama de barras 2 variables - Frecuencia absoluta
  
  coul2 <- brewer.pal(5, "Dark2")
  barplot(table(base2018$TIPO_PARTO, base2018$SEXO),
          beside=TRUE,
          legend=TRUE,
          xlab="Sexo de nacimiento", 
          ylab="Frecuencia",
          col= coul2, 
          main="Distribución de nacimientos 2018 \n Según sexo y tipo de parto")
  
  
  #Diagrama de barras 2 variables - Frecuencia relativa
  tab3 = with(base2018,prop.table(table(SEXO, TIPO_PARTO),2)) #Especificamos al final "2" porcentaje por columna 
  coul3 <- brewer.pal(3, "RdBu")
  barplot(tab3,
          beside = TRUE,               #Especifica si las columnas deben ser yuxtapuestas
          legend = TRUE,               #Leyenda con la clave de de las series
          ylim = c(0,1),               #Valor mínimo y máximo para el eje Y
          xlab = "Sexo de nacimiento", 
          ylab="Proporción del resultado",
          col=coul3, 
          main="Distribución de nacimientos 2018 \n Según tipo de parto y sexo de nacimiento")
  
  #Para el siguiente ejemplo utilizo una manera diferente de definir los colores
  tab4 = with(base2018,prop.table(table(TIPO_PARTO, SEXO),2)) #Especificamos al final "2" porcentaje por columna 
  barplot(tab4,
          beside = TRUE,               #Especifica si las columnas deben ser yuxtapuestas
          legend = TRUE,               #Leyenda con la clave de de las series
          ylim = c(0,1),               #Valor mínimo y máximo para el eje Y
          xlab = "Sexo de nacimiento", 
          ylab="Proporción del resultado",
          col=c("#D7191C", "#FDAE61", "#FFFFBF", "#A6D96A", "#1A9641"),
          main="Distribución de nacimientos 2018 \n Según tipo de parto y sexo de nacimiento")
  
  
