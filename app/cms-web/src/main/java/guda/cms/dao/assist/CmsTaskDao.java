package guda.cms.dao.assist;

import guda.cms.entity.assist.CmsTask;
import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;

import java.util.List;

public interface CmsTaskDao {
	public Pagination getPage(Integer siteId,int pageNo, int pageSize);
	
	public List<CmsTask> getList();

	public CmsTask findById(Integer id);

	public CmsTask save(CmsTask bean);

	public CmsTask updateByUpdater(Updater<CmsTask> updater);

	public CmsTask deleteById(Integer id);
}