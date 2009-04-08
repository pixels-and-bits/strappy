@dir = File.dirname(__FILE__)

task :default do
  system 'rm -rf ./generated_app'
  system "export SOURCE=#{@dir}; rails -m #{@dir}/base.rb generated_app"
  clean = system "cd generated_app && rake db:migrate && rake"
  exit $? unless clean
end
