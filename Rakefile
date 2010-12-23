@dir = File.dirname(__FILE__)

app_name = 'generated_app'

task :default do
  system "rm -rf ./#{app_name}"
  system "export SOURCE=\"#{@dir}\"; rails new #{app_name} -m \"#{@dir}/base.rb\""
  # clean = system "cd generated_app && rake db:migrate && rake && rake cucumber"
  # exit $? unless clean
end
