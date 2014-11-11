
// DOM ready!

$(function(){

  // Use i18n settins to show images instead text in menu links
  
  $.fn.EasyWidgets({
    i18n : {
      editText : '<img src="./edit.png" alt="Edit" width="16" height="16" />',
      closeText : '<img src="./close.png" alt="Close" width="16" height="16" />',
      collapseText : '<img src="./collapse.png" alt="Close" width="16" height="16" />',
      cancelEditText : '<img src="./edit.png" alt="Edit" width="16" height="16" />',
      extendText : '<img src="./extend.png" alt="Close" width="16" height="16" />'
    }
  });
  
});