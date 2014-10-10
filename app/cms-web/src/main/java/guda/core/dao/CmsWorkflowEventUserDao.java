package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;
import guda.core.entity.CmsWorkflowEventUser;

public interface CmsWorkflowEventUserDao {
	public Pagination getPage(int pageNo, int pageSize);

	public CmsWorkflowEventUser findById(Integer id);

	public CmsWorkflowEventUser save(CmsWorkflowEventUser bean);

	public CmsWorkflowEventUser updateByUpdater(Updater<CmsWorkflowEventUser> updater);

	public void deleteByEvent(Integer eventId);
	
	public CmsWorkflowEventUser deleteById(Integer id);
	
}