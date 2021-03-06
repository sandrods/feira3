class ItensController < InheritedResources::Base

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

  def index

    if params[:search]
      if (params[:search][:produto_fornecedor_id_equals].blank? &&
          params[:search][:produto_colecao_id_equals].blank? &&
          params[:search][:produto_linha_id_equals].blank? &&
          params[:search][:produto_tipo_id_equals].blank?)

        params[:search] = nil
        session[:search_itens] = nil
      else
        session[:search_itens] = params[:search]
      end
    else
      params[:search] = session[:search_itens] if session[:search_itens]
    end

    if params[:search]
      params[:search][:meta_sort]='produto_ref.asc' if params[:search][:meta_sort].blank?
      @search = Item.search(params[:search])
      @itens = @search.all(:include => [:produto, :cor, :tamanho])

      @total = @itens.sum{ |i| i.estoque }
      @valor = @itens.sum{ |i| i.valor_estoque }

    else
      @search = Item.search
      @itens = []
    end

  end

  protected
    def collection
      @itens ||= end_of_association_chain.all(:include => [:produto, :tamanho, :cor], :order => 'produtos.ref')
    end

end
