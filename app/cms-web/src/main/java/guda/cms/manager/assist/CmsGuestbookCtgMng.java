package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsGuestbookCtg;

import java.util.List;

public interface CmsGuestbookCtgMng {
	public List<CmsGuestbookCtg> getList(Integer siteId);

	public CmsGuestbookCtg findById(Integer id);

	public CmsGuestbookCtg save(CmsGuestbookCtg bean);

	public CmsGuestbookCtg update(CmsGuestbookCtg bean);

	public CmsGuestbookCtg deleteById(Integer id);

	public CmsGuestbookCtg[] deleteByIds(Integer[] ids);
}