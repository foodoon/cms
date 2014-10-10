package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;
import guda.core.entity.CmsWorkflowEvent;

import java.util.List;

public interface CmsWorkflowEventDao {
	
	public List<CmsWorkflowEvent> getListByWorkFlowId(Integer workflowId);
	
	public List<CmsWorkflowEvent> getListByUserId(Integer userId);
	
	public Pagination getPage(int pageNo, int pageSize);

	public CmsWorkflowEvent findById(Integer id);
	
	public List<CmsWorkflowEvent> find(Integer dataTypeId, Integer dataId);

	public CmsWorkflowEvent save(CmsWorkflowEvent bean);

	public CmsWorkflowEvent updateByUpdater(Updater<CmsWorkflowEvent> updater);

	public CmsWorkflowEvent deleteById(Integer id);

}