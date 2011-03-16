class RegistrosController < InheritedResources::Base
  
  def index
    @creditos = Registro.creditos
    @debitos = Registro.debitos
  end
  
  def mensal
    @cal = Calendar.new(params[:mes])

    do_mes = Registro.where(:data=>@cal.range)
    @creditos = do_mes.creditos.group(:data).sum(:valor)
    @debitos = do_mes.debitos.group(:data).sum(:valor)
  end

end
