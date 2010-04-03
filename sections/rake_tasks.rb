# install strappy rake tasks
rakefile 'strappy.rake', open("#{ENV['SOURCE']}/lib/tasks/strappy.rake").read

# install seed_fu rake tasks
rakefile 'seed_fu.rake', open("#{ENV['SOURCE']}/lib/tasks/seed_fu.rake").read

# install rcov rake tasks
rakefile 'rcov.rake', open("#{ENV['SOURCE']}/lib/tasks/rcov.rake").read
