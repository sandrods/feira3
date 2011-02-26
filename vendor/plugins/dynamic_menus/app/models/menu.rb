class Menu < ActiveRecord::Base

  acts_as_tree :order => "ordem"
  acts_as_list :column=>'ordem', :scope=>:parent

  validates_length_of(:controller, :maximum => 50, :allow_nil=>true)
  validates_length_of(:action, :maximum => 30, :allow_nil=>true)
  validates_length_of(:titulo, :maximum => 30, :allow_nil=>true)

  #has_many :filhos, :class_name => 'Menu', :foreign_key => 'parent_id', :order => 'ordem', :include=>'recurso'
  has_many :filhos, :class_name => 'Menu', :foreign_key => 'parent_id', :order => 'ordem'

  def self.set_ordem(nodo, ordem)
    connection.execute "update menus set ordem=#{ordem} where id=#{nodo} "
  end

  def aba?
    @aba = self.parent && self.parent.parent_id==nil unless @aba
    @aba
  end
  
  def ramo
    sql = "select m.*, level from menus m start with id = ? connect by prior id = parent_id"
    Menu.find_by_sql([sql, self.id])
  end

end
