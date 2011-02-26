class Cor < ActiveRecord::Base
  default_scope :order=>'nome'

  def Cor.to_select
    @@combo ||= Cor.update_select
  end
  
  def Cor.update_select
    @@combo = Cor.all.map {|c| [c.nome, c.id]}
  end

end
