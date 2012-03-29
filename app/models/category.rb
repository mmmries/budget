class Category
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  
  field :name, :type => String
  index :name, :unique => true
  
  before_destroy :destroy_children
  
  def to_jstree
    {
      :data => name,
      :attr => {:id => id, :position => position},
      :children => children.map{|c| c.to_jstree }
    }
  end
  
  def move_to(pos, parent)
    siblings = Category.roots if parent.nil?
    siblings ||= parent.children
    targets = siblings.select do |s| s.position == pos end
    if targets.size > 0 then
      move_above(targets.first)
    else
      self.parent = parent
      self.position = pos
    end
  end
end
