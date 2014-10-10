package guda.cms.dao.main;

import guda.cms.entity.main.ContentType;
import guda.common.hibernate3.Updater;

import java.util.List;

public interface ContentTypeDao {
	public List<ContentType> getList(boolean containDisabled);

	public ContentType getDef();

	public ContentType findById(Integer id);

	public ContentType save(ContentType bean);

	public ContentType updateByUpdater(Updater<ContentType> updater);

	public ContentType deleteById(Integer id);
}