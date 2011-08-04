class RegistrosController < ApplicationController

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
    @registro = Registro.find params[:id]
    render :layout => nil
  end

  def new
    @registro = Registro.new
    render :layout => nil
  end

  def update

    @registro = Registro.find params[:id]

    @old_conta = @registro.conta_id

    @ok = @registro.update_attributes(params[:registro])

  end

  def create
    @registro = Registro.new(params[:registro])
    @ok = @registro.save
  end

  def destroy
    @registro = Registro.find params[:id]
    @ok = @registro.destroy
    render :action => :create
  end

end