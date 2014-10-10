package guda.cms.dao.main;

import guda.cms.entity.main.ContentDoc;
import guda.common.hibernate3.Updater;

public interface ContentDocDao {
	public ContentDoc findById(Integer id);

	public ContentDoc save(ContentDoc bean);

	public ContentDoc updateByUpdater(Updater<ContentDoc> updater);
}