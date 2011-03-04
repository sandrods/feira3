class Fornecedor < ActiveRecord::Base
  default_scope :order=>'nome'
  
  ESTADOS = %w(RS SP AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR SC SE TO)
  
  def Fornecedor.to_select
    @@combo ||= Fornecedor.update_select
  end
  
  def Fornecedor.update_select
    @@combo = Fornecedor.where(:ativo => true).map {|c| [c.nome, c.id]}
  end
end