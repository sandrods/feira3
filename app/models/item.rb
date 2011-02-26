class ItemException < Exception
end

class Item < ActiveRecord::Base

  belongs_to :produto
  belongs_to :cor
  belongs_to :tamanho

  has_many :compra_itens

  def barcode
    "#{cor_id.to_s.rjust(2, '0')}#{tamanho_id.to_s.rjust(2, '0')}#{produto_id.to_s.rjust(6, '0')}"
  end

  def Item.from_barcode(bc, create = true)

    raise ItemException.new("Código de Barras Inválido: #{bc}") unless bc =~ /(\d{2})(\d{2})(\d{6})/

    cor_id, tam_id, ref = $1, $2, $3

    produto = Produto.find(ref.to_i) rescue nil
    cor     = Cor.find(cor_id.to_i) rescue nil
    tam     = Tamanho.find(tam_id.to_i) rescue nil

    raise ItemException.new("Produto Inválido: #{ref}") unless produto
    raise ItemException.new("Cor Inválida: #{cor_id}") unless cor
    raise ItemException.new("Tamanho Inválido: #{tam_id}") unless tam

    item = Item.find :first, :conditions => {:cor_id => cor.id, :tamanho_id => tam.id, :produto_id => produto.id }
    unless item
      if create
        item = Item.create(:cor_id=>cor.id, :tamanho_id => tam.id, :produto_id => produto.id, :estoque => 0)
      else
        raise ItemException.new("Item não Cadastrado: #{bc}")
      end
    end

    return item

  end

  def atualiza_estoque!
    e = compra_itens.count
    # e -= venda_itens.count

    update_attribute(:estoque, e)
  end

  def self.atualiza_estoques!
    t1 = Time.now
    all.each { |i| i.atualiza_estoque! }
    puts Time.now - t1
  end

  def valor_estoque
    estoque * produto.valor
  end

end
