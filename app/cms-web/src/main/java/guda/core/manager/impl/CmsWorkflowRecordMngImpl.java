package guda.core.manager.impl;

import guda.core.dao.CmsWorkflowRecordDao;
import guda.core.entity.CmsSite;
import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflowEvent;
import guda.core.entity.CmsWorkflowRecord;
import guda.core.manager.CmsWorkflowRecordMng;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsWorkflowRecordMngImpl implements CmsWorkflowRecordMng {
	@Transactional(readOnly = true)
	public List<CmsWorkflowRecord> getList(Integer eventId,Integer userId){
		return dao.getList(eventId, userId);
	}
	
	public CmsWorkflowRecord save(CmsSite site, CmsWorkflowEvent event,
			CmsUser user, String opinion,Date recordTime, Integer type){
		CmsWorkflowRecord bean = new CmsWorkflowRecord();
		bean.setEvent(event);
		bean.setOpinion(opinion);
		bean.setRecordTime(recordTime);
		bean.setSite(site);
		bean.setType(type);
		bean.setUser(user);
		dao.save(bean);
		return bean;
	}
	
	private CmsWorkflowRecordDao dao;

	@Autowired
	public void setDao(CmsWorkflowRecordDao dao) {
		this.dao = dao;
	}
}