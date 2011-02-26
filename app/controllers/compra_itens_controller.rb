class CompraItensController < InheritedResources::Base
  defaults :collection_name => 'itens', :instance_name => 'item'
  belongs_to :compra

  def index
    @compra = Compra.find(params[:compra_id])
    @itens = @compra.itens.desc
  end

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def create
    render(:text=>'') and return if params[:barcode].blank?

    @compra = Compra.find(params[:compra_id])
    @item = CompraItem.from_barcode(params[:barcode], @compra.id)
    @compra.reload

  rescue ItemException => e
    @err_msg = e.message
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to compra_itens_url(@compra) }
    end
  end

end
