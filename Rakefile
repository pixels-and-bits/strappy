@dir = File.dirname(__FILE__)

def clean_app
  system 'rm -rf ./generated_app'
end

def run_test
  clean = system "cd generated_app && rake db:migrate && rake"
  exit $? unless clean
end

def test_default
  clean_app
  system "export SOURCE=#{@dir}; rails -m #{@dir}/base.rb generated_app"
  run_test
end

task :default do
  test_default
end