generate 'formtastic:install'

lines = 

file_inject('config/initializers/formtastic.rb',
  '# Set the default text field size when input is a string. Default is 50.',
  "require 'formtastic'
require 'formtastic/layout_helper'
ActionView::Base.send :include, Formtastic::SemanticFormHelper
ActionView::Base.send :include, Formtastic::LayoutHelper

  ",
  :before
)
