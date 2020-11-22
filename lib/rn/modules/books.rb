module Book
    def create(name)
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
    
    def delete(name,**options)
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
    
    def list
      Dir.chdir("/home/#{ENV["USER"]}/.my_rns")
      system("ls")
    end

    def rename(old_name,new_name)
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