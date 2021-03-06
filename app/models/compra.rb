class Compra < ActiveRecord::Base

  belongs_to :fornecedor
  has_many :itens, :class_name => 'CompraItem', :dependent => :destroy do
    def desc
      order('id desc')
    end
  end

  has_many :pagamentos, :class_name => "Registro", :as => :registravel, :conditions => { :cd => "D" }, :order => 'data asc'

  acts_as_br_date :data
  acts_as_br_float :desconto

  def total
    itens.sum(:valor)
  end

end
