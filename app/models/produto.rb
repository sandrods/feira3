class Produto < ActiveRecord::Base

  belongs_to :linha
  belongs_to :tipo
  belongs_to :colecao
  belongs_to :fornecedor

  has_many :itens
  has_many :etiquetas

  validates :colecao_id, :linha_id, :fornecedor_id, :tipo_id, :ref, :valor, :presence => true

  acts_as_br_currency :custo, :valor

  def Produto.rentabilidade(_valor, _custo)
    return 0 if _custo == 0
    ((_valor/_custo) - 1) * 100 rescue nil
  end

  def Produto.lucro(valor1, custo1)
    valor1-custo1 rescue nil
  end

  before_save do
    self.lucro = Produto.lucro(self.valor, self.custo)
    self.rentabilidade = Produto.rentabilidade(self.valor, self.custo)
  end

end