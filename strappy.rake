namespace :strappy do
  PLUGIN_LIST = {
    :acts_as_taggable_on_steroids => 'http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids',
    :attachment_fu => 'git://github.com/technoweenie/attachment_fu.git',
    :bundle_fu => 'git://github.com/timcharper/bundle-fu.git',
    :fudge_form => 'git://github.com/JimNeath/fudge_form.git',
    :open_id_authentication => 'git://github.com/rails/open_id_authentication.git',
    :paperclip => 'git://github.com/thoughtbot/paperclip.git',
    :salty_slugs => 'git://github.com/norbauer/salty_slugs.git',
    :shoulda => 'git://github.com/thoughtbot/shoulda.git',
    :spawn => 'git://github.com/tra/spawn.git',
    :workling => 'git://github.com/purzelrakete/workling.git',
    :acts_as_configurable => 'git://github.com/omghax/acts_as_configurable.git',
    :acts_as_rated => 'svn://rubyforge.org/var/svn/acts-as-rated/trunk/acts_as_rated',
    :core_extensions => 'git@github.com:UnderpantsGnome/core_extensions.git',
    :acts_as_solr => 'git://github.com/railsfreaks/acts_as_solr.git',
    :solr_pagination => 'git://github.com/dfl/solr_pagination.git'
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
