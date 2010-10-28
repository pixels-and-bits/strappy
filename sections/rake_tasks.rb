# install strappy rake tasks
rakefile 'rcov.rake', open("#{ENV['SOURCE']}/lib/tasks/rcov.rake").read
rakefile 'strappy.rake', open("#{ENV['SOURCE']}/lib/tasks/strappy.rake").read
