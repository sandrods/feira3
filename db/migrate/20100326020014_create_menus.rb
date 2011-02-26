class CreateMenus < ActiveRecord::Migration
  def self.up

		create_table "menus", :force => true do |t|
		  t.string  "titulo",     :limit => 30
		  t.integer "ordem",      :limit => 2,   :precision => 2,  :scale => 0
		  t.integer "recurso_id", :limit => 9,   :precision => 9,  :scale => 0
		  t.integer "parent_id",  :limit => 11,  :precision => 11, :scale => 0
		  t.string  "controller", :limit => 50
		  t.string  "action",     :limit => 30
		end

		add_index "menus", ["parent_id"], :name => "menus_parent_fk_i"

		Menu.create(:titulo=>'Menus', :ordem=>1, :parent_id=>nil)
	
	end

  def self.down
    drop_table :registros
  end
end
