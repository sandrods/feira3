class VendaPagamentosController < ApplicationController
  layout nil
  before_filter :load_venda

  def new
    @pagamento = @venda.pagamentos.new
    @pagamento.data = Date.today
  end

  def create
    @pagamento = @venda.pagamentos.build(params[:pagamento])
    @pagamento.descricao = "Venda #{@venda.id} - #{@venda.cliente.try(:nome)}"
    @pagamento.save
  end

  def edit
    @pagamento = @venda.pagamentos.find(params[:id])
  end


  def destroy
    @venda.pagamentos.find(params[:id]).destroy
  end

  def update
    @pagamento = @venda.pagamentos.find(params[:id])
    @pagamento.update_attributes(params[:pagamento])
    render :action=> :create
  end

 private

  def load_venda
    @venda = Venda.find(params[:venda_id])
  end

end

