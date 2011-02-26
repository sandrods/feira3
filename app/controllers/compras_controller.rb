class ComprasController < InheritedResources::Base

  respond_to :html
  respond_to :js, :only => :update

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def new
    @compra = Compra.new(:desconto => 0)
  end

  def create
    create! do |success, failure|
      success.html {
        if params[:commit] == 'Salvar'
          redirect_to collection_url
        else
          redirect_to new_resource_url
        end
      }
    end
  end

end
