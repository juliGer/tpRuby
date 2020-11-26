require 'tty-editor'
require_relative '../modules/exportHtml.rb'

class Note
    include ExportHtml
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
      book = options[:book]
      if title
        if !title.include? ".rn"
          title = title+".rn"
        end
      end
      Dir.chdir("/home/#{ENV["USER"]}")
      if(!Dir.exists? ".my_rns")
        puts "No existe la carpeta .my_rns, debe crearla y crear un book"
      else
        Dir.chdir(".my_rns")
        if book
          if(Dir.exists? book)
            Dir.chdir(book)
            if title
              if(File.exists? title)
                exportHtml(title)
              else
                puts "No existe el nombre de la nota #{title} en el libro #{book}"
              end
            else
              exportDirectoryHtml()
            end
          else
            puts "No existe el libro que envió como parametro debe crearlo"
          end
        else 
          if title
            if(File.exists? title)
              exportHtml(title)
            else
              puts "No existe el nombre de la nota #{title} en el libro #{book}"
            end
          else
            exportAll()
          end
        end
      end
    end
end