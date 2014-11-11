
// DOM ready!

$(function(){

  // Very basic usage
  
  $.fn.EasyWidgets({

    callbacks : {

      onClose : function(link, widget){
        alert('onClose callback :: Link: ' + link + ' - Widget: ' + widget);
      },

      onCloseQuery : function(link, widget){
        return confirm(
         'onCloseQuery callback :: Link: ' + link + ' - Widget: ' + widget + ' Continue?'
        )
      },

      onEdit : function(link, widget){
        alert('onEdit callback :: Link: ' + link + ' - Widget: ' + widget);
      },

      onEditQuery : function(link, widget){
        return confirm(
         'onEditQuery callback :: Link: ' + link + ' - Widget: ' + widget + ' Continue?'
        )
      },

      onCancelEdit : function(link, widget){
        alert('onCancelEdit callback :: Link: ' + link + ' - Widget: ' + widget);
      },

      onCancelEditQuery : function(link, widget){
        return confirm(
         'onCancelEditQuery callback :: Link: ' + link + ' - Widget: ' + widget + ' Continue?'
        )
      },

      onCollapse : function(link, widget){
        alert('onCollapse callback :: Link: ' + link + ' - Widget: ' + widget);
      },

      onCollapseQuery : function(link, widget){
        return confirm(
         'onCollapseQuery callback :: Link: ' + link + ' - Widget: ' + widget + ' Continue?'
        )
      },

      onExtend : function(link, widget){
        alert('onExtend callback :: Link: ' + link + ' - Widget: ' + widget);
      },

      onExtendQuery : function(link, widget){
        return confirm(
         'onExtendQuery callback :: Link: ' + link + ' - Widget: ' + widget + ' Continue?'
        )
      },

      onDragStop : function(event, ui){
        alert('onDragStop callback :: Event: ' + event + ' - ui: ' + ui);
      }
      
    }

  });
  
});