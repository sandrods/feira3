class Tamanho < ActiveRecord::Base

  def Tamanho.to_select
    @@combo ||= Tamanho.update_select
  end
  
  def Tamanho.update_select
    @@combo = Tamanho.all.map {|c| [c.nome, c.id]}
  end

end
