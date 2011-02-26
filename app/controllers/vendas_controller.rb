class VendasController < InheritedResources::Base

  respond_to :html
  respond_to :js, :only => :update

  def new
    @venda = Venda.new
    @venda.data = Date.today

    @venda.tipo = params[:tipo]
    @venda.vendedor_id = params[:vendedor_id] if params[:vendedor_id]

  end

  def create
    @venda = Venda.new(params[:venda])
    if @venda.save
      @venda.copia_da_sacola!(params[:sacola_id]) if params[:sacola_id]
      redirect_to venda_itens_url(@venda)
    else
      render :action => :new
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def clientes
    @vendas = Venda.clientes

    @title = "Vendas para Clientes"
    @th = "Cliente"

    render :action => :index
  end

  def comissionadas
    @vendas = Venda.comissionadas

    @title = "Vendas Comissionadas"
    @th = "Vendedora"

    render :action => :index
  end


end
