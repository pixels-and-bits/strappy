namespace :strappy do
  PLUGIN_LIST = {
    :acts_as_category => 'git://github.com/funkensturm/acts_as_category.git',
    :acts_as_configurable => 'git://github.com/omghax/acts_as_configurable.git',
    :acts_as_list => 'git://github.com/rails/acts_as_list.git',
    :acts_as_rated => 'git://github.com/jasherai/acts-as-rated.git',
    :acts_as_solr => 'git://github.com/railsfreaks/acts_as_solr.git',
    :acts_as_taggable_on_steroids => 'git://github.com/jviney/acts_as_taggable_on_steroids.git',
    :acts_as_textiled => 'git://github.com/defunkt/acts_as_textiled.git',
    :acts_as_tree => 'git://github.com/rails/acts_as_tree.git',
    :textile_editor_helper => 'git://github.com/felttippin/textile-editor-helper.git',
    :will_paginate_acts_as_solr => 'git://github.com/jgp/will_paginate_acts_as_solr.git'
  }

  desc 'List all plugins available to quick install'
  task :install do
    puts "\nAvailable Plugins\n#{'=' * 80}\n\n"
    plugins = PLUGIN_LIST.keys.sort_by { |k| k.to_s }.map { |key| [key, PLUGIN_LIST[key]] }

    plugins.each do |plugin|
      puts "#{plugin.first.to_s.gsub('_', ' ').capitalize.ljust(30)} rake strappy:install:#{plugin.first.to_s}\n"
    end
    puts "\n"
  end

  namespace :install do
    PLUGIN_LIST.each_pair do |key, value|
      task key do
        system('script/plugin', 'install', value, '--force')
      end
    end
  end
end
