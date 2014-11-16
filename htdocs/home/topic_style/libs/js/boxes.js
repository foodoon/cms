function showNewBanner(arg) {
	if ("" == arg.link) {
		jQuery('#banner_' + arg.boxId).attr("src", ctx + '/img/sample_banner.jpg');
		jQuery('#link_' + arg.boxId).attr("href", "#");
	} else {
		jQuery('#banner_' + arg.boxId).attr("src", ctx + arg.banner);
		jQuery('#link_' + arg.boxId).attr("href", ctx + arg.link);
	}
	if ("" != arg.boxId) {
		jQuery("#allBanners_"+arg.boxId).load(ctx + '/cms/bannerList.do?boxId=' + arg.boxId);
		document.forms['bannerEditor_' + arg.boxId].file.value='';
		document.forms['bannerEditor_' + arg.boxId].url.value='http://';
	}
}

function showNewImage(arg) {
	if ("" == arg.image) {
		jQuery('#banner_' + arg.boxId).attr("src", ctx + '/img/sample_image.jpg');
	} else {
		jQuery('#banner_' + arg.boxId).attr("src", ctx + arg.image);
	}
	if ("" != arg.boxId) {
		document.forms['imageEditor_' + arg.boxId].file.value='';
	}
}

function deleteBanner(boxId, bannerId) {
	jQuery.ajax({
		url : ctx + '/cms/deleteBanner.do',
		type : 'POST',
		data : {
			boxId : boxId,
			bannerId : bannerId
		},
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
	jQuery("#banner_" + boxId +"_" + bannerId).hide();
}
function deleteBlock(blockid){
    jQuery.ajax({
        url : ctx + '/cms/deleteBlock.do',
        type : 'POST',
        data : {
            blockid : blockid
        },
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
    jQuery("#block_" + blockid).hide();
}

(function($jq){
	$jq.fn.bannerEditor = function() {
		return this.each(function() {
			var link = jQuery('<div>' + $jq(this).html() + '</div>');
			
			link.css('cursor', 'pointer');
			
			var formId = this.id + "_form";
			var boxId = this.id;

			var allBanners = jQuery('<div id="allBanners_'+boxId+'"></div>');
			allBanners.load(ctx+'/cms/bannerList.do?boxId=' + boxId);
			
			var submitButton = jQuery("<input type=\"submit\" value=\"保存\"/>")
			var cancelButton = jQuery("<input type=\"button\" value=\"取消\"/>")
			
			var adder = jQuery('<form class="cmsDialog" name=\"bannerEditor_' + boxId + '\" method=\"POST\" enctype=\"multipart/form-data\" action=\"editbanner\" id=\"' +
			 		formId + '\"/>');
			adder.hide();
			
			adder.append(allBanners);
			
			adder.append(jQuery("<hr />"));
			adder.append(jQuery("<b>新 Banner</b>"));
			
			var input = jQuery("<p>Banner 图片: </p><p><input type=\"file\" name=\"file\"/></p>");
			adder.append(input);
			var url = jQuery('<p>图片链接: </p><p><input type="text" value="http://" name="url" /></p>');
			adder.append(url);
			adder.append(jQuery("<input type=\"hidden\" name=\"boxId\" value=\""+ boxId + "\"/>"));
			
			var p = jQuery("<p></p>");
			p.append(submitButton);
			p.append(cancelButton);
		
			adder.append(p);
			adder.append(jQuery("<p>&nbsp;</p>"))			
			link.click(function(e) {
				e.preventDefault();
				//link.hide();
				adder.show();
				input.focus();
			});

			cancelButton.click(function(e){
					adder.hide();
					//link.show();
			});
			
			input.keydown(function (e) {
				if (e.keyCode == 27) {
					e.preventDefault();
					adder.hide();
					//link.show();
				}
			});
			
			url.keydown(function (e) {
				if (e.keyCode == 27) {
					e.preventDefault();
					adder.hide();
					//link.show();
				}
			});			
		
			adder.submit(function (e){
				e.preventDefault();
				adder.hide();
				//link.show();
				jQuery(adder).ajaxSubmit({
					url : ctx + "/cms/addBanner.do",
					success : function(result, status) {
						if (false === result.success) {
							displayError(result);
			 			} else if (true === result.success) {
			 				displaySuccess(result);
			 				showNewBanner(result.o);
			 			}
					},
					error : function(xhr, status, error) {
						displayError({msg : '请求异常'});
					}
				})
			});	
			
			$jq(this).html('');
			$jq(this).append(link);
			$jq(this).append(adder);
		});
	}
})(jQuery);

function bannerUrlEditor(obj) {
			jQuery(obj).css('cursor', 'pointer');
			
			var formId = obj.id + "_form";
			var boxId = (obj.id).substring((obj.id).indexOf('_')+1, (obj.id).lastIndexOf('_'));
			var bannerId = (obj.id).substring((obj.id).lastIndexOf('_')+1);
			
			var submitButton = jQuery("<input type=\"submit\" value=\"保存\"/>")
			var cancelButton = jQuery("<input type=\"button\" value=\"取消\"/>")
			
			var adder = jQuery(	'<form class="cmsDialog" ' +
								'name=\"bannerUrlEditor_' + boxId + '_' + bannerId +
								'\" method=\"POST\" enctype=\"multipart/form-data\" ' +
								'action=\"editbannerurl\" id=\"' + formId + '\"/>');
			adder.show();
			
			var file = jQuery('<p><input type="file" name="file" /></p>');
			var url = jQuery('<p><input type="text" value="'+jQuery(obj).attr('alt')+'" name="url" /></p>');
			adder.append(file);
			adder.append(url);
			adder.append(jQuery("<input type=\"hidden\" name=\"boxId\" value=\""+ boxId + "\"/>"));
			adder.append(jQuery("<input type=\"hidden\" name=\"bannerId\" value=\""+ bannerId + "\"/>"));
			
			var p = jQuery("<p></p>");
			p.append(submitButton);
			p.append(cancelButton);
		
			adder.append(p);
			
			//jQuery(obj).hide();
			adder.show();
			url.focus();
			//jQuery(obj).hide();

			cancelButton.click(function(e){
					adder.hide();
					//jQuery(obj).show();
			});
			
			url.keydown(function (e) {
				if (e.keyCode == 27) {
					e.preventDefault();
					adder.hide();
					//jQuery(obj).show();
				}
			});			
		
			adder.submit(function (e){
				e.preventDefault();
				adder.hide();
				//jQuery(obj).show();
				jQuery(adder).ajaxSubmit({
					url : ctx + "/cms/updateBannerUrl.do",
					success : function(result, status) {
						if (false === result.success) {
							displayError(result);
			 			} else if (true === result.success) {
			 				displaySuccess(result);
			 				showNewBanner(result.o);
			 			}
					},
					error : function(xhr, status, error) {
						displayError({msg : '请求异常'});
					}
				})
			});	
			
			jQuery(obj.parentNode).append(adder);
}


(function($jq){
	$jq.fn.imageEditor = function() {
		return this.each(function() {
		
			var link = jQuery('<div>' + $jq(this).html() + '</div>');
			
			link.css('cursor', 'pointer');
			
			var formId = this.id + "_form";
			var boxId = this.id;

			var submitButton = jQuery("<input type=\"submit\" value=\"保存\"/>")
			var cancelButton = jQuery("<input type=\"button\" value=\"取消\"/>")
			
			var adder = jQuery('<form class="cmsDialog" name=\"imageEditor_' + boxId + '\" method=\"POST\"  action=\"editimage\" id=\"' +	formId + '\"/>');
			adder.hide();
			
			var input = jQuery("<p>请输入图片地址:<input type=\"text\" name=\"url\"/></p>");
			adder.append(input);
			adder.append(jQuery("<input type=\"hidden\" name=\"boxId\" value=\""+ boxId + "\"/>"));
			
			var p = jQuery("<p></p>");
			p.append(submitButton);
			p.append(cancelButton);
		
			adder.append(p);
			
			link.click(function(e) {
				e.preventDefault();
				//link.hide();
				adder.show();
				input.focus();
			});

			cancelButton.click(function(e){
					adder.hide();
					//link.show();
			});
			
			input.keydown(function (e) {
				if (e.keyCode == 27) {
					e.preventDefault();
					adder.hide();
					//link.show();
				}
			});
			
			adder.submit(function (e){
				e.preventDefault();
				adder.hide();
				link.show();
				jQuery(adder).ajaxSubmit({
					url : ctx + "/cms/setImage.do",
					success : function(result, status) {
						if (false === result.success) {
							displayError(result);
			 			} else if (true === result.success) {
			 				displaySuccess(result);
			 				showNewImage(result.o);
			 			}
					},
					error : function(xhr, status, error) {
						displayError({msg : '请求异常'});
					}
				})
			});	
			
			$jq(this).html('');
			$jq(this).append(link);
			$jq(this).append(adder);
		});
	}
})(jQuery);