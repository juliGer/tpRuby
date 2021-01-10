# Entrega 1

## Estructura
Existe una carpeta .my_rns que es la que va a contener los cuadernos y dentro de los cuadernos las notas. Dentro de éste hay un cuaderno_global que es el cuaderno que queda por defecto si no se indica que cuaderno usar.
A la hora de crear un cuaderno si no existe la carpeta .my_rns se crea dicha carpeta con el cuaderno_global dentro y a demas el libro que se solicitó crear.

## Instalación
Se debe ejecutar el siguiente comando posicionado en /rubyTP-1
```
bundle install
```

## Uso 
La primera vez se debe ejecutar el siguiente comando posicionado en /rubyTP-1 y cada vez que se cierre la consola tambien
```
export PATH="$(pwd)/bin:$PATH"
```
Una vez hecho eso a la hora de usarlo, posicionado en /rubyTP-1 ejecutar el siguiente comando para poder utilizar el programa
```
rn [args]
```

## Aclaración
A la hora de crear o renombrar una nota o un libro , si se envia el nombre encerrado en comillas (ejemplo "libro1" o "nota1") se va a crear el nombre con las comillas si esto no se quiere se deben colocar todos los nombres sin comillas para no tener este problema.

## TTY:Editor
A la hora de crear una nota o editarla se va a utiilizar TTY:Editor el cual te permite elegir que editor de texto usar

```
Select an editor? 
  1) nano -w
  2) vi
  3) code
  4) pico
  Choose 1-4 [1]: 
```

[fuente](https://github.com/piotrmurach/tty-editor)