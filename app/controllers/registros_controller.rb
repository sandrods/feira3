class RegistrosController < InheritedResources::Base

  def index
  end

  def mensal
    @cal = Calendar.new(params[:mes])

    do_mes = Registro.where(:data=>@cal.range)
    @creditos = do_mes.creditos.group(:data).sum(:valor)
    @debitos = do_mes.debitos.group(:data).sum(:valor)
  end
  
  def transfere
    @reg = Registro.find params[:id]

    @old_conta = @reg.conta_id
    @old_collection = Registro.da_conta(@old_conta)

    @new_conta = params[:conta_id]
    @new_collection = Registro.da_conta(@new_conta)

    @reg.conta_id = @new_conta
    @reg.save!
  end

  def edit
    edit! do |success, failure|
      success.html { render :layout => nil  }
    end
  end

  def update
    update! do |success, failure|
      success.js { render :action => "update" }
    end
  end

end