class SacolaItensController < InheritedResources::Base
  defaults :collection_name => 'itens', :instance_name => 'item'

  belongs_to :sacola

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def create
    render(:text=>'') and return if params[:barcode].blank?

    @sacola = Sacola.find(params[:sacola_id])
    @item = SacolaItem.from_barcode(params[:barcode], @sacola.id)
    @sacola.reload

  rescue ItemException => e
    @err_msg = e.message
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to sacola_itens_url(@sacola) }
    end
  end
  
  def devolve
    render(:text=>'') and return if params[:barcode1].blank?

    @sacola = Sacola.find(params[:sacola_id])
    @item = SacolaItem.devolve(params[:barcode1], @sacola.id)
    @sacola.reload

  rescue ItemException => e
    @err_msg = e.message

  end

end
