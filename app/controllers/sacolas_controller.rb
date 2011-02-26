class SacolasController < InheritedResources::Base

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def create
    create! do |success, failure|
      success.html {
        if params[:commit] == 'Salvar'
          redirect_to sacola_itens_url(@sacola)
        else
          redirect_to new_resource_url
        end
      }
    end
  end

end
