#PUNTO 1
#El comando grep busca un patron, que puede ser una palabra,letras,numeros, 
#etc, dentro de un archivo, carpeta o dentro de todos los archivos que cumplan con 
#determinada condicion. Luego los imprime en pantalla. Asimismo, grep tiene varias 
#opciones de entrada que permiten filtrar o restringir la busqueda. Por ejemplo, -i
#permite realizar una busqueda en donde no se diferencien mayusculas de minusculas. 
#De igual forma, -r permite hacerlo de manera recursiva; -h hace que no se muestren
#los nombres de los archivos, entre otros [1,2].

#PUNTO 2: 
#En primer lugar se debe saber que un shell script es un archivo de texto 
#que contiene una serie de comandos. Script hace referencia a la forma en la cual se
#escriben los comandos de forma que se ejecuten consecutivamente y no se tenga que 
#escribir y correr linea por linea en la terminal. Shell hace referencia al interprete
#de comandos. Asi pues, la parte de "#!" permite que el shell decida cual interprete
#usar para correr el resto del codigo. Lo que le sigue al #! es la direccion en la 
#cual se encuentra dicho interprete. Entonces, en nuestro caso, bash es el 
#interprete a utilizar para correr el codigo y /bin/bash es la direccion para llegar
#a el [3,4,5]. 

#PUNTO 3:
#En primer lugar, se tuvo que haber clonado el repositorio con la carpeta IBIO4680.
#Luego, se sabe que el archivo /etc/passwd es aquel que contiene los atributos de cada
#usuario. Asi pues, este contiene una entrada por linea para cada usuario. Codos los
#atributos estan separados por dos puntos  ":" y en total son 7 de estos. EL nombre 
#del usuario, la contrase;a, el ID de usuario, el grupo, la informacion, el directorio
#y la direccion del shell [6]. De esta forma, sabiendo que este archivo nos brinda infor-
#macion del usuario, nos interesaria ver que sucede al ejecutar este comando. Este se
#ejecuta de la forma: "less /etc/passwd", el comando less hace que la informacion de
#un archivo de texto se muestre, no completo, sino una pagina a la vez [7]. AL ejecu-
#tar esta linea de comando se obtienen varias lineas (una por usuario), asi:
			#root:x:0:0:root:/root:/bin/bash
#Alli se pueden observar los 7 atributos. 

#De esta forma, hay varias maneras para contar cuantos usuarios hay locales hay. Una
#seria agregandole al comando anterior un "wc -l" que lo que va a hacer es contar el 
#numero de lineas que se encontraron en el comando anterior (cut). Asi pues, ejecu-
#tando "less /etc/passwd | wc /l" nos da el resultado de 42. 

#Otra manera seria primero, de cada linea de usuario, extraer unicamente el nombre
#de dicho usuario y luego contar dichas palabras (-w) o lineas (-l). En ambos casos se 
#obtuvo el mismo resultado [8].
 
#Aun otra manera seria "wc -l < /etc/passwd", esto significa que cuente las lineas
#dentro del archivo passwd que dijimos que contine los atributos de los usuarios [9].



#PUNTO 4:
#Se utiliza la funcion "cut" y se especifica los lugares de corte con "-d ':'". Luego, 
#al usuario le corresponde el field 1 (f1) y al shell el field 7 (f7), por lo que al 
#ordenar se usa "sort" y se especifica el campo con el comando "-k7", que corresponde
# a organizar a partir de lla columna 7, que es la del shell.[9]

#El codigo implementado fue el siguiente:
#grep "/bin/bash" /etc/passwd | cut -d':' -f1-7 | sort | grep "/bin/bash" /etc/passwd | cut -d':' -f1-7 | sort -k7 | uniq

#PUNTO 5


#PUNTO 6
#se utiliza wgte para obtener archivo de internet, se especifica "-c" para que el archivo
# continue la descarga si se ha interrumpido por alguna razon.[11]

# El codigo implementado fue el siguiente:
# wget -c imbords "http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_bsds500.tgz"

#REFERENCIAS
#[9] https://www.thegeekstuff.com/2013/06/cut-command-examples
#[11] https://askubuntu.com/questions/207265/how-to-download-a-file-from-a-website-via-terminal
