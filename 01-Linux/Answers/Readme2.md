#PUNTO 7
#Inicialmente, antes de descomprimir, se utiliza el comando gzip para ver
# el peso de los archivos comprimidos y descomprimidos, que es de 70763455 bits 
#y 74332160 bits respectivamente.[12] Luego, una vez se descomprimen los
# archivos, nos dirigimos a la carpeta y usando el comando "find" y el 
#"comando wc -l" se cuenta el numero de lineas que corresponde al numero de imagenes, 
#500 en total.
 
#Codigo:

#Mirar el tamaño:
	#gzip -l BSR_bsds500.tgz 
#Contar imagenes:
	#find . -name \*.jpg -or -name \*.mat | wc -l

#PUNTO 8 

# Utilizando el comando identify, obtenemos la informacion de la imagen, incluyendo
# el tamaño, formato y la clase. En este caso, todas tienen formato JPG y tamaño 321x481/481x321.[13]

# Codigo:
# identify "path_de_la_imagen"


#Referencias
#[12]https://stackoverflow.com/questions/2712173/check-the-total-content-size-of-a-tar-gz-file
#[13] https://askubuntu.com/questions/155082/how-can-i-determine-the-size-of-an-image-from-the-command-line
