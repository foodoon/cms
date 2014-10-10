delete from jc_channel_ext where channel_id=64;
delete from jc_channel_model where channel_id=64;
delete from jc_chnl_group_contri where channel_id=64;
delete from  jc_content_attr where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_channel where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_check where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_count where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_ext where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_topic where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_txt where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_picture where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_content_attachment where content_id in (select content_id from jc_content where channel_id=64);
delete from  jc_comment_ext where comment_id in (select comment_id from  jc_comment where content_id in (select content_id from jc_content where channel_id=64));

delete from  jc_comment where content_id in (select content_id from jc_content where channel_id=64);

delete from jc_content where channel_id=64;
delete from jc_topic where channel_id=64;
delete from jc_content_channel where channel_id=64;
delete from jc_chnl_group_view where channel_id=64;
delete from  jc_channel where channel_id=64;