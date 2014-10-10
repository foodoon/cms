package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;
import guda.core.entity.CmsWorkflow;

import java.util.List;

public interface CmsWorkflowDao {
	public Pagination getPage(Integer siteId,int pageNo, int pageSize);
	
	public List<CmsWorkflow> getList(Integer siteId,Boolean disabled);

	public CmsWorkflow findById(Integer id);

	public CmsWorkflow save(CmsWorkflow bean);

	public CmsWorkflow updateByUpdater(Updater<CmsWorkflow> updater);

	public CmsWorkflow deleteById(Integer id);
}