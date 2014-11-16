
jQuery(document).ready(function() {

	dressEditables();
 	dressRubricLinks();
 	
 	jQuery('.bannerBox').bannerEditor();
 	
 	jQuery('.imageBox').imageEditor();
	
	jQuery('.slideAdder').slideAdder('newSlide.do'); 	
	
 	jQuery.extend(DateInput.DEFAULT_OPTS, {
	  stringToDate: function(string) {
	    var matches;
	    if (matches = string.match(/^(\d{4,4})-(\d{2,2})-(\d{2,2})$/)) {
	      return new Date(matches[1], matches[2] - 1, matches[3]);
	    } else {
	      return null;
	    };
	  },
	  dateToString: function(date) {
	    var month = (date.getMonth() + 1).toString();
	    var dom = date.getDate().toString();
	    if (month.length == 1) month = "0" + month;
	    if (dom.length == 1) dom = "0" + dom;
	    return date.getFullYear() + "-" + month + "-" + dom;
	  }
	  
	});

 	jQuery(".date_input").date_input();
 	jQuery("#articleControlsHeader").click(function(){jQuery("#articleControls").toggle()});


    $("#appendBackgroud").on('click', function(){
        $.Dialog({
            overlay: true,
            shadow: true,
            flat: true,
            width: '500px',
            title: '设置背景',
            content: '',
            padding: 10,
            onShow: function(_dialog){

                var content = '<form id="append-background-form">' +
                    '<label>背景图片地址</label>' +
                    '<div class="input-control text"><input type="text" name="backgroundUrl"><button class="btn-clear"></button></div> ' +

                    '<div class="form-actions">' +
                    '<button class="button primary">保存</button> '+
                    '<button class="button" type="button" onclick="$.Dialog.close()">取消</button> '+
                    '</div>'+
                    '</form>';

                $.Dialog.title("设置背景");
                $.Dialog.content(content);
                $.Metro.initInputs();
                $("#append-background-form").submit(function(){
                    $(this).ajaxSubmit({
                        type:"post",
                        dataType:"json",
                        url:ctx + "/cms/setBackground.do",
                        success:function(data){
                            window.location.reload();
                        }
                    });
                    return false;
                });
            }
        });
    });


    $(".addBlockLink").on('click', function(){
        var id = this.id;
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
                    '<input type="hidden" name="id" value="'+id +'">' +
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
                        url:ctx + '/cms/newBlock.do',
                        success:function(data){
                            window.location.reload();
                        }
                    });
                    return false;
                });
            }
        });
    });
    /////

    $("#preview").on('click', function(){
        window.open(ctx + "/blank.do?m=preview&site="+s);

    });
    //////

    $("#finish").on('click', function(){
        window.open(ctx + "/generator.do?site="+s);

    });
    /////
});
