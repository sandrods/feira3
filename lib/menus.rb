require 'rubygems'
require 'yaml'
require 'tree'



class Menus

  attr_accessor :nodos

  def initialize(yaml)
    @counter = 0
    menus = YAML.load_file(yaml)
    @nodos = Tree::TreeNode.new("ROOT", "")
    add_subs_to_node(@nodos, build(menus))
  end
  
  def build(menus)
    ret = []
    menus.each do |nodo|
      subs = nodo.delete('subs')
      tree_node = Tree::TreeNode.new(@counter += 1, nodo)
      add_subs_to_node(tree_node, build(subs)) if subs
      ret << tree_node
    end
    ret
  end

  private
  
  def add_subs_to_node(node, subs)
    subs.each do |sub|
      node << sub
    end
  end

end

Menus.new("../config/menus.yml").nodos.print_tree

