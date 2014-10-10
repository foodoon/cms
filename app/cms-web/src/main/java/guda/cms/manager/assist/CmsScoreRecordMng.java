package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsScoreRecord;
import guda.common.page.Pagination;

import java.util.Map;

public interface CmsScoreRecordMng {
	public Pagination getPage(int pageNo, int pageSize);
	
	public Map<String,String> viewContent(Integer contentId);

	public int contentScore(Integer contentId,Integer itemId);
	
	public CmsScoreRecord findByScoreItemContent(Integer itemId,Integer contentId);

	public CmsScoreRecord findById(Integer id);

	public CmsScoreRecord save(CmsScoreRecord bean);

	public CmsScoreRecord update(CmsScoreRecord bean);

	public CmsScoreRecord deleteById(Integer id);
	
	public CmsScoreRecord[] deleteByIds(Integer[] ids);
}