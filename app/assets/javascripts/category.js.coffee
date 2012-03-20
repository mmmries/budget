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
  console.log(ev, data);
