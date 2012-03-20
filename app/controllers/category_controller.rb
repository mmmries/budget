class CategoryController < ApplicationController
  def index
    
  end
  
  def tree
    render :json => Category.roots.map{|r| r.to_jstree }
  end
end
