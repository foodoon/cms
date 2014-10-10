package guda.cms.manager.main;

import guda.cms.entity.main.Content;
import guda.cms.entity.main.ContentExt;

public interface ContentExtMng {
	public ContentExt save(ContentExt ext, Content content);

	public ContentExt update(ContentExt ext);
}