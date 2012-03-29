class CategoryController < ApplicationController
  def index
    
  end
  
  def tree
    render :json => Category.roots.map{|r| r.to_jstree }
  end
  
  def reorder
    to_move = Category.find( params[:id] )
    if params[:parent].empty?
      parent = nil
    else
      parent = Category.find( params[:parent])
    end
    to_move.move_to(params[:position], parent)
    to_move.save
    render :json => true
  end
end
