class RegistrosController < InheritedResources::Base
  
  def index
    @creditos = Registro.creditos
    @debitos = Registro.debitos
  end

end
