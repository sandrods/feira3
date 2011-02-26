class Tipo < ActiveRecord::Base
  default_scope :order=>'descricao'

  def Tipo.to_select
    @@combo ||= Tipo.update_select
  end
  
  def Tipo.update_select
    @@combo = Tipo.all.map {|c| [c.descricao, c.id]}
  end

end
