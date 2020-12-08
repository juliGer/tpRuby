require 'github/markup'

module ExportHtml
    def exportHtml(title)
        titleMd="#{title}"
        titleMd.slice! ".rn"
        titleRn=titleMd
        titleMd=titleRn+".md"
        File.open(titleMd,"w")
        rn=File.read(title)
        File.open(titleMd,"w") do |f|
            f.puts rn
        end
        IO.copy_stream(title,titleMd)
        file = GitHub::Markup.render(titleMd, File.read(titleMd))
        File.open(titleMd,"w") do |f|
            f.puts file
        end
        File.rename(titleMd,titleRn+".html")
    end

    def exportDirectoryHtml()
        files=Dir["#{Dir.pwd}/*.rn"]
        files.each do |item| 
          self.exportHtml(item)
        end
    end

    def exportAll()
        files=Dir["#{Dir.pwd}/*"]
        files.each do |item|
            Dir.chdir(item) 
            self.exportDirectoryHtml()
        end
    end

end