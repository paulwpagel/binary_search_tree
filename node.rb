class Node
  attr_accessor :left, :right, :value, :parent
  
  def initialize(value=nil, parent=nil)
    @value = value
    @parent = parent
  end
end