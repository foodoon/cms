package guda.cms.statistic.workload;

import guda.cms.statistic.workload.CmsWorkLoadStatistic.CmsWorkLoadStatisticDateKind;

import java.util.Date;

public interface CmsWorkLoadStatisticDao {
	public Long  statistic(Integer channelId,
			Integer reviewerId, Integer authorId, Date beginDate, Date endDate,CmsWorkLoadStatisticDateKind dateKind);
}
