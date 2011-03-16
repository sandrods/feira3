module RegistrosHelper

  def div_day(day)
    if day == Date.today
      cls = 'today'
    else
      cls = @cal.this_month?(day) ? '' : 'inactive'
    end
    "<div class='day #{cls}'>#{day.day}</div>".html_safe
  end

  def valor_diario(day, val)
    txt = number_to_currency(val || 0)
    if val
      link_to(txt, "#")
    else
      txt
    end
  end

end
