# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110322011354) do

  create_table "clientes", :force => true do |t|
    t.string   "nome",       :limit => 60
    t.string   "email",      :limit => 40
    t.string   "fone_res",   :limit => 20
    t.string   "fone_com",   :limit => 20
    t.string   "fone_cel",   :limit => 20
    t.string   "endereco",   :limit => 60
    t.string   "bairro",     :limit => 30
    t.string   "cep",        :limit => 10
    t.string   "cidade",     :limit => 60
    t.string   "uf",         :limit => 2
    t.string   "obs",        :limit => 100
    t.integer  "aniver_dia"
    t.integer  "aniver_mes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colecoes", :force => true do |t|
    t.string   "descricao",  :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compra_itens", :force => true do |t|
    t.integer  "compra_id"
    t.integer  "item_id",                 :null => false
    t.float    "valor"
    t.string   "tipo",       :limit => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "compra_itens", ["compra_id"], :name => "index_compra_itens_on_compra_id"
  add_index "compra_itens", ["item_id"], :name => "index_compra_itens_on_item_id"

  create_table "compras", :force => true do |t|
    t.integer  "fornecedor_id",                               :null => false
    t.date     "data"
    t.decimal  "valor",         :precision => 9, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "desconto",      :precision => 9, :scale => 2
  end

  create_table "contas", :force => true do |t|
    t.string   "nome",       :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cores", :force => true do |t|
    t.string   "nome",       :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etiquetas", :force => true do |t|
    t.integer "produto_id"
    t.integer "tamanho_id"
    t.integer "cor_id"
  end

  create_table "fornecedores", :force => true do |t|
    t.string   "nome",       :limit => 30,                    :null => false
    t.string   "email",      :limit => 60
    t.string   "website",    :limit => 60
    t.string   "fone",       :limit => 30
    t.string   "cnpj",       :limit => 20
    t.string   "endereco",   :limit => 80
    t.string   "bairro",     :limit => 30
    t.string   "cep",        :limit => 8
    t.string   "cidade",     :limit => 30
    t.string   "uf",         :limit => 2
    t.string   "obs",        :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ativo",                     :default => true
  end

  create_table "itens", :force => true do |t|
    t.integer  "produto_id", :null => false
    t.integer  "tamanho_id", :null => false
    t.integer  "cor_id",     :null => false
    t.integer  "estoque"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "itens", ["cor_id"], :name => "index_itens_on_cor_id"
  add_index "itens", ["produto_id"], :name => "index_itens_on_produto_id"
  add_index "itens", ["tamanho_id"], :name => "index_itens_on_tamanho_id"

  create_table "linhas", :force => true do |t|
    t.string   "descricao",  :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.string  "titulo",     :limit => 30
    t.integer "ordem",      :limit => 2
    t.integer "recurso_id", :limit => 9
    t.integer "parent_id",  :limit => 11
    t.string  "controller", :limit => 50
    t.string  "action",     :limit => 30
  end

  add_index "menus", ["parent_id"], :name => "menus_parent_fk_i"

  create_table "produtos", :force => true do |t|
    t.string   "ref",           :limit => 30
    t.integer  "colecao_id",                                                                  :null => false
    t.integer  "tipo_id",                                                                     :null => false
    t.integer  "linha_id",                                                                    :null => false
    t.integer  "fornecedor_id",                                                               :null => false
    t.decimal  "custo",                       :precision => 9, :scale => 2,                   :null => false
    t.decimal  "valor",                       :precision => 9, :scale => 2,                   :null => false
    t.boolean  "ativo",                                                     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lucro",                       :precision => 9, :scale => 2
    t.decimal  "rentabilidade",               :precision => 9, :scale => 2
  end

  add_index "produtos", ["colecao_id"], :name => "index_produtos_on_colecao_id"
  add_index "produtos", ["fornecedor_id"], :name => "index_produtos_on_fornecedor_id"
  add_index "produtos", ["linha_id"], :name => "index_produtos_on_linha_id"
  add_index "produtos", ["tipo_id"], :name => "index_produtos_on_tipo_id"

  create_table "registros", :force => true do |t|
    t.date     "data"
    t.string   "descricao",        :limit => 60
    t.decimal  "valor",                          :precision => 2, :scale => 5, :null => false
    t.string   "cd",               :limit => 1
    t.integer  "conta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "registravel_id",   :limit => 9
    t.string   "registravel_type", :limit => 20
  end

  create_table "sacola_itens", :force => true do |t|
    t.integer  "sacola_id",               :null => false
    t.integer  "item_id",                 :null => false
    t.string   "status",     :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sacolas", :force => true do |t|
    t.integer  "vendedor_id",              :null => false
    t.string   "status",      :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tamanhos", :force => true do |t|
    t.string   "nome",       :limit => 10, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos", :force => true do |t|
    t.string   "descricao",  :limit => 32, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venda_itens", :force => true do |t|
    t.integer  "venda_id",   :null => false
    t.integer  "item_id",    :null => false
    t.float    "bruto"
    t.float    "desconto"
    t.float    "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venda_itens", ["item_id"], :name => "index_venda_itens_on_item_id"
  add_index "venda_itens", ["venda_id"], :name => "index_venda_itens_on_venda_id"

  create_table "vendas", :force => true do |t|
    t.integer  "cliente_id"
    t.integer  "vendedor_id"
    t.date     "data"
    t.string   "tipo",        :limit => 1
    t.float    "valor"
    t.string   "obs",         :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "desconto",                   :precision => 9, :scale => 2
  end

  add_index "vendas", ["cliente_id"], :name => "index_vendas_on_cliente_id"
  add_index "vendas", ["vendedor_id"], :name => "index_vendas_on_vendedor_id"

  create_table "vendedores", :force => true do |t|
    t.string   "nome",       :limit => 50, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
