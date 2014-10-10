package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsAdvertisingSpace;

import java.util.List;

public interface CmsAdvertisingSpaceMng {
	public List<CmsAdvertisingSpace> getList(Integer siteId);

	public CmsAdvertisingSpace findById(Integer id);

	public CmsAdvertisingSpace save(CmsAdvertisingSpace bean);

	public CmsAdvertisingSpace update(CmsAdvertisingSpace bean);

	public CmsAdvertisingSpace deleteById(Integer id);

	public CmsAdvertisingSpace[] deleteByIds(Integer[] ids);
}