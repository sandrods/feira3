class CompraPagamentosController < ApplicationController
   layout nil
   before_filter :load_compra

   def new
     @pagamento = @compra.pagamentos.new
     @pagamento.data = Date.today
   end

   def create
     @pagamento = @compra.pagamentos.build(params[:pagamento])
     @pagamento.descricao = "Compra #{@compra.id} - #{@compra.fornecedor.try(:nome)}"
     @pagamento.save
   end

   def edit
     @pagamento = @compra.pagamentos.find(params[:id])
   end


   def destroy
     @compra.pagamentos.find(params[:id]).destroy
   end

   def update
     @pagamento = @compra.pagamentos.find(params[:id])
     @pagamento.update_attributes(params[:pagamento])
     render :action=> :create
   end

  private

   def load_compra
     @compra = Compra.find(params[:compra_id])
   end
end
