class Category
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  
  field :name, :type => String
  index :name, :unique => true
  
  def to_jstree
    {
      :data => name,
      :attr => {:id => id, :position => position},
      :children => children.map{|c| c.to_jstree }
    }
  end
end
