package guda.core.manager;

import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflow;
import guda.core.entity.CmsWorkflowEvent;

import java.util.List;
import java.util.Set;

public interface CmsWorkflowEventMng {

	public List<CmsWorkflowEvent> getListByWorkFlowId(Integer workflowId);
	
	public List<CmsWorkflowEvent> getListByUserId(Integer userId);
	
	public CmsWorkflowEvent findById(Integer id);

	public CmsWorkflowEvent find(Integer dataTypeId, Integer dataId);
	
	public CmsWorkflowEvent end(Integer eventId);

	public CmsWorkflowEvent save(CmsWorkflow workflow, CmsUser initiator,
			Set<CmsUser> nextUsers, Integer dateTypeId, Integer dateId,
			Integer step,Boolean hasFinish);

	public CmsWorkflowEvent deleteById(Integer id);
	
	public CmsWorkflowEvent[] deleteByIds(Integer[] ids);
	
	public void deleteByDate(Integer dataTypeId,Integer dataId);
	
}