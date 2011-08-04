# coding: utf-8

class SacolaItem < ActiveRecord::Base

  belongs_to :sacola
  belongs_to :item

  def self.from_barcode(bc, sacola_id)

    item = Item.from_barcode(bc, false)

    sacola = Sacola.find(sacola_id)

    return sacola.itens.create(:item_id => item.id, :status => 'I')

  end

  def self.devolve(bc, sacola_id)

    item = Item.from_barcode(bc, false)

    sacola = Sacola.find(sacola_id)

    sacola_item = sacola.itens.find_by_item_id_and_status(item.id, 'I')

    if sacola_item.nil?
      sacola_item = sacola.itens.find_by_item_id_and_status(item.id, 'D')
      if sacola_item.nil?
        raise ItemException.new("Esta peça NÃO pertence a esta Sacola")
      else
        raise ItemException.new("Esta peça já foi devolvida")
      end
    end

    sacola_item.status = 'D'
    sacola_item.save!

    return sacola_item
  end

end
