class ClientesController < InheritedResources::Base

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
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

  protected
    def collection
      if params[:letra]
        @clientes = Cliente.por_letra(params[:letra])
      else
        @clientes = []
      end
    end

end
