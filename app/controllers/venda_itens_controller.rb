class VendaItensController < InheritedResources::Base
  defaults :collection_name => 'itens', :instance_name => 'item'
  belongs_to :venda

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def create
    render(:text=>'') and return if params[:barcode].blank?

    @venda = Venda.find(params[:venda_id])
    @item = VendaItem.from_barcode(params[:barcode], @venda.id)
    @venda.reload

  rescue ItemException => e
    @err_msg = e.message
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to venda_itens_url(@venda) }
    end
  end

end
