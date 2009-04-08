namespace :strappy do
  PLUGIN_LIST = {
    :acts_as_configurable => 'git://github.com/omghax/acts_as_configurable.git',
    :acts_as_list => 'git://github.com/rails/acts_as_list.git',
    :acts_as_rated => 'svn://rubyforge.org/var/svn/acts-as-rated/trunk/acts_as_rated',
    :acts_as_solr => 'git://github.com/railsfreaks/acts_as_solr.git',
    :acts_as_taggable_on_steroids => 'http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids',
    :acts_as_textiled => 'git://github.com/defunkt/acts_as_textiled.git',
    :acts_as_tree => 'git://github.com/rails/acts_as_tree.git',
    :bundle_fu => 'git://github.com/timcharper/bundle-fu.git',
    :core_extensions => 'git@github.com:UnderpantsGnome/core_extensions.git',
    :open_id_authentication => 'git://github.com/rails/open_id_authentication.git',
    :shoulda => 'git://github.com/thoughtbot/shoulda.git',
    :solr_pagination => 'git://github.com/dfl/solr_pagination.git',
    :spawn => 'git://github.com/tra/spawn.git',
    :textile_editor_helper => 'git://github.com/felttippin/textile-editor-helper.git',
    :upload_column => 'git://github.com/jnicklas/uploadcolumn.git',
    :workling => 'git://github.com/purzelrakete/workling.git',
    :yarpie => 'git://github.com/tchandy/yaripe.git'
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
