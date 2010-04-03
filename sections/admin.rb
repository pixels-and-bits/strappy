# setup admin section
%w(
  app/controllers/admin
  app/views/admin/base
  spec/controllers/admin
  app/helpers/admin
).each do |dir|
  run "mkdir -p #{dir}"
end

git :add => "."
git :commit => "-am 'Added admin stubs'"
