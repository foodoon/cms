package guda.cms.manager.assist.impl;

import guda.cms.dao.assist.CmsSiteAccessStatisticDao;
import guda.cms.entity.assist.CmsSiteAccessStatistic;
import guda.cms.manager.assist.CmsSiteAccessStatisticMng;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Tom
 */
@Service
@Transactional
public class CmsSiteAccessStatisticMngImpl implements CmsSiteAccessStatisticMng {

	public CmsSiteAccessStatistic save(CmsSiteAccessStatistic statistic) {
		return dao.save(statistic);
	}

	public List<Object[]> statistic(Date begin, Date end,Integer siteId, String statisticType,String statisticValue) {
		return dao.statistic(begin, end, siteId, statisticType,statisticValue);
	}
	
	public List<Object[]> statisticTotal(Date begin, Date end,Integer siteId, String statisticType,String statisticValue,Integer orderBy){
		return dao.statisticTotal(begin, end, siteId, statisticType, statisticValue, orderBy);
	}
	
	public List<Object[]> statisticByTarget(Date begin, Date end,Integer siteId,Integer target, String statisticType,String statisticValue){
		return dao.statisticByTarget(begin, end, siteId, target, statisticType, statisticValue);
	}
	
	public List<String> findStatisticColumnValues(Date begin, Date end,Integer siteId, String statisticType){
		return dao.findStatisticColumnValues(begin, end, siteId, statisticType);
	}
	
	public List<Object[]> statisticByYear(Integer year,Integer siteId, String statisticType,String statisticValue,boolean groupByMonth,Integer orderBy){
		return dao.statisticByYear(year,siteId,statisticType,statisticValue,groupByMonth,orderBy);
	}
	
	public List<Object[]> statisticByYearByTarget(Integer year,Integer siteId, Integer target,String statisticType,String statisticValue){
		return dao.statisticByYearByTarget(year, siteId, target, statisticType, statisticValue);
	}

	@Autowired
	private CmsSiteAccessStatisticDao dao;
}
