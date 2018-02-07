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
#[10]
#[12]https://stackoverflow.com/questions/2712173/check-the-total-content-size-of-a-tar-gz-file
#[13] https://askubuntu.com/questions/155082/how-can-i-determine-the-size-of-an-image-from-the-command-line
#otras
#1.	https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/
#2.	https://www.computerhope.com/unix/ugrep.htm
#3.	https://ryanstutorials.net/bash-scripting-tutorial/bash-script.php
#4.	https://ryanstutorials.net/bash-scripting-tutorial/bash-input.php
#5.	https://www.linux.com/learn/writing-simple-bash-script
#6.	https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/
#7.	https://www.lifewire.com/what-to-know-less-command-4051972
#8.	https://www.digitalocean.com/community/tutorials/how-to-view-system-users-in-linux-on-ubuntu
#9.	https://www.unix.com/unix-for-dummies-questions-and-answers/134360-counting-total-users.html
#https://help.ubuntu.com/community/HowToMD5SUM
#https://www.computerhope.com/unix/uuniq.htm
#https://www.linux.com/learn/how-sort-and-remove-duplicate-photos-linux
