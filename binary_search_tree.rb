require 'node'

class BinarySearchTree
  attr_reader :root, :left
  attr_accessor :delete_strategy
  
  def initialize(root_value = nil)
    @root = Node.new(root_value)
  end
  
  def add(value, node = @root)
    if value < node.value
      add_node(node, value, :left)
    else
      add_node(node, value, :right)
    end
  end
  
  def delete(value, node = @root)
    if go_left?(value, node)
      delete(value, node.left)
    elsif go_right?(value, node)
      delete(value, node.right)
    else
      remove_matched_node(value, node)
    end
  end
    
  def predecessor(node = @root.left)
    return predecessor(node.right) if !node.right.nil?
    return node    
  end

  def successor(node = @root.right)
    return successor(node.left) if !node.left.nil?
    return node
  end
  
  
  private ######################################
  
  def go_left?(value, node)
    return value < node.value
  end

  def go_right?(value, node)
    return value > node.value
  end
  
  def left_child?(node)
    return true if node.parent.left && node.parent.left.value == node.value
    return false
  end
  
  def nil_out(node)
    if left_child?(node)
      node.parent.left = nil
    else
      node.parent.right = nil
    end
  end
  
  def chosen_leaf(node)
    @delete_strategy = [:predecessor, :successor].choice
    if @delete_strategy == :predecessor
      return predecessor(node.left)
    else
      return successor(node.right)
    end
    
  end
  
  def remove_matched_node(vale, node)
    if node.left && node.right
      replacement_node = chosen_leaf(node)
      node.value = replacement_node.value
      nil_out(replacement_node)
    elsif node.left
      node.parent.left = node.left
    elsif node.right
      node.parent.right = node.right
    else
      nil_out(node)
    end
  end
  
  def add_node(node, value, edge)
    if node.send(edge) == nil
      node.send("#{edge}=".to_sym, Node.new(value, node))
    else
      add(value, node.send(edge))
    end  
  end
  
  
end