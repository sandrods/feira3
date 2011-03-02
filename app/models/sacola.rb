class Sacola < ActiveRecord::Base

  has_many :itens, :class_name => "SacolaItem", :dependent => :destroy do
    def incluidos
      where(:status=>'I')
    end
    def devolvidos
      where(:status=>'D')
    end
  end

  belongs_to :vendedor

  def total
    itens.incluidos.sum { |i| i.item.try(:produto).try(:valor) }
  end

end
