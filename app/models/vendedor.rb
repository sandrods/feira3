class Vendedor < ActiveRecord::Base
  default_scope :order=>'nome'

  validates_length_of :nome, :maximum => 50

  def Vendedor.to_select
    Vendedor.all.map {|c| [c.nome, c.id]}
  end

end
