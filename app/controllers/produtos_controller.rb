class ProdutosController < InheritedResources::Base

  def update
    update! do |success, failure|
      success.html {
        case params[:commit]
        when 'Salvar'
          redirect_to collection_url
        when 'Salvar e Novo'
          redirect_to new_resource_url(:colecao_id => @produto.colecao_id,
                                        :fornecedor_id =>@produto.fornecedor_id,
                                        :linha_id =>@produto.linha_id,
                                        :tipo_id =>@produto.tipo_id)
        end
      }
    end
  end

  def create
    create! do |success, failure|
      success.html {
        case params[:commit]
        when 'Salvar'
          redirect_to collection_url
        when 'Salvar e Novo'
          redirect_to new_resource_url(:colecao_id => @produto.colecao_id,
                                        :fornecedor_id =>@produto.fornecedor_id,
                                        :linha_id =>@produto.linha_id,
                                        :tipo_id =>@produto.tipo_id)
        when 'Salvar e Editar'
          redirect_to edit_resource_url(@produto)
        end
      }
    end
  end

  def new
    @produto = Produto.new
    @produto.colecao_id = params[:colecao_id]
    @produto.fornecedor_id = params[:fornecedor_id]
    @produto.linha_id = params[:linha_id]
    @produto.tipo_id = params[:tipo_id]
  end

  def edit
    @produto = Produto.find params[:id]
    @lucro = @produto.lucro
    @rentab = @produto.rentabilidade
    edit!
  end

  def index

    if params[:search]
      if (params[:search][:colecao_id_equals].blank? && params[:search][:fornecedor_id_equals].blank? && params[:search][:linha_id_equals].blank? && params[:search][:tipo_id_equals].blank?)
        params[:search] = nil
        session[:search] = nil
      else
        session[:search] = params[:search]
      end
    else
      params[:search] = session[:search] if session[:search]
    end

    if params[:search]
      params[:search][:meta_sort]='ref.asc' if params[:search][:meta_sort].blank?
      @search = Produto.search(params[:search])
      @produtos = @search.all
    else
      @search = Produto.search
      @produtos = []
    end

  end

  def lucro
    custo = Produto.currency_to_number(params[:custo])
    valor = Produto.currency_to_number(params[:valor])
    @lucro = Produto.lucro(valor, custo)
    @rentab = Produto.rentabilidade(valor, custo)

    render :partial => 'lucro'

  end

end
