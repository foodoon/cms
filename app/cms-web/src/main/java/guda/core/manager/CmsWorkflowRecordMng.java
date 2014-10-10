package guda.core.manager;

import guda.core.entity.CmsSite;
import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflowEvent;
import guda.core.entity.CmsWorkflowRecord;

import java.util.Date;
import java.util.List;

public interface CmsWorkflowRecordMng {
	
	public List<CmsWorkflowRecord> getList(Integer eventId,Integer userId);

	public CmsWorkflowRecord save(CmsSite site, CmsWorkflowEvent event,
			CmsUser user, String opinion,Date recordTime, Integer type);

}