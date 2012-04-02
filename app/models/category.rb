require 'pry'
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
    pos = pos.to_i
    self.parent = parent
    siblings = Category.roots if parent.nil?
    siblings ||= parent.children
    siblings = siblings.select{ |s| s.id != self.id }
    siblings.insert(pos, self)
    siblings.each_with_index do |s, idx|
      puts "#{s.name}.position = #{idx}"
      s.position = idx
      s.save
    end
  end
end
