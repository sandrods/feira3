module FormHelper

  def date_field_tag(name, value, options={})
    options[:size] = 12 unless options[:size]
    out = text_field_tag(name, value, options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{name}").mask("99/99/9999");
      });
      </script>
    JS
    out << js.html_safe
    out
  end

  def date_field(object, method, options={})
    options[:size] = 12 unless options[:size]
    out = text_field(object, "#{method}_to_form", options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{object}_#{method}_to_form").mask("99/99/9999");
      });
      </script>
    JS
    out << js.html_safe
    out
  end

  def date_label(object, method, text=nil, options={})
    label(object, "#{method}_to_form", text, options)
  end

  def masked_text_field(object, method, options={})
    mask = options.delete(:mask)
    out = text_field(object, method, options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{object}_#{method}").mask("#{mask}");
      });
      </script>
    JS
    out << js.html_safe
    out
  end

  def masked_field_tag(name, value, options={})
    options[:size] = 12 unless options[:size]
    mask = options.delete(:mask)
    out = text_field_tag(name, value, options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{name}").mask("#{mask}");
      });
      </script>
    JS
    out << js.html_safe
    out
  end

  def currency_field(object, method, options={})
    options[:size] = 12 unless options[:size]

    out = text_field(object, "#{method}_to_form", options)

    prefix = options.delete(:prefix)
    js_opts = "{prefix: '#{prefix}'}" if prefix

    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
         $("##{object}_#{method}_to_form").priceFormat(#{js_opts});
      </script>
    JS
    out << js.html_safe
    out
  end

  def float_field(object, method, options={})
    options[:prefix] = ''
    currency_field(object, method, options)
  end

end

module ActionView
  module Helpers
    class FormBuilder
      def date_field(method, options = {})
        @template.date_field(@object_name, method, options.merge(:object => @object))
      end
      def date_label(method, text=nil, options = {})
        @template.date_label(@object_name, method, text, options)
      end
      def masked_text_field(method, options = {})
        @template.masked_text_field(@object_name, method, options.merge(:object => @object))
      end
      def currency_field(method, options = {})
        @template.currency_field(@object_name, method, options.merge(:object => @object))
      end
      def float_field(method, options = {})
        @template.float_field(@object_name, method, options.merge(:object => @object))
      end
    end
  end
end