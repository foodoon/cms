
// DOM ready!

$(function(){

  // Very basic usage
  
  $.fn.EasyWidgets({

    callbacks : {

      onDragStop : function(link, ui){

        // Use Firebug (for example) to know more about "ui"
        // console.info(ui);

        alert('Drag stop widget: ' + ui.item[0].id)
      }

    }

  });
  
});