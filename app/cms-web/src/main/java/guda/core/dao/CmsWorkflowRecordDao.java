package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;
import guda.core.entity.CmsWorkflowRecord;

import java.util.List;

public interface CmsWorkflowRecordDao {
	public List<CmsWorkflowRecord> getList(Integer eventId,Integer userId);
	
	public Pagination getPage(int pageNo, int pageSize);

	public CmsWorkflowRecord findById(Integer id);

	public CmsWorkflowRecord save(CmsWorkflowRecord bean);

	public CmsWorkflowRecord updateByUpdater(Updater<CmsWorkflowRecord> updater);

	public CmsWorkflowRecord deleteById(Integer id);
}