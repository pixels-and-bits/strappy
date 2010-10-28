file_inject('config/application.rb',
  "  end",
  "    config.generators do |g|
          g.template_engine :haml
          g.test_framework :rspec, :fixture => false, :views => false, :view_specs => false
          g.fixture_replacement :machinist
        end",
  :before
)

git :add => "."
git :commit => "-am 'Setup default generators'"
