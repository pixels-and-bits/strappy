@dir = File.dirname(__FILE__)

def clean_app
  system 'rm -rf ./generated_app'
end

def run_test
  clean = system "cd generated_app && rake db:migrate && rake"
  exit $? unless clean
end

def generate_and_test_app(args)
  clean_app
  system "export LOCAL=#{@dir}; echo \"#{args}\" | rails -m #{@dir}/base.rb generated_app"
  run_test
end

def test_default
  generate_and_test_app("4\n")
end

def test_authlogic
  generate_and_test_app("1\n")
end

def test_clearance_sha_hashing
  generate_and_test_app("2\n1\n")
end

def test_clearance_sha512_hashing
  generate_and_test_app("2\n2\n")
end

def test_clearance_bcrypt_hashing
  generate_and_test_app("2\n3\n")
end

def test_restful_authentication
  generate_and_test_app("3\n")
end

task :default do
  test_default
  test_authlogic
  test_clearance_sha_hashing
  test_clearance_sha512_hashing
  test_clearance_bcrypt_hashing
  test_restful_authentication
end