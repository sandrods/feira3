# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def render_partial_js(partial, options = {}, locals = {}, &block)
    options[:partial] = partial
    escape_javascript(render(options, locals, &block))
  end

  def cool_button(text, link_opts={}, opts={})
    icon = opts.delete(:icon)||'add'
    ultimo = opts.delete(:ultimo)

    opts[:class] = "" unless opts[:class]
    opts[:class] << ' button'

    ic = (icon == '') ? '' : "<b class='icon #{icon}'></b>" 
    ret = link_to("<span>#{ic}#{text}</span>".html_safe, link_opts, opts)
    ret << "<br style='clear:both' />" if ultimo
    ret
  end

  def cool_button_to_function(text, function, opts={})
    icon = opts.delete(:icon)||'add'
    ultimo = opts.delete(:ultimo)

    opts[:class] = "" unless opts[:class]
    opts[:class] << ' button'

    ic = (icon == '') ? '' : "<b class='icon #{icon}'></b>" 
    ret = link_to_function("<span>#{ic}#{text}</span>".html_safe, function, opts)
    ret << "<br style='clear:both' />" if ultimo
    ret
  end

  def cool_button_remote(text, link_opts={}, opts={})
    icon = opts.delete(:icon)||'add'
    no_br = opts.delete(:no_br)

    options = {:url=>link_opts}
    confirm = opts.delete(:confirm)
    options[:confirm] = confirm if confirm
    
    if opts[:redbox]
      ret = link_to_remote_redbox("<span><b class='icon #{icon}'></b>#{text}</span>".html_safe, options, {:class=>'button'})
    else
      ret = link_to_remote("<span><b class='icon #{icon}'></b>#{text}</span>".html_safe, options, {:class=>'button'})
    end
    
    ret << "<br style='clear:both' />" unless no_br
    ret
  end

  def error_message_on(model, field)
    return unless model.present?

    content_tag(:span, :class=>"errorMessage") do
      model.errors[field].join("<br/>")
    end.html_safe
  end

  def restripe(table_id)
    <<-EOF
        
        var table = $('#{table_id}');
        if (table) {
          var trs = table.getElementsByTagName('tr');
          for (var i = 0; i < trs.length; i++) {
            // remove existing classnames first
            Element.removeClassName(trs[i], 'even');
            Element.removeClassName(trs[i], 'odd');
            clsname = (i % 2 == 0) ? 'even' : 'odd'
            Element.addClassName(trs[i], clsname); 
          }      
        }
          
    EOF
    
  end
  
  def rebuild_sortable(table_id, url)
    <<-EOF
      Sortable.create('#{table_id}', {handle:'handle', onUpdate:function(){new Ajax.Request('#{url}', {asynchronous:true, evalScripts:true, onLoading:function(request){restripe('#{table_id}')}, parameters:Sortable.serialize("#{table_id}")})}, tag:'tr'})
    EOF
    
  end
  
  def flash_message(tipo)
    content_tag("div", flash[tipo], :class=>"#{tipo.to_s}")
  end

  def nl2br(s)
    if s
      s.gsub(/\n/, '<br>')
    else
      ''
    end
  end

  def test_label(form, id, field_name, text, options = {})
    label = form.label(field_name, text, options)

    if label =~ /for="([^"]*)"/
      label.gsub!($1, "#{$1}_#{id}")
    end

    label
  end
  
  def errors_for(model)
    ret = ""
    model.errors.each_full do |error|
      ret << "<p>#{error}</p>"
    end
    ret = "<div class='error'>#{ret}</div>" unless ret.blank?
    ret
  end
  
end
