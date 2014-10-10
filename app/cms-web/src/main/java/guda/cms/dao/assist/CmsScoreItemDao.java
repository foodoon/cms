package guda.cms.dao.assist;

import guda.cms.entity.assist.CmsScoreItem;
import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;

public interface CmsScoreItemDao {
	public Pagination getPage(Integer groupId,int pageNo, int pageSize);

	public CmsScoreItem findById(Integer id);

	public CmsScoreItem save(CmsScoreItem bean);

	public CmsScoreItem updateByUpdater(Updater<CmsScoreItem> updater);

	public CmsScoreItem deleteById(Integer id);
}