class VendaItem < ActiveRecord::Base
  belongs_to :venda
  belongs_to :item

  def VendaItem.from_barcode(bc, venda_id)

    item = Item.from_barcode(bc)

    venda = Venda.find(venda_id)
    
    return venda.adiciona_item!(item)

  end

end
