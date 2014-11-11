
/*
   Copyrights (C) 2008 David Esperalta <davidesperalta@gmail.com>

   This file is part of Easy Widgets jQuery plugin for jQuery

   Easy Widgets is free software: you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version.

   Easy Widgets is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with Easy Widgets. If not, see <http://www.gnu.org/licenses/>.

*/

/**
 * Easy Widgets jQuery plugin 1.0 (beta)
 * 
 * David Esperalta - http://www.bitacora.davidesperalta.com/
 *
 * Please, use the included documentation and examples for
 * information about how use this plugin. Thanks very much!
 *
 * Tested in Firefox 3, Opera 9, IExplorer 7 and Safari 3
 *
 * I base my work on a tutorial writen by James Padolsey
 * http://nettuts.com/tutorials/javascript-ajax/inettuts/
 */

/**
 * Begin the plugin workspace
 */
(function($){

  /**
   * This is the main method of the plugin. Is called when Widgets HTML
   * markup, to execute the appropiate Javascript over it.
   * 
   * The method receive the settings argument with some options. If no
   * argument is receive the method use the default plugin settins.
   *
   * See the default settings for this method bello, in this same script.
   *
   * @access public
   * @param settings Array with the plugin options
   * @return Boolean True in every case
   */
  $.fn.EasyWidgets = function(settings){
    /**
     * Initialize some useful variables
     */
    var widgetCount = 0;
    var widgetsIds = new Array();
    /**
     * Recursively extend settings with default plugin settings
     * Put the settings in a short variable for we convenience
     */
    var s = $.extend(true, $.fn.EasyWidgets.defaults, settings);
    /**
     * By default the Widgets editbox are hidden.
     */
    $(s.selectors.editbox).hide();
    /**
     * Prepare the Widget header menu links container
     */
    var menuLinksHtm = '<span class="' + s.selectors
     .menuLinks.replace(/\./, '') + '"></span>';
    $(menuLinksHtm).appendTo(s.selectors.handle, this);
    /**
     * Iterate the Widgets found in the document, in other words
     * execute some actions for every Widget found in the document
     */
    $(s.selectors.widget).each(function(){
      /**
       * Increment the widget count variable
       */
      widgetCount++;
      /**
       * Initialize some other variables for we convenience in this
       * workspace. Is more easy (we think) use thisWidget variable
       * insted the $(this) instruction, specially whe use to much.
       */
      var cookieValue = '';
      var thisWidget = $(this);
      var thisWidgetId = thisWidget.attr('id');
      var thisMenuLinks = thisWidget.find(s.selectors.menuLinks);
      var thisWidgetContent = thisWidget.find(s.selectors.content);
      var useCookies = (thisWidgetId && s.behaviour.useCookies && $.cookie);
      /**
       * Begin the work
       */
      if(thisWidgetId){
        // Store the Widget ID, if anyone found
        widgetsIds[widgetCount] = thisWidgetId;
      }
      /**
       * Find if the user want to use cookies or what
       * In this case we can find if the Widget must
       * be positioned in certain Widgets column
       */
      if(useCookies && $.cookie(s.cookies.positionName)){
        // Get the positions cookie value
        cookieValue = $.cookie(s.cookies.positionName);
        // Find if the Widget ID is in the positions cookie
        if(cookieValue.indexOf(thisWidgetId) != -1){
          // Find the column to append the positioned Widget
          var matched = cookieValue.match(thisWidgetId+"=(.*)");
          if(matched){
            // Append theWidget to matched column
            thisWidget.appendTo('#'+matched[1]);
          }
        }
      }
      /**
       * In this case we can find if the Widget must
       * be closed (hidden) or not.
       */
      if(useCookies && $.cookie(s.cookies.closeName)){
        cookieValue = $.cookie(s.cookies.closeName);
        if(cookieValue.indexOf(thisWidgetId) != -1){
          thisWidget.hide();
        }
      }

      /**
       * We prepare now the collapse Widget link. This link
       * can be used to collapse and extend the Widget.
       */
      var collapseLink = '';
      /**
       * However, the collapse link only appear if user want
       * with the appropiate class in the Widget HTML markup
       */
      if(thisWidget.hasClass(s.options.collapsable)){

        /**
         * Take a look: we find if the user want to collapse
         * this Widget from the begin, using another CSS class
         *
         * We continue with the link creation, but, the text
         * link and the link behaviour change: can be use to
         * expand the Widget, not to collapse
         */
        if(thisWidget.hasClass(s.options.collapse)){
          collapseLink = WidgetLink(
            s.i18n.extendText,
            s.i18n.extendTitle,
            s.selectors.collapseLink
          );
          thisWidgetContent.hide();
        }else{
          collapseLink = WidgetLink(
            s.i18n.collapseText, 
            s.i18n.collapseTitle,
            s.selectors.collapseLink
          );
        }
        /**
         * Note how the use of cookies can overwrite this link behaviour
         * In other words, the Widget HTML markup can determine that the
         * Widget is collapse or not, but if use cookies the cookie value
         * can change this link behaviour
         */
        if(useCookies){
          cookieValue = $.cookie(s.cookies.collapseName);
          if(cookieValue){
            if(cookieValue.indexOf(thisWidgetId) != -1){
              collapseLink = WidgetLink(
                s.i18n.extendText,
                s.i18n.extendTitle,
                s.selectors.collapseLink
              );
              thisWidgetContent.hide();
            }
          }
        }
        /**
         * Above we prepare the link text, title and CSS class (determine
         * the link behaviour). Here we prepare the execution of this link,
         * in other words, handle the "onmousedown" and "onclick" link events.
         */
        $(collapseLink).mousedown(function(e){
          
          e.stopPropagation();

        }).click(function(){
          /**
           * Some variables for we convenience in this workspace
           */
          var thisLink = $(this);
          var canbeExtend = true;
          var canbeCollapse = true;
          var thisWidget = thisLink.parents(s.selectors.widget);
          var thisWidgetId = thisWidget.attr('id');
          var thisWidgetContent = thisWidget.find(s.selectors.content);
          var contentVisible = thisWidgetContent.css('display') != 'none';
          var useCookie = thisWidgetId && s.behaviour.useCookies && $.cookie;
          thisLink.blur();
          /**
           * Remember the workspace, here we handle the "onclick" event
           * of this link. So, the user use the link and expect something
           */
          if(contentVisible){
            // If Widget content is visible, user want to collapse the Widget
            if(s.callbacks.onCollapseQuery != null){
              // Call the appropiate plugin callback for this action
              canbeCollapse = s.callbacks.onCollapseQuery(thisLink, thisWidget);
            }
            // By default the Widget can be collapse, but the plugin callback
            // can change the behaviour using the collapse variable
            if(canbeCollapse){
              // If true, finally the Widget must be collapse
              thisWidgetContent.hide();
              thisLink.html(s.i18n.extendText);
              thisLink.attr('title', s.i18n.extendTitle);
              if(useCookie){
                // And prepare the collapse cookies if is use
                var cookieValue = $.cookie(s.cookies.collapseName);
                if(!cookieValue){
                  cookieValue = thisWidgetId;
                }else if(cookieValue.indexOf(thisWidgetId) == -1){
                  cookieValue = cookieValue+','+thisWidgetId;
                }
                $.cookie(s.cookies.collapseName, cookieValue, {
                  path: s.cookies.path,
                  secure: s.cookies.secure,
                  domain: s.cookies.domain,
                  expires: s.cookies.expires
                });
              }
              if(s.callbacks.onCollapse != null){
                s.callbacks.onCollapse(thisLink, thisWidget);
              }
            }
          /**
           * The Widget content is not visible, in other words, the user
           * want to expand the Widget
           */
          }else{
            if(s.callbacks.onExtendQuery != null){
              // Call the appropiate plugin callback
              canbeExtend = s.callbacks.onExtendQuery(thisLink, thisWidget);
            }
            // If finally the Widget can be extended, show it
            if(canbeExtend){
              thisLink.html(s.i18n.collapseText);
              thisLink.attr('title', s.i18n.collapseTitle);
              thisWidgetContent.show();
              if(useCookie){
                // And update the collapse cookie value, removing this Widget
                cookieValue = $.cookie(s.cookies.collapseName);
                if(cookieValue.indexOf(thisWidgetId) != -1){
                  cookieValue = cookieValue.replace(','+thisWidgetId, '');
                  cookieValue = cookieValue.replace(thisWidgetId+',', '');
                  cookieValue = cookieValue.replace(thisWidgetId, '');
                }
                $.cookie(s.cookies.collapseName, cookieValue, {
                  path: s.cookies.path,
                  secure: s.cookies.secure,
                  domain: s.cookies.domain,
                  expires: s.cookies.expires
                });
              }
              if(s.callbacks.onExtend != null){
                s.callbacks.onExtend(thisLink, thisWidget);
              }
            }
          }
          // Ever return false to evit default link behaviour
          return false;
        }).appendTo($(thisMenuLinks, this));
      }
      
      /**
       * We prepare now the edit Widget link. This link
       * can be used to show the Widget editbox.
       */
      var editLink = '';
      /**
       * However, the edit link only appear if user want
       * with the appropiate class in the Widget HTML markup
       */
      if(thisWidget.hasClass(s.options.editable)){
        /**
         * Text, title and behaviour for this link
         */
        editLink = WidgetLink(
          s.i18n.editText, 
          s.i18n.editTitle,
          s.selectors.editLink
        );
        /**
         * Another plugin options are the use of close edit CSS
         * class into the Widget editbox container. If the class
         * exists, attach a method for handle their "onclick" event
         */
        thisWidget.find(s.selectors.closeEdit).click(function(e){
          var thisLink = $(this);
          var thisWidget = thisLink.parents(s.selectors.widget);
          var thisEditLink = thisWidget.find(s.selectors.editLink);
          var thisEditbox = thisWidget.find(s.selectors.editbox);
          thisLink.blur();
          thisEditbox.hide();
          thisEditLink.html(s.i18n.editText);
          thisEditLink.attr('title', s.i18n.editTitle);
          // Ever return false to evit default link behaviour
          return false;
        });
        /**
         * Above we prepare the link text, title and CSS class (determine
         * the link behaviour). Here we prepare the execution of this link,
         * in other words, handle the "onmousedown" and "onclick" link events.
         */
        $(editLink).mousedown(function(e){

          e.stopPropagation();
          
        }).click(function(){
          /**
           * Again initialize some variables for this workspace
           */
          var canbeShow = true;
          var canbeHide = true;
          var thisLink = $(this);
          var thisWidget = thisLink.parents(s.selectors.widget);
          var thisEditbox = thisWidget.find(s.selectors.editbox);
          var thisEditboxVisible = thisEditbox.css('display') != 'none';
          thisLink.blur();
          /**
           * Remember the workspace, we handle here the "onclick" event
           * of the Widget, so, if the Widget editbox is visible, the user
           * want to hide (close) the Widget editbox.
           */
          if(thisEditboxVisible){
            if(s.callbacks.onCancelEditQuery != null){
              canbeHide = s.callbacks.onCancelEditQuery(thisLink, thisWidget);
            }
            if(canbeHide){
              thisEditbox.hide();
              thisLink.html(s.i18n.editText);
              thisLink.attr('title', s.i18n.editTitle);
              if(s.callbacks.onCancelEdit != null){
                s.callbacks.onCancelEdit(thisLink, thisWidget);
              }
            }
          /**
           * If the Widget editbox is not visible, the user want to view
           */
          }else{
            if(s.callbacks.onEditQuery != null){
              // A plugin callback have the opportunity of handle this
              canbeShow = s.callbacks.onEditQuery(thisLink, thisWidget);
            }
            if(canbeShow){
              // Ok, finally show the Widget edit box
              thisLink.html(s.i18n.cancelEditText);
              thisLink.attr('title', s.i18n.cancelEditTitle);
              thisEditbox.show();
              if(s.callbacks.onEdit != null){
                s.callbacks.onEdit(thisLink, thisWidget);
              }
            }
          }
          // Ever return false to evit default link behaviour
          return false;
        }).appendTo($(thisMenuLinks, this));
      }

      /**
       * Now is the turn of the remove Widget link. This link can be
       * use to close (hide) the Widget. Note that no link to show the
       * Widget is provided: when a Widget is hidden, is hidden.
       */
      var removeLink = '';
      /**
       * However, the remove link only appear if user want
       * with the appropiate class in the Widget HTML markup
       */
      if(thisWidget.hasClass(s.options.removable)){
        /**
         * Text, title and behaviour for this link
         */
        removeLink = WidgetLink(
          s.i18n.closeText, 
          s.i18n.closeTitle,
          s.selectors.closeLink
        );
        /**
         * After the text, title and behaviour for this link, is turn
         * for handle the "onmousedown" and "onclick" events
         */
        $(removeLink).mousedown(function(e){

          e.stopPropagation();

        }).click(function(){
          /**
           * Variables for we convenience in this workspace
           */
          var canbeRemove = true;
          var thisLink = $(this);
          var thisWidget = thisLink.parents(s.selectors.widget);
          var thisWidgetId = thisWidget.attr('id');
          var useCookie = (thisWidgetId && s.behaviour.useCookies && $.cookie);
          thisLink.blur();
          
          if(s.callbacks.onCloseQuery != null){
            // An opportunity to not close the Widget
            canbeRemove = s.callbacks.onCloseQuery(thisLink, thisWidget);
          }
          if(canbeRemove){
            /**
             * Another options of this plugin can be use to show a confirm
             * dialog to the user before close the Widget. So, take a look
             * at the bellow condition: if the Widget have the CSS class
             * that we expect, we use the confirm dialog. In other case
             * the confirm dialog not it show.
             */
            if(!thisWidget.hasClass(s.options.closeConfirm)
             || confirm(s.i18n.confirmMsg)){
               if(useCookie){
                 // Store this Widget ID in the Widget closes cookie
                 var cookieValue = $.cookie(s.cookies.closeName);
                 if(!cookieValue){
                   cookieValue = thisWidgetId;
                 }else if(cookieValue.indexOf(thisWidgetId) == -1){
                   cookieValue = cookieValue+','+thisWidgetId;
                 }
                 $.cookie(s.cookies.closeName, cookieValue, {
                   path: s.cookies.path,
                   secure: s.cookies.secure,
                   domain: s.cookies.domain,
                   expires: s.cookies.expires
                 });
               }
               thisWidget.hide();
               if(s.callbacks.onClose != null){
                 s.callbacks.onClose(thisLink, thisWidget);
               }
            }
          }
          // Ever return false to evit default link behaviour
          return false;
        }).appendTo($(thisMenuLinks, this));
      }
    });

    /**
     * All the Widgets and header links is not ready. Now begin the
     * preparation of the sortable stuff for Widgets and Widgets columns.
     */

    var sortableItems = null;

    /**
     * Finf all the Widgets that we turn bellow in sortable items
     */
    sortableItems = (function(){
      var fixedWidgets = '';
      /**
       * Iterate for all Widgets
       */
      $(s.selectors.widget).each(function(count){
        /**
         * And find for movables or fixed Widgets
         */
        if(!$(this).hasClass(s.options.movable)){
          if(!this.id){
            // Unique ID for the Widget in any case
            this.id = 'widget-without-id-' + count;
          }
          fixedWidgets += '#'+this.id+',';
        }
      });
      /**
       * Finally return movable Widgets and Widgets columns as sortable items
       * Take a look at the container option: determine the Widget container
       * and can be "div", "li" or another. By default is a "div", that is,
       * the Widget is stored in a "div" container.
       */
      return $('> '+s.selectors.container+':not(' + fixedWidgets + ')',
       s.selectors.columns);
    })();
    
    /**
     * Prepare the Widget headers of movable Widgets found. Set their
     * cursor and handle their "onmosedown" and "onmouseup" events.
     */
    sortableItems.find(s.selectors.handle).css({
      cursor: 'move'
    }).mousedown(function(e){
      var thisHeader = $(this);
      sortableItems.css({width:''});
      thisHeader.parent().css({
        width: thisHeader.parent().width() + 'px'
      });
   }).mouseup(function(){
      var thisHeader = $(this);
      if(!thisHeader.parent().hasClass('dragging')){
        thisHeader.parent().css({width:''});
      }else{
        $(s.selectors.columns).sortable('disable');
      }
    });

    /**
     * Now we are prepared to call the sortable jQuery function
     * over the Widgets columns found in the document. More information
     * about this function can be found in the jQuery Wiki website.
     */
    $(s.selectors.columns).sortable({
      items: sortableItems,
      containment: 'document',
      forcePlaceholderSize: true,
      handle: s.selectors.handle,
      delay: s.behaviour.dragDelay,
      revert: s.behaviour.dragRevert,
      opacity: s.behaviour.dragOpacity,
      connectWith: $(s.selectors.columns),
      placeholder: s.selectors.placeHolder,
      start : function(e, ui){
        $(ui.helper).addClass('dragging');
      },
      stop : function(e, ui){
        $(ui.item).css({width : ''}).removeClass('dragging');
        $(s.selectors.columns).sortable('enable');
        /**
         * Some variables for we convenience in this workspace
         */
        var widgetId = ui.item[0].id;
        var holderId = ui.element[0].id;
        var targetId = ui.item[0].parentNode.id;
        var useCookies = widgetId && s.behaviour.useCookies && $.cookie;
        /**
         * If use cookies and the target ID it not the same than hoder ID
         * we store in the positions cookie this Widget ID and the new
         * Widget holder (target ID). Before of that we must to remove of
         * the cookie the previous Widget ID and place holder if exists.
         */
        if(useCookies && holderId != targetId){
          var cookieValue = $.cookie(s.cookies.positionName);
          if(!cookieValue){
            // Save this Widget ID and their current place holder
            cookieValue = widgetId+'='+targetId;
          }else{
            // Remove from the cookie the possible last Widget position
            cookieValue = cookieValue.replace(','+widgetId+'='+holderId, '');
            cookieValue = cookieValue.replace(widgetId+'='+holderId+',', '');
            cookieValue = cookieValue.replace(widgetId+'='+holderId, '');
            // And store appropiattely the new Widget position
            if($.trim(cookieValue) == ''){
              cookieValue += widgetId+'='+targetId;
            }else{
              cookieValue += ','+widgetId+'='+targetId;
            }
          }
          // Finally set the position cookie value
          $.cookie(s.cookies.positionName, cookieValue, {
            path: s.cookies.path,
            secure: s.cookies.secure,
            domain: s.cookies.domain,
            expires: s.cookies.expires
          });
        }
        if(s.callbacks.onDragStop != null){
          s.callbacks.onDragStop(e, ui);
        }
        return true;
      }
    });

    /**
     * At this point the Widgets are be ready for use, but one more thing
     * can be clean the plugin cookies if the appropiate option is used. This
     * task is useful (in case of use cookies) because mantain the cookies
     * values with the existing Widgets.
     *
     * In other words, if a Widget is not printed out in the HTML markup
     * but their identifier is used in the Widgets cookies related, this
     * not have sense, so, we looking for unused Widgets in the cookies
     * and remove it, cleaning the Widgets cookies.
     */ 
    var cleanCookies = s.behaviour.useCookies && (widgetsIds.length > 0);

    if(cleanCookies){
      var i = 0;
      var j = 0;
      var cookies = new Array(
        s.cookies.closeName,
        s.cookies.positionName,
        s.cookies.collapseName
      );
      var cookiesLen = cookies.length;
      /**
       * Iterate all the Widgets cookies
       */
      for(i = 0; i < cookiesLen; i++){
        if($.cookie(cookies[i])){
          var newValue = '';
          var currents = $.cookie(cookies[i]).split(',');
          var optionsLen = currents.length;
          for(j = 0; j < optionsLen; j++){
            var widgetId = '';
            var widgetColumn = '';
            if(cookies[i] == s.cookies.positionName){
              /**
               * For this type of cookie we have a value with the Widget ID
               * and their column separated by a "=" character. Get it.
               */
              var cookieValue = currents[j].split('=');
              if(cookieValue.length == 2){
                widgetId = cookieValue[0];
                widgetColumn = cookieValue[1];
              }
            }else{
              // For other cookies we store only the Widget ID
              widgetId = currents[j];
            }
            widgetId = $.trim(widgetId);
            if($.inArray(widgetId, widgetsIds) != -1){
              if(cookies[i] == s.cookies.positionName){
                if($.trim(newValue) == ''){
                  newValue += widgetId+'='+widgetColumn;
                }else{
                  newValue += ','+widgetId+'='+widgetColumn;
                }
              }else{
                if($.trim(newValue) == ''){
                  newValue += widgetId;
                }else{
                  newValue += ','+widgetId;
                }
              }
            }
            // Finally store this cookie new value
            $.cookie(cookies[i], newValue,{
              path: s.cookies.path,
              secure: s.cookies.secure,
              domain: s.cookies.domain,
              expires: s.cookies.expires
            });
          }
        }
      }
    }

  };
  // End of the main plugin function

  /**
   * Fill the plugin default settings
   */
  $.fn.EasyWidgets.defaults = {
    // Behaviour of the plugin
    behaviour : {
      // Miliseconds delay between mousedown and drag start
      dragDelay : 100,
      // Miliseconds delay between mouseup and drag stop
      dragRevert : 100,
      // Determinme the opacity of Widget when start drag
      dragOpacity : 0.8,
      // Cookies (require Cookie plugin) to store positions and states
      useCookies : false
    },
    // Only for the optional cookie feature
    cookies : {
      // Cookie path
      path : '',
      // Cookie domain
      domain : '',
      // Cookie expiration time in days
      expires : 90,
      // Store a secure cookie?
      secure : false,
      // Cookie name for close Widgets
      closeName : 'easywidgets-close',
      // Cookie name for positined Widgets
      positionName : 'easywidgets-position',
      // Cookie name for collapsed Widgets
      collapseName : 'easywidgets-collapse'
    },
    // Options name to use in the HTML markup
    options : {
      // To recognize a movable Widget
      movable : 'movable',
      // To recognize a editable Widget
      editable : 'editable',
      // To recognize a collapse Widget
      collapse : 'collapse',
      // To recognize a removable Widget
      removable : 'removable',
      // To recognize a collapsable Widget
      collapsable : 'collapsable',
      // To recognize Widget that require confirmation when remove
      closeConfirm : 'closeconfirm'
    },
    // Callbacks functions
    callbacks : {
      // When a editbox is closed, send the link and the widget objects
      onEdit : null,
      // When a Widget is closed, send the link and the widget objects
      onClose : null,
      // When a Widget is extend, send the link and the widget objects
      onExtend : null,
      // When a editbox is closed, send a ui object, see jQuery::sortable()
      onDragStop : null,
      // When a Widget is collapse, send the link and the widget objects
      onCollapse : null,
      // When a editbox is try to close, send the link and the widget objects
      onEditQuery : null,
      // When a Widget is try to close, send the link and the widget objects
      onCloseQuery : null,
      // When a editbox is cancel (close), send the link and the widget objects
      onCancelEdit : null,
      // When a Widget is try to expand, send the link and the widget objects
      onExtendQuery : null,
      // When a Widget is try to expand, send the link and the widget objects
      onCollapseQuery : null,
      // When a editbox is try to cancel, send the link and the widget objects
      onCancelEditQuery : null
    },
    // Selectors in HTML markup. All can be change by you, but not all is
    // used in the HTML markup. For example, the "editLink" or "closeLink"
    // is prepared by the plugin for every Widget.
    selectors : {
      // Container of a Widget (into another element that use as column)
      // The container can be "div" or "li", for example. In the first case
      // use another "div" as column, and a "ul" in the case of "li".
      container : 'div',
      // Class identifier for a Widget
      widget : '.widget',
      // Class identifier for a Widget handle (header)
      handle : '.widget-head',
      // Class for the Widget header links container
      menuLinks : '.widget-menu-links',
      // Class identifier for a Widget column (parents of Widgets)
      columns : '.widget-column',
      // Class identifier for Widget editboxes
      editbox : '.widget-editbox',
      // Class identifier for Widget content
      content : '.widget-content',
      // Class identifier for editbox close link or button, for example
      closeEdit : '.widget-close-editbox',
      // Class identifier for a Widget edit link
      editLink : '.widget-editlink',
      // Class identifier for a Widget close link
      closeLink : '.widget-closelink',
      // Class identifier for Widgets placehoders
      placeHolder : 'widget-placeholder',
      // Class identifier for a Widget collapse link
      collapseLink : '.widget-collapselink'
    },
    // To be translate the plugin into another languages
    // But this variables can be used to show images instead
    // links text, if you preffer. In this case set the HTML
    // of the IMG elements.
    i18n : {
      // Widget edit link text
      editText : 'Edit',
      // Widget close link text
      closeText : 'Close',
      // Widget extend link text
      extendText : 'Extend',
      // Widget collapse link text
      collapseText : 'Collapse',
      // Widget cancel edit link text
      cancelEditText : 'Cancel',
      // Widget edition link title
      editTitle : 'Edit this widget',
      // Widget close link title
      closeTitle : 'Close this widget',
      // Widget confirmation dialog message
      confirmMsg : 'Remove this widget?',
      // Widget cancel edit link title
      cancelEditTitle : 'Cancel edition',
      // Widget extend link title
      extendTitle : 'Extend this widget',
      // Widget collapse link title
      collapseTitle : 'Collapse this widget'
    }
  };

  /**
   * Private members of the plugin
   */

  /**
   * Auxiliar function to prepare Widgets header links.
   *
   * @access private
   * @param text Link text
   * @param title Link title
   * @param aClass CSS class (behaviour) of link
   * @return String HTML of the link
   */
  function WidgetLink(text, title, aClass){
    var link = '<a href="#" title="TITLE" class="CLASS">TEXT</a>';
    link = link.replace(/TEXT/g, text);
    link = link.replace(/TITLE/g, title);
    link = link.replace(/CLASS/g, aClass.replace(/\./, ''));
    return link;
  }

})(jQuery);
