# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.tree').jstree
    plugins:
       ["themes","json_data","dnd","contextmenu"]
    themes:
      theme: 'apple'
    json_data:
      ajax:
        url: "/category/tree"
    dnd:
      drop_target: false
      drag_target: false
  .bind('move_node.jstree', move)

move = (ev, data) ->
  data.rslt.o.each (i) ->
    id = $(this).attr('id')
    position = data.rslt.cp
    parent = if data.rslt.cr == -1 then "" else data.rslt.np.attr('id') 
    console.log("reorder id#{id} position#{position} parent#{parent}")
    $.post('/category/reorder', {id: id, position:position, parent:parent}, (data)->
      if data == false
        $.jstree.rollback(data.rlbk)
    )
