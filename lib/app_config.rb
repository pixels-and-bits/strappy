require 'config_reader'

class AppConfig < ConfigReader
  self.config_file = './config/app.yml'
end
