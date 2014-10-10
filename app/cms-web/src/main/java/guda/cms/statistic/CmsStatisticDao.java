package guda.cms.statistic;

import guda.cms.statistic.CmsStatistic.TimeRange;

import java.util.Map;

public interface CmsStatisticDao {
	public long memberStatistic(TimeRange timeRange);

	public long contentStatistic(TimeRange timeRange,
			Map<String, Object> restrictions);

	public long commentStatistic(TimeRange timeRange,
			Map<String, Object> restrictions);

	public long guestbookStatistic(TimeRange timeRange,
			Map<String, Object> restrictions);
}
