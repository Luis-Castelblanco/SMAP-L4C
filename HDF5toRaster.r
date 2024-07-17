library(raster)
library(rhdf5)
library(terra)
library(mapview)

file.choose() #buscar un archivo y obtener la ruta

# Cargar shape del area de interes
shp<-vect("C:/Users/luisf/Documents/Maestria/2024-2/Diplomado/Guatemala/test.shp")
mx<-as(shp, "Spatial") # convertirlo en objeto tipo espacial

# Extraccion de informacion de los HDF5

setwd("C:/Users/luisf/Documents/Maestria/Tesis/SMAP L4C/") #carpeta donode estan los HDF5

files <- list.files(pattern = ".h5$", recursive = TRUE, full.names = TRUE) #listar los archivos

# hacer un for que itere por cada archivo listado
for (file in files) {
  d <- H5Fopen(file) #abre el archivo para usarlo
  dls <- h5ls(d) #lista el contenido del archivo
  testSubset <- h5read(file = d, name = "SOC/soc_mean") #extrae la matriz de interes
  r <- raster(t(testSubset)) #construye un raster con la matriz
  crs(r) <- CRS("EPSG:6933") #asigan la proyeccion EASE 2.0
  extent(r) <- extent(-17367530, 17367530, -7314540, 7314540) #extent de la proyeccion
  r[r == -9999] <- NA #etiquetar los NA
  r_wgs84 <- projectRaster(r, crs = CRS("EPSG:4326")) #proyectar a WGS84
  output_file <- gsub(".h5", "_SOCtest.tif", file) #reemplazar la extención con un identificador y ,tif
  writeRaster(r_wgs84, output_file, overwrite = TRUE) #guardar el raster
  
}
