package guda.cms.action.admin.design;

import guda.cms.action.directive.ContentListDirective;
import guda.cms.entity.main.Channel;
import guda.cms.entity.main.Content;
import guda.cms.manager.main.ChannelMng;
import guda.cms.manager.main.CmsTopicMng;
import guda.cms.manager.main.ContentMng;
import guda.common.util.ArrayUtils;
import guda.common.web.ResponseUtils;
import guda.common.web.freemarker.DirectiveUtils;
import guda.core.web.util.FrontUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Created by foodoon on 2014/11/7.
 */
@Controller
public class TopicPreviewAct {

    @Autowired
    private CmsTopicMng cmsTopicMng;

    @Autowired
    private ContentMng contentMng;
    @Autowired
    private ChannelMng channelMng;


    /**
     *
     * @param ids
     * @param topicId 专题ID
     * @param titLen
     * @param count
     * @param orderBy 排序
     * @param typeId  类型ID，多个,分割
     * @param channelIds 栏目ID
     * @param channelOption 输入参数，栏目选项。用于单栏目情况下。0：自身栏目；1：包含子栏目；2：包含副栏目。
     * @param titleImg 是否有标题图，默认所有
     * @param recommend 是否推荐，默认所有
     * @param title
     * @param request
     * @param response
     * @param model
     */
    @RequestMapping(value = "/preview/topic.do", method = RequestMethod.GET)
    public void list(String ids,Integer topicId,Integer titLen,Integer count, int orderBy ,String typeId,String channelIds,  Integer channelOption,
                     Boolean titleImg,Boolean recommend,String title,
                     HttpServletRequest request, HttpServletResponse response,
                     ModelMap model){

        List<Content> listByIdsForTag = null;
        if (ids != null) {
            Integer[] intIds = ArrayUtils.convertStrArrayToInt(ids.split(","));
            listByIdsForTag = contentMng.getListByIdsForTag(intIds, orderBy);
        } else {

            Integer[] intTypeIds = null;
            if(StringUtils.hasText(typeId)){
                intTypeIds = ArrayUtils.convertStrArrayToInt(typeId.split(","));
            }
            listByIdsForTag =   contentMng.getListByTopicIdForTag(topicId, null,
                    getChannelId(channelIds,channelOption), intTypeIds, titleImg, recommend, title,2,null,
                    orderBy, 0, count);

        }
        StringBuilder buf = new StringBuilder();
        for(Content content:listByIdsForTag){

        }
        JSONObject object = new JSONObject();
        object.put("result",listByIdsForTag);
        ResponseUtils.renderJson(response, object.get("result").toString());
    }

    private Integer[] getChannelId(String channelIds,  Integer channelOption){
        Integer[] intChannelIds = null;

        if(StringUtils.hasText(channelIds)){
            List<Integer> channelIdList = new ArrayList<Integer>();
            intChannelIds = ArrayUtils.convertStrArrayToInt(channelIds.split(","));
            if(channelOption!=null){

                if(channelOption.intValue() == 1){
                    //查询子栏目
                    for(int cid:intChannelIds) {
                        channelIdList.add(cid);
                        List<Channel> childList = channelMng.getChildList(cid, true);
                        for(Channel c:childList){
                            channelIdList.add(c.getId());
                        }
                    }
                }else if(channelOption.intValue() == 2){
                    //查询副栏目
                    for(int cid:intChannelIds) {
                        channelIdList.add(cid);
                    }
                }else{
                    for(int cid:intChannelIds) {
                        channelIdList.add(cid);
                    }
                }
            }
            return channelIdList.toArray(new Integer[channelIdList.size()]);
        }else{
            return null;
        }

    }

    @RequestMapping(value = "/preview/topic.do", method = RequestMethod.GET)
    public void list(){

    }
}
