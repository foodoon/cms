package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsKeyword;

import java.util.List;

public interface CmsKeywordMng {
	public List<CmsKeyword> getListBySiteId(Integer siteId,
			boolean onlyEnabled, boolean cacheable);

	public String attachKeyword(Integer siteId, String txt);

	public CmsKeyword findById(Integer id);

	public CmsKeyword save(CmsKeyword bean);

	public void updateKeywords(Integer[] ids, String[] names, String[] urls,
			Boolean[] disableds);

	public CmsKeyword deleteById(Integer id);

	public CmsKeyword[] deleteByIds(Integer[] ids);
}