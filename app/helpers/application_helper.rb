module ApplicationHelper

  # dirty ugly hack to get rcov to see this
  def html_attrs(lang = 'en-US'); {:xmlns => "http://www.w3.org/1999/xhtml", 'xml:lang' => lang, :lang => lang}
  end

  def http_equiv_attrs
    {'http-equiv' => 'Content-Type', :content => 'text/html;charset=UTF-8'}
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end

  def blackbird_tags
    if SiteConfig.blackbird || true == session[:blackbird]
      '<script type="text/javascript" charset="utf-8" src="/blackbird/blackbird.js"></script>
<link href="/blackbird/blackbird.css" media="screen" rel="stylesheet" type="text/css" />'
    else
      no_blackbird
    end rescue no_blackbird
  end

  def no_blackbird
    '<script type="text/javascript" charset="utf-8">var log = {toggle: function() {}, move: function() {}, resize: function() {}, clear: function() {}, debug: function() {}, info: function() {}, warn: function() {}, error: function() {}, profile: function() {} };</script>'
  end

  def delete_img(obj, path)
    link_to_remote(image_tag('delete.png',
        :title => "Delete this #{obj.class}",
        :class => 'action'
      ), {
        :url => path,
        :method => :delete,
        :confirm => "This happens immediately.\nAre you sure you want to delete it?"
      }
    ) unless obj.id.blank?
  end

  def edit_img(obj, path)
    link_to(image_tag('pencil.png',
        :title => "Edit this #{obj.class}",
        :class => 'action'
      ),
      path
    ) unless obj.id.blank?
  end

  def drag_img
    image_tag 'arrow_up_down.png', :class => 'action drag', :title => 'Drag to reorder'
  end

  def sortable(parent, handle='', axis='y', containment='')
    <<-EOC
      $('#{parent} ul').sortable({
        axis: '#{axis}',
        containment: '#{containment}',
        handle: '#{handle}',
        stop: function() { PNB.updateSortables('#{parent}') }
      })
    EOC
  end

  def remote_javascript_includes
    if 'production' == RAILS_ENV
      javascript_include_tag(
        'http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js',
        'http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/jquery-ui.min.js'
      )
    else
      javascript_include_tag(
        'jquery.js',
        'jquery-ui.js'
      )
    end
  end

  def local_javascript_includes
    if 'production' == RAILS_ENV
      javascript_include_tag(
        'jquery.rater.js',
        'jrails',
        'application'
      )
    else
      javascript_include_tag(
        'jquery.rater.js',
        'jrails',
        'application'
      )
    end
  end
end
