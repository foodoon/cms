
// DOM ready!

$(function(){

  // Very basic usage
  
  $.fn.EasyWidgets({

    callbacks : {

      onClose : function(link, widget){
        alert('Close the widget: ' + widget.attr('id'))
      }

    }

  });
  
});