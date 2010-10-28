@dir = File.dirname(__FILE__)
puts @dir
task :default do
  system 'rm -rf ./generated_app'
  system "export SOURCE=\"#{@dir}\"; rails new generated_app -m \"#{@dir}/base.rb\""
  # clean = system "cd generated_app && rake db:migrate && rake && rake cucumber"
  # exit $? unless clean
end
