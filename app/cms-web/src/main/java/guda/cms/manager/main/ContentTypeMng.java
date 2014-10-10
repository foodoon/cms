package guda.cms.manager.main;

import guda.cms.entity.main.ContentType;

import java.util.List;

public interface ContentTypeMng {
	public List<ContentType> getList(boolean containDisabled);

	public ContentType getDef();

	public ContentType findById(Integer id);

	public ContentType save(ContentType bean);

	public ContentType update(ContentType bean);

	public ContentType deleteById(Integer id);

	public ContentType[] deleteByIds(Integer[] ids);
}