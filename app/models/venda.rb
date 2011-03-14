class Venda < ActiveRecord::Base

  belongs_to :cliente
  belongs_to :vendedor

  has_many :itens, :class_name => "VendaItem", :dependent => :destroy do
    def desc
      order('id desc')
    end
  end
  
  has_many :pagamentos, :class_name => "Registro", :as => :registravel, :conditions => { :cd => "C" }, :order => 'data asc'

  validates_presence_of :cliente_id, :if => lambda { |v| v.vendedor_id.blank? }
  validates_presence_of :vendedor_id, :if => lambda { |v| v.cliente_id.blank? }

  acts_as_br_date :data
  acts_as_br_float :desconto

  scope :clientes,      where(:tipo => "C" )
  scope :comissionadas, where(:tipo => "V" )

  def cliente?
    tipo == 'C'
  end

  def copia_da_sacola!(sacola_id)
    sacola = Sacola.find(sacola_id)
    sacola.itens.incluidos.each { |item| adiciona_item!(item) }
  end

  def adiciona_item!(item)

    liquido = (desconto && desconto > 0) ? item.produto.valor * (1-(desconto/100)) : item.produto.valor

    return itens.create!(:item_id => item.id, :bruto => item.produto.valor, :desconto=> (desconto || 0), :valor => liquido)

  end

  def nome
    cliente? ? cliente.nome : vendedor.nome
  end

  def total
    itens.sum(:valor)
  end

end