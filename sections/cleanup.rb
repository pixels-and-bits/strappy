# get rid of the erb templates
Dir.glob('app/views/**/*.erb').each do |file|
  rm file
end
