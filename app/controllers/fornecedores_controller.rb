class FornecedoresController < InheritedResources::Base

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
  
  def ativar
    @fornec = Fornecedor.find(params[:id])
    @fornec.update_attribute(:ativo, params[:ativo]=='true')
    render :nothing=>true
  end

  protected
    def collection
      if params[:show] == 'all'
        @fornecedores ||= end_of_association_chain.all
      else
        @fornecedores ||= end_of_association_chain.find_all_by_ativo(true)
      end
    end

end
