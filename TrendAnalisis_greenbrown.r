library(raster)
library(greenbrown)
library(mapview)

r <- raster("SMAP_L4_C_mdl_20150415T000000_Vv7042_001_SOCGtest.tif")
mapview(r)
shp<-vect("C:/Users/luisf/Documents/Maestria/2024-1/Soil_Resurces/Guatemala.shp")
str(shp)
mapview(shp)

mx<-shp[which(shp$name=="Guatemala"),]
mx<-as(mx, "Spatial")

# Cargar el stack de rasters para calcular tendencias
file.choose() #buscar un archivo y obtener la ruta
setwd("C:/Users/luisf/Documents/Maestria/2024-2/Diplomado/Guatemala")
rstack <- stack("GuatemalaTest_stack.tif") #cargar raster stack
mapview(rstack[[1]]) #visualizar el primer raster

# Analsisi de tendencia usando greenbrown
trendmap <- TrendRaster(rstack, start=c(2015, 1), freq=365, method="STM", breaks=0) #analisis anual sin puntos de quiebre
mapview(trendmap) #visualizar los tres raster resultantes
