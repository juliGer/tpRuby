require 'tty-editor'


class Note
    def create(title,**options)
        book = options[:book]
        if !title.include? ".rn"
          title = title+".rn"
        end
        Dir.chdir("/home/#{ENV["USER"]}")
        title=title.delete("/")
        if(!Dir.exists? ".my_rns")
          puts "No existe la carpeta .my_rns, debe crearla y crear un book"
        else
          Dir.chdir(".my_rns")
          if book
            if(Dir.exists? book)
              Dir.chdir(book)
              if(File.exists? title)
                puts "La nota ya existe en #{Dir.pwd}"
              else
                File.open(title, "w")
                TTY::Editor.open("#{title}")
                puts "La nota fue creada en #{Dir.pwd}"
              end
            else
              puts "No existe el libro que envió como parametro debe crearlo"
            end
          else
            Dir.chdir("cuaderno_global")
            if(File.exists? title)
              puts "La nota ya existe en #{Dir.pwd}"
            else
              File.open(title, "w")
              TTY::Editor.open("#{title}")
              puts "La nota fue creada en #{Dir.pwd}"
            end
          end
        end
    end

    def delete(title,**options)
        book = options[:book]
        if !title.include? ".rn"
          title = title+".rn"
        end
        Dir.chdir("/home/#{ENV["USER"]}")
        if(!Dir.exists? ".my_rns")
          puts "No existe la carpeta .my_rns, debe crearla y crear un book"
        else
          Dir.chdir(".my_rns")
          if book
            if(Dir.exists? book)
              Dir.chdir(book)
              if(File.exists? title)
                File.delete(title)
                puts "Se eliminó la nota #{title} en el libro #{book}"
              else
                puts "No existe el nombre de la nota "
              end
            else
              puts "No existe el libro que envió como parametro debe crearlo"
            end
          else
            Dir.chdir("cuaderno_global")
            if(File.exists? title)
              File.delete(title)
              puts "Se eliminó la nota #{title} en cuaderno_global"
            else
              puts "No existe el nombre de la nota en el cuaderno_global"
            end
          end
        end
    end

    def edit(title,**options)
        book = options[:book]
        if !title.include? ".rn"
            title = title+".rn"
        end
        Dir.chdir("/home/#{ENV["USER"]}")
        if(!Dir.exists? ".my_rns")
            puts "No existe la carpeta .my_rns, debe crearla y crear un book"
        else
            Dir.chdir(".my_rns")
            if book
                if(Dir.exists? book)
                Dir.chdir(book)
                if(File.exists? title)
                    TTY::Editor.open("#{title}")
                else
                    puts "No existe el nombre de la nota #{title} en el libro #{book}"
                end
                else
                puts "No existe el libro que envió como parametro debe crearlo"
                end
            else
                Dir.chdir("cuaderno_global")
                if(File.exists? title)
                TTY::Editor.open("#{title}")
                else
                puts "No existe el nombre de la nota en el cuaderno_global"
                end
            end
        end
    end

    def retitle(old_name,new_name,**options)
        book = options[:book]
        if !old_title.include? ".rn" 
          old_title = old_title+".rn"
        end
        if !new_title.include? ".rn"
          new_title = new_title+".rn"
        end
        Dir.chdir("/home/#{ENV["USER"]}")
        if(!Dir.exists? ".my_rns")
          puts "No existe la carpeta .my_rns, debe crearla y crear un book"
        else
          Dir.chdir(".my_rns")
          if book
            if(Dir.exists? book)
              Dir.chdir(book)
              if(File.exists? old_title)
                File.rename(old_title, new_title)
              else
                puts "No existe el nombre de la nota #{title} en el libro #{book}"
              end
            else
              puts "No existe el libro que envió como parametro debe crearlo"
            end
          else
            Dir.chdir("cuaderno_global")
            if(File.exists? old_title)
              File.rename(old_title, new_title)
            else
              puts "No existe el nombre de la nota en el cuaderno_global"
            end
          end
        end
    end

    def list(**options)
        book = options[:book]
        global = options[:global]
        Dir.chdir("/home/#{ENV["USER"]}")
        if(!Dir.exists? ".my_rns")
          puts "No existe la carpeta .my_rns, debe crearla y crear un book"
        else
          Dir.chdir(".my_rns")
          if book
            if(Dir.exists? book)
              Dir.chdir(book)
              system("ls")
            else
              puts "No existe el libro que envió como parametro debe crearlo"
            end
          else
            Dir.chdir("cuaderno_global")
            system("ls")
          end
        end
    end 
    
    def show(title,**options)
        book = options[:book]
        if !title.include? ".rn"
          title = title+".rn"
        end
        Dir.chdir("/home/#{ENV["USER"]}")
        if(!Dir.exists? ".my_rns")
          puts "No existe la carpeta .my_rns, debe crearla y crear un book"
        else
          Dir.chdir(".my_rns")
          if book
            if(Dir.exists? book)
              Dir.chdir(book)
              if(File.exists? title)
                puts File.read(title)
              else
                puts "No existe el nombre de la nota #{title} en el libro #{book}"
              end
            else
              puts "No existe el libro que envió como parametro debe crearlo"
            end
          else
            Dir.chdir("cuaderno_global")
            if(File.exists? title)
              puts File.read(title)
            else
              puts "No existe el nombre de la nota en el cuaderno_global"
            end
          end
        end
    end

    def export(title,**options)
      Dir.chdir("/home/#{ENV["USER"]}/.my_rns/libro1")
      titleMd="#{title}"
      titleRn=titleMd.slice! ".rn"
      titleMd=titleRn+".md"
      File.open(titleMd,"w")
      IO.copy_stream(title,titleMd)
      file = GitHub::Markup.render(titleMd, File.read(titleMd))
      File.open(titleMd,"w") do |f|
        f.puts file
      end
      File.rename(titleMd,titleRn+".html")
    end
end