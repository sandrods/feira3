module ClientesHelper
  
  def links_letras
    ret = ''
    ('A'..'Z').each do |letra|
      if params[:letra] == letra
        ret << content_tag(:span, letra, :class=>'current')
      else
        ret << link_to(letra, :letra=>letra)
        ret << "\n"
      end
    end
    ret
  end
  
end
