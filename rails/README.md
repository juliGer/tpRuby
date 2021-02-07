# TTPS Ruby
    Application for the administration of books and notes for the subject ttps of the Faculty Of Informatics UNLP
   
## Requirements

1. ruby ≥ 2.7.1
2. rails ≥ 6.1.1
3. bundler gem

## How to run 

1. Open a terminal
2. Go to the rails directory
3. Run `bundle install` to get all the required gems
4. Run `yarn`
4. Run `createDatabase.sh` to create database an load seed
5. Run `./bin/webpack` to load styles
6. Run `rails s` to start the web server
7. Go to http://localhost:3000/
8. Enjoy it :wink:!

## Decisions

A la hora de crear un usuario , a éste se le va a asignar un cuaderno global el cual no se puede modificar ni borrar solamente se le pueden crear notas, ver su contenido y exportar su contenido a html.
Se utilizó la gema devise para la autenticación de usuarios , la cual permite crear , logearse y mantener la aplicación segura si no se encuentra registrado en el sistema.
La aplicación utiliza sqlite3 y esto se decidió porque el alcance de la aplicación no es grande entonces con sqlite alcanzaba.
A demas se utilizo redcarpet para la exportacion de codigo md a html el cual permite renderizarlo en una pagina dentro del navegador.

## Gems

1.[Devise](https://github.com/heartcombo/devise)
2.[Redcarpet](https://github.com/vmg/redcarpet)