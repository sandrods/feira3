class Sacola < ActiveRecord::Base

  has_many :itens, :class_name => "SacolaItem", :dependent => :destroy do
    def incluidos
      find_all_by_status('I')
    end
    def devolvidos
      find_all_by_status('D')
    end
  end

  belongs_to :vendedor

  def total
    itens.incluidos.sum { |i| i.item.try(:produto).try(:valor) }
  end

end
