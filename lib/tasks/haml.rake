namespace :haml do
  rule "" do |t|
    if /from:(.*)$/.match(t.name)
      format = t.name.split(":").last
      Dir["app/views/**/*.#{format}"].each do |file|
        puts "converting #{file}"
        system "html2haml -rx #{file} #{file.gsub(/\.#{format}$/, '.haml')}"
      end
    end
  end
end
