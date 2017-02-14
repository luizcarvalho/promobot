require 'fileutils'
arquivos = Dir['logo*.svg']

arquivos.each do |arquivo|
  base_name = arquivo[0..-5]
  puts "Gerando arquivos para #{base_name}"
  FileUtils.mkdir_p base_name
  [100, 256, 512, 1024, 3000].each do |width|
    print '.'
    system("inkscape --export-png #{base_name}/#{base_name}-#{width}.png -w #{width} #{arquivo}")
  end
end
