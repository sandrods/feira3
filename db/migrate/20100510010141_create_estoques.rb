class CreateEstoques < ActiveRecord::Migration
  def self.up
    create_table :estoques, :force => true do |t|
      t.integer :compra_id
      t.integer :item_id,   :null => false

      t.float   :valor
      t.string  :tipo,      :null => false, :limit => 1
 
      t.timestamps
    end
  end

  def self.down
    drop_table :estoques
  end
end
