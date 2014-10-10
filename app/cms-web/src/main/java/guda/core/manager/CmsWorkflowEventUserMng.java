package guda.core.manager;

import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflowEvent;
import guda.core.entity.CmsWorkflowEventUser;

import java.util.Set;

public interface CmsWorkflowEventUserMng {
	
	public Set<CmsWorkflowEventUser> save(CmsWorkflowEvent event,Set<CmsUser>users);

	public Set<CmsWorkflowEventUser> update(CmsWorkflowEvent event,Set<CmsUser>users);
	
	public void deleteByEvent(Integer eventId);

}