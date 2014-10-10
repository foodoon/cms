package guda.cms.manager.main;

import guda.cms.entity.main.Content;
import guda.cms.entity.main.ContentDoc;
import guda.core.entity.CmsUser;
public interface ContentDocMng {
	public ContentDoc save(ContentDoc doc, Content content);

	public ContentDoc update(ContentDoc doc, Content content);
	
	public ContentDoc operateDocGrain(CmsUser downUser, ContentDoc doc);
	
	public ContentDoc createSwfFile(ContentDoc doc);
}