module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]

        def call(name:, **)
          Dir.chdir("/home/#{ENV["USER"]}")
          name=name.delete("/")
          if(!Dir.exists? ".my_rns")
            Dir.mkdir(".my_rns")
            Dir.chdir(".my_rns")  
            Dir.mkdir("cuaderno_global")
          end
          Dir.chdir("/home/#{ENV["USER"]}/.my_rns")
          if(!Dir.exists? name)
            Dir.mkdir(name)
            puts "Se creo el cuaderno #{name}"
          else
            puts "El libro #{name} ya existe"
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
          global = options[:global]
          Dir.chdir("/home/#{ENV["USER"]}")
          if(!Dir.exists? ".my_rns")
            puts "No existe la carpeta .my_rns, debe crearla y crear un book"
          else
            Dir.chdir(".my_rns")
            if global 
              FileUtils.rm_rf(Dir.glob('cuaderno_global/*'))
              puts "Se borró el contenido de cuaderno_global"
            else
              if(Dir.exists? name)
                FileUtils.remove_dir(name)
                puts "Se borró el cuaderno #{name}"
              else
                puts "No existe el libro que ingresó"
              end
            end
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          Dir.chdir("/home/#{ENV["USER"]}/.my_rns")
          system("ls")
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          Dir.chdir("/home/#{ENV["USER"]}")
          old_name=old_name.delete("/")
          new_name=new_name.delete("/")
          if(!Dir.exists? ".my_rns")
            puts "No existe la carpeta .my_rns, debe crearla y crear un book"
          else
            Dir.chdir(".my_rns")
            if(Dir.exists? old_name)
              File.rename(old_name, new_name)
              puts "Se renombró el libro #{old_name} por el nombre #{new_name}"
            else
              puts "No existe el nombre del libro "
            end
          end
        end
      end
    end
  end
end
