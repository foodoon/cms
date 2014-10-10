package guda.cms.dao.main;

import guda.cms.entity.main.ContentShareCheck;
import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;

import java.util.List;

public interface ContentShareCheckDao {
	public ContentShareCheck findById(Integer id);

	public ContentShareCheck save(ContentShareCheck bean);

	public ContentShareCheck updateByUpdater(Updater<ContentShareCheck> updater);
	
	public ContentShareCheck update(ContentShareCheck bean);
	
	public ContentShareCheck deleteById(Integer id);
	
	public ContentShareCheck[] deleteByIds(Integer[] ids);

	public List<ContentShareCheck> getList(Integer contentId, Integer channelId);
	
	public Pagination getPageForShared(String title, Byte status, Integer siteId,Integer targetSiteId, Integer requestSiteId, int pageNo, int pageSize);
	
	
}