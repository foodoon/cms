package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsAcquisitionTemp;

import java.util.List;

public interface CmsAcquisitionTempMng {
	public List<CmsAcquisitionTemp> getList(Integer siteId);

	public CmsAcquisitionTemp findById(Integer id);

	public CmsAcquisitionTemp save(CmsAcquisitionTemp bean);

	public CmsAcquisitionTemp update(CmsAcquisitionTemp bean);

	public CmsAcquisitionTemp deleteById(Integer id);

	public CmsAcquisitionTemp[] deleteByIds(Integer[] ids);
	
	public Integer getPercent(Integer siteId);
	
	public void clear(Integer siteId);
	
	public void clear(Integer siteId, String channelUrl);
}