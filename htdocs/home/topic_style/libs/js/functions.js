
function dressRubricLinks() {
	jQuery('.addSubRubricLink').rubricAdder('newSubRubric.do', globals.currentRubricId);
    jQuery('.addTextBannerLink').addTextBanner('newTextBanner.do');
 //   jQuery('.addBlockLink').addBlock('newBlock.do');
}

function dressEditables() {
	jQuery(".edit").editable(ctx + '/cms/saveField.do',{
		 		tooltip	: '点击修改',
		 		cancel	: '<img src="'+ctx+'/img/cancel.png"/>',
		 		submit	: '<img src="'+ctx+'/img/save.png"/>',
		 		placeholder : '点击这里',
		 		onblur : 'ignore',
		 		ajaxoptions : {
		 			dataType : 'json'
		 		},
		 		callback : function(result, settings) {
		 			if (true === result.success) {
		 				jQuery(this).html(result.o);
		 				displaySuccess(result);
		 			} else if (false === result.success) {
		 				displayError(result);
		 			}
		 		}
		 	}
		);
}

(function($jq) {
    $jq.fn.addBlock = function(ajaxAction) {
        return this.each(function() {
            $.Dialog({
                overlay: true,
                shadow: true,
                flat: true,
                width: '500px',
                title: '设置区块',
                content: '',
                padding: 10,
                onShow: function(_dialog){

                    var content = '<form class="set-block-form">' +
                        '<label>选择区块:</label><select name="blockName"><option value="summary">专题概要</option>' +
                        '<option value="top">专题头条</option><option value="info_list">专题资讯库</option><option value="info_comment">专题热评排行</option><option value="info_follow">专题关注排行</option><option value="other">其他专题列表</option>'+
                        '</select>' +
                        '<div class="input-control text"><input type="text" name="backgroundUrl"><button class="btn-clear"></button></div> ' +
                        '<label>记录数:</label><input type="text" class="input" name="recordCount"/>'+
                        '<label>标题长度:</label><input type="text" class="input" name="titleLength"/>'+
                        '<label>内容长度:</label><input type="text" class="input" name="contentLength"/>'+
                        '<div class="form-actions">' +
                        '<button class="button primary">保存</button> '+
                        '<button class="button" type="button" onclick="$.Dialog.close()">取消</button> '+
                        '</div>'+
                        '</form>';

                    $.Dialog.title("设置区块");
                    $.Dialog.content(content);
                    $.Metro.initInputs();
                    $(".set-block-form").submit(function(){
                        $(this).ajaxSubmit({
                            type:"post",
                            dataType:"json",
                            url:ctx + '/cms/'+ ajaxAction,
                            success:function(data){
                                window.location.reload();
                            }
                        });
                        return false;
                    });
                }
            });
//            var self = this;
//            var id= this.id;
//            var link = jQuery('<span><img src="'+ctx+'/img/addrubric.png"></span>');
//            link.css('cursor', 'pointer');
//
//            var adder = jQuery('<form/>');
//            adder.hide();
//
//
//            var label = jQuery("<label>选择区块:</label>");
//            adder.append(label);
//            var select = jQuery("<select/>");
//            var option = jQuery("<option value='summary'>专题概要</option>");
//            select.append(option);
//            option = jQuery("<option value='top'>专题头条</option>");
//            select.append(option);
//            option = jQuery("<option value='info_list'>专题资讯库</option>");
//            select.append(option);
//            option = jQuery("<option value='info_comment'>专题热评排行</option>");
//            select.append(option);
//            option = jQuery("<option value='info_follow'>专题关注排行</option>");
//            select.append(option);
//            option = jQuery("<option value='other'>其他专题列表</option>");
//            select.append(option);
//            adder.append(select);
//
//            label = jQuery("<label>记录数:</label>");
//            adder.append(label);
//            var recordCount = jQuery("<input type=\"text\" class=\"input\" name=\"recordCount\"/>");
//            adder.append(recordCount);
//
//            label = jQuery("<label>标题长度:</label>");
//            adder.append(label);
//            var titleLength = jQuery("<input type=\"text\" class=\"input\" name=\"titleLength\"/>");
//            adder.append(titleLength);
//
//            label = jQuery("<label>内容长度:</label>");
//            adder.append(label);
//            var contentLength = jQuery("<input type=\"text\" class=\"input\" name=\"contentLength\"/>");
//            adder.append(contentLength);
//
//
//            var ok = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/save.png\" value=\"保存\"/>");
//            adder.append(ok);
//            var cancel = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/cancel.png\" value=\"取消\"/>");
//            adder.append(cancel);
//
//            link.click(function(e){
//                link.hide();
//                adder.show();
//              //  input.focus();
//                return false;
//            });
//
//            ok.click(function(e){
//                adder.submit();
//                return false;
//            });
//
//            cancel.click(function(e){
//                adder.hide();
//                link.show();
//                return false;
//            });
//
//
//            adder.submit(function (e){
//                e.preventDefault();
//                if(null != select.val()){
//                    jQuery.ajax({
//                        type : 'POST',
//                        data : {
//                            blockName : select.val(),
//                            recordCount : recordCount.val(),
//                            titleLength : titleLength.val(),
//                            contentLength : contentLength.val(),
//                            id:id
//                        },
//                        url : ctx + '/cms/'+ ajaxAction,
//                        success : function(result, status) {
//                            if (false === result.success) {
//                                displayError(result);
//                            } else if (true === result.success) {
//                                displaySuccess(result);
//                                window.location.reload();
//                            }
//                        },
//                        error : function(xhr, status, error) {
//                            displayError({msg : '请求异常'});
//                        }
//                    })
//                } else {
//                    alert('no no no: ' + currentRubricId);
//                }
//                return false;
//            });
//
//            $jq(this).html('');
//            $jq(this).append(link);
//            $jq(this).append(adder);
        });
    };
})(jQuery);

(function($jq) {
    $jq.fn.addTextBanner = function(ajaxAction) {
        return this.each(function() {
            var self = this;
            //var link = jQuery('<span>' + $jq(this).html() + '</span>');
            var link = jQuery('<span><img src="'+ctx+'/img/addrubric.png"></span>');
            link.css('cursor', 'pointer');

            var adder = jQuery('<form/>');
            adder.hide();
            var label = jQuery("<label>菜单名称:</label>");
            adder.append(label);
            var input = jQuery("<input type=\"text\" class=\"input\" name=\"name\"/>");
            adder.append(input);
            var label2 = jQuery("<label>菜单链接地址:</label>");
            adder.append(label2);
            var input2 = jQuery("<input type=\"text\" class=\"input\" name=\"url\"/>");
            adder.append(input2);
            var ok = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/save.png\" value=\"保存\"/>");
            adder.append(ok);
            var cancel = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/cancel.png\" value=\"取消\"/>");
            adder.append(cancel);

            link.click(function(e){
                link.hide();
                adder.show();
                input.focus();
                return false;
            });

            input.keydown(function (e) {
                if (e.keyCode == 27) {
                    e.preventDefault();
                    adder.hide();
                    link.show();
                    return false;
                }
            });
            /*
             input.blur(function(e) {
             adder.hide();
             link.show();
             return false;
             });
             */

            ok.click(function(e){
                adder.submit();
                return false;
            });

            cancel.click(function(e){
                adder.hide();
                link.show();
                return false;
            });


            adder.submit(function (e){
                e.preventDefault();
                if(null != input.val() && null != input2.val()){
                    jQuery.ajax({
                        type : 'POST',
                        data : {
                            url : input2.val(),
                            name : input.val()
                        },
                        url : ctx + '/cms/'+ ajaxAction,
                        success : function(result, status) {
                            if (false === result.success) {
                                displayError(result);
                            } else if (true === result.success) {
                                displaySuccess(result);
                                window.location.reload();
                            }
                        },
                        error : function(xhr, status, error) {
                            displayError({msg : '请求异常'});
                        }
                    })
                } else {
                    alert('no no no: ' + currentRubricId);
                }
                return false;
            });

            $jq(this).html('');
            $jq(this).append(link);
            $jq(this).append(adder);
        });
    };
})(jQuery);

(function($jq) {
	$jq.fn.rubricAdder = function(ajaxAction) {
		return this.each(function() {
			var self = this;
			var currentRubricId = this.id;
			//var link = jQuery('<span>' + $jq(this).html() + '</span>');
			var link = jQuery('<span><img src="'+ctx+'/img/addrubric.png"></span>');
			link.css('cursor', 'pointer');
			
			var adder = jQuery('<form style="display: inline;"/>');
			adder.hide();
			var input = jQuery("<input type=\"text\" class=\"input\" name=\"data\"/>");
			adder.append(input);
			var ok = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/save.png\" value=\"保存\"/>");
			adder.append(ok);
			var cancel = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/cancel.png\" value=\"取消\"/>");
			adder.append(cancel);
			
			link.click(function(e){
				link.hide();
				adder.show();
				input.focus();
				return false;
			});
			
			input.keydown(function (e) {
				if (e.keyCode == 27) {
					e.preventDefault();
					adder.hide();
					link.show();
					return false;
				}
			});
/*			
			input.blur(function(e) {
				adder.hide();
				link.show();
				return false;
			});
*/
			
			ok.click(function(e){
				adder.submit();
				return false;
			});
			
			cancel.click(function(e){
				adder.hide();
				link.show();
				return false;
			});			
			
			
			adder.submit(function (e){
				e.preventDefault();
				if(null != currentRubricId){
					jQuery.ajax({
						type : 'POST',
						data : {
							currentRubricId : currentRubricId,
							value : input.val()
						},
						url : ctx + '/cms/'+ ajaxAction,
						success : function(result, status) {
							if (false === result.success) {
								displayError(result);
				 			} else if (true === result.success) {
				 				displaySuccess(result);
				 				window.location.reload();
				 			}
						},
						error : function(xhr, status, error) {
							displayError({msg : '请求异常'});
						}
					})
				} else {
					alert('no no no: ' + currentRubricId);
				}
				return false;
			});	
			
			$jq(this).html('');
			$jq(this).append(link);
			$jq(this).append(adder);
		});
	};
})(jQuery);


(function($jq) {
	$jq.fn.slideAdder = function(ajaxAction) {
		return this.each(function() {
			
			var self = this;
			var slideshowId = this.parentNode.parentNode.id;
			var link = jQuery('<span>' + $jq(this).html() + '</span>');
			link.css('cursor', 'pointer');
			
			var adder = jQuery('<form style="display: inline; margin: 0px; padding: 0px;"/>');
			adder.hide();
			var input = jQuery("<input type=\"text\" class=\"input\" name=\"data\"/>");
			adder.append(input);
			var ok = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/save.png\" value=\"保存\"/>");
			adder.append(ok);
			var cancel = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/cancel.png\" value=\"取消\"/>");
			adder.append(cancel);
			
			link.click(function(e){
				link.hide();
				adder.show();
				input.focus();
				return false;
			});
			
			input.keydown(function (e) {
				if (e.keyCode == 27) {
					e.preventDefault();
					adder.hide();
					link.show();
					return false;
				}
			});

			ok.click(function(e){
				adder.submit();
				return false;
			});
			
			cancel.click(function(e){
				adder.hide();
				link.show();
				return false;
			});			
			
			
			adder.submit(function (e){
				e.preventDefault();
				if(null != slideshowId){
					jQuery.ajax({
						type : 'POST',
						data : {
							slideshowId : slideshowId,
							title : input.val()
						},
						url : ctx + '/cms/'+ ajaxAction,
						success : function(result, status) {
							if (false === result.success) {
								displayError(result);
				 			} else if (true === result.success) {
				 				input.val('');
								adder.hide();
								link.show();
								addSlide(result.o);
								displaySuccess(result);
				 			}
						},
						error : function(xhr, status, error) {
							displayError({msg : '请求异常'});
						}
					})
					
				} else {
					alert('no no no: ' + slideshowId);
				}
				return false;
			});	
			$jq(this).html('');
			$jq(this).append(link);
			$jq(this).append(adder);
		});
	};
})(jQuery);

function delSlide(slideId, slideshowId) {
	jQuery.ajax({
		type : 'POST',
		data : {
			slideId : slideId,
			slideshowId : slideshowId
		},
		url : ctx + '/cms/deleteSlide.do',
		success : function(result, status) {
			if (false === result.success) {
				displayError(result);
			} else if (true === result.success) {
				displaySuccess(result);
				reload();
			}
		},
		error : function(xhr, status, error) {
			displayError({msg : '请求异常'});
		}
	})
	return false;
}

function delRubric(deleteRubricId, currentRubricId) {
	jQuery.ajax({
		type : 'POST',
		data : {
			currentRubricId : currentRubricId,
			deleteRubricId : deleteRubricId
		},
		url : ctx + '/cms/deleteRubric.do',
		success : function(result, status) {
			if (false === result.success) {
				displayError(result);
			} else if (true === result.success) {
				displaySuccess(result);
				reload();
			}
		},
		error : function(xhr, status, error) {
			displayError({msg : '请求异常'});
		}
	})
	return false;
}

function delTextBanner(bannerId) {
    jQuery.ajax({
        type : 'POST',
        data : {
            bannerId : bannerId
        },
        url : ctx + '/cms/deleteTextBanner.do',
        success : function(result, status) {
            if (false === result.success) {
                displayError(result);
            } else if (true === result.success) {
                displaySuccess(result);
                reload();
            }
        },
        error : function(xhr, status, error) {
            displayError({msg : '请求异常'});
        }
    })
    return false;
}

function reload() {
	window.location.reload();
}

function convertToEditor(el, beforeconvert, onsubmit, oncancel){
	var id = "#" + el.id;
	tinymce.init({
    selector: id,
    language : 'zh_CN',
    save_enablewhendirty: true,
    save_onsavecallback: function(tiny) {
    	jQuery.ajax({
			type : 'POST',
			data : {
				id : el.id,
				value : tiny.getContent()
			},
			url : ctx + '/cms/saveField.do',
			success : function(result, status) {
				if (false === result.success) {
	 				displayError(result);
	 			} else if (true === result.success) {
	 				displaySuccess(result);
	 			}
			},
			error : function(xhr, status, error) {
				displayError('请求失败');
			}
		})
    },
    inline: true,
    plugins: [
   // "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak",
   // "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
    //"table contextmenu directionality emoticons textcolor paste textcolor save"
	  "advlist autolink lists link image charmap anchor",
	"searchreplace visualblocks code fullscreen",
	"insertdatetime media table contextmenu paste textcolor save" 
    ],
    custum_fontfamily : "宋体=宋体;微软雅黑=微软雅黑;新宋体=新宋体;Courier New=courier new,courier,monospace;AkrutiKndPadmini=Akpdmi-n",
    //menubar: false,
    toolbar_items_size: 'small',
/*    style_formats: [
        {title: 'Bold text', inline: 'b'},
        {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
       // {title: 'jj', inline: 'pre', styles: {'brush: java;'}},
        {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
        {title: 'Example 1', inline: 'span', classes: 'example1'},
        {title: 'Example 2', inline: 'span', classes: 'example2'},
         {title: 'jj', block: 'pre', classes: 'brush: java;'},
        {title: 'Table styles'},
        {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'},
         {title: 'Java', inline: 'pre', styles: 'brush: java;'}
    ],
*/    // toolbar1: "undo redo | cut copy paste | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
     //   toolbar2: " searchreplace | bullist numlist | outdent indent blockquote | link unlink anchor image media code | inserttime preview | forecolor backcolor",
     //   toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | print fullscreen | ltr rtl | spellchecker | visualchars visualblocks nonbreaking template pagebreak restoredraft",

   	toolbar1: "undo redo | bold italic underline strikethrough forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent  | link image",
   	toolbar2 : "formatselect | fontselect | fontsizeselect  | save"
});
	// colorpicker compat3x textpattern
	/* "advlist anchor autolink autoresize autosave bbcode charmap code  contextmenu",
    "directionality emoticons example example_dependency fullpage fullscreen hr image insertdatetime layer legacyoutput",
    "link lists importcss media nonbreaking noneditable pagebreak paste preview print save searchreplace",
    "spellchecker tabfocus table template textcolor visualblocks visualchars wordcount"*/
	/**var body = jQuery(el);
	body.hide();
	var formId = el.id + '_form';
	var adder = jQuery('<form name=\"bodySaver\" method=\"POST\" id=\"' + formId + '\"/>');
	var input = jQuery("<input type=\"hidden\" name=\"text\"/>");
	input.val(body.html());
	adder.append(input);
	var submitButton = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/save.png\" value=\"保存\"/>")
	var cancelButton = jQuery("<input type=\"image\" class=\"imgInput\" src=\""+ctx+"/img/cancel.png\" value=\"取消\"/>")
	var originalParentWidth = body.parent().innerWidth();
	alert(originalParentWidth);
	adder.append(submitButton);
	adder.append(cancelButton);
	
	var editorId = el.id + '_editor';
	var editorAdder = jQuery("<script id='"+editorId+"' type='text/plain'>" + body.html() +"<\/script>");
	
	cancelButton.click(function(e){
		body.html(input.val());
		UE.getEditor(editorId).destroy();
		body.show();
		adder.remove();
		jQuery("#"+editorId).remove();
		if(oncancel) {
			oncancel();
		}
		return false;
	});

	submitButton.click(function (e){
		e.preventDefault();
		var html = UE.getEditor(editorId).getContent();
		body.html(html);
		input.val(html);
		jQuery.ajax({
			type : 'POST',
			data : {
				id : el.id,
				value : input.val()
			},
			url : ctx + '/cms/saveField.do',
			success : function(result, status) {
				if (false === result.success) {
	 				displayError(result);
	 			} else if (true === result.success) {
	 				UE.getEditor(editorId).destroy();
					body.show();
					adder.remove();
					jQuery("#"+editorId).remove();
	 				displaySuccess(result);
	 			}
			},
			error : function(xhr, status, error) {
				displayError('请求失败');
			}
		})
		
		
		// body.parent().css("height", originalParentHeight);
		//body.parent()[0].style.height = originalParentHeight;
		adder.hide();
		if(jQuery.trim(body.html()) == '') {
			body.text('(点击这里编辑)');
		}
		if(onsubmit){
			onsubmit();
		}
		return false;
		//adder.remove();
	});	

	
	body.after(adder);
	//body.parent().css("height", "auto");
	if(beforeconvert){
		beforeconvert();
	}
	body.after(editorAdder);
	//alert(originalParentHeight);
	UE.getEditor(editorId, {
		initialFrameWidth : originalParentWidth
	});*/
}

function updateArticlePic(params) {
	var a = jQuery('#article_pic_' + params.articleId);
	var el = jQuery('#article_pic_' + params.articleId + ' img');
	el.attr('src',params.thumb);
}

function displayError(params) {
	jQuery('#error').html(params.msg);
	jQuery('#errorBox').show();
	return false;
}
function displaySuccess(params) {
    var time = 1000;
    if (jQuery("#tip_message").text().length > 0) {
        var msg = "<span>" + params.msg + "</span>";
        jQuery("#tip_message").empty().append(msg);
    } else {
        var msg = "<div id=\"tip_message\"><span>" + params.msg + "</span></div>";
        jQuery("body").append(msg);
    }
    jQuery("#tip_message").fadeIn(time);
    jQuery("#tip_message").fadeOut(time)
};

function setCacheDisabled(flag) {
	jQuery.ajax({
		type : 'POST',
		data : {
			flag : flag
		},
		url : ctx + '/cms/setCacheDisabled.do',
		success : function(result, status) {
			if (false === result.success) {
 				displayError(result);
 			} else if (true === result.success) {
 				displaySuccess(result);
 				window.location = ctx + "/logout.html";
 			}
		},
		error : function(xhr, status, error) {
			displayError('请求失败');
		}
	})
}

