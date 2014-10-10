package guda.cms.statistic;

import guda.cms.statistic.CmsStatistic.CmsStatisticModel;

import java.util.List;
import java.util.Map;

public interface CmsStatisticSvc {
	public List<CmsStatistic> statisticByModel(int type,
			CmsStatisticModel statisticModel, Integer year, Integer month,
			Integer day, Map<String, Object> restrictions);
}
