package guda.cms.statistic.workload;

import guda.cms.statistic.workload.CmsWorkLoadStatistic.CmsWorkLoadStatisticDateKind;
import guda.cms.statistic.workload.CmsWorkLoadStatistic.CmsWorkLoadStatisticGroup;

import java.util.Date;
import java.util.List;

public interface CmsWorkLoadStatisticSvc {
	public List<CmsWorkLoadStatistic> statistic(Integer channelId,
			Integer reviewerId, Integer authorId, Date beginDate, Date endDate,
			CmsWorkLoadStatisticGroup group,CmsWorkLoadStatisticDateKind kind);
}
