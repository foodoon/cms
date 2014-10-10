package guda.core.dao.impl;

import guda.common.hibernate3.Finder;
import guda.common.hibernate3.HibernateBaseDao;
import guda.common.page.Pagination;
import guda.core.dao.CmsWorkflowRecordDao;
import guda.core.entity.CmsWorkflowRecord;

import java.util.List;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;

@Repository
public class CmsWorkflowRecordDaoImpl extends HibernateBaseDao<CmsWorkflowRecord, Integer> implements CmsWorkflowRecordDao {
	@SuppressWarnings("unchecked")
	public List<CmsWorkflowRecord> getList(Integer eventId,Integer userId){
		Finder f=Finder.create("from CmsWorkflowRecord bean where 1=1 ");
		if(eventId!=null){
			f.append(" and bean.event.id=:eventId").setParam("eventId", eventId);
		}
		if(userId!=null){
			f.append(" and bean.user.id=:userId").setParam("userId", userId);
		}
		f.append(" order by bean.recordTime desc,bean.id desc");
		return find(f);
	}
	public Pagination getPage(int pageNo, int pageSize) {
		Criteria crit = createCriteria();
		Pagination page = findByCriteria(crit, pageNo, pageSize);
		return page;
	}

	public CmsWorkflowRecord findById(Integer id) {
		CmsWorkflowRecord entity = get(id);
		return entity;
	}

	public CmsWorkflowRecord save(CmsWorkflowRecord bean) {
		getSession().save(bean);
		return bean;
	}

	public CmsWorkflowRecord deleteById(Integer id) {
		CmsWorkflowRecord entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}
	
	@Override
	protected Class<CmsWorkflowRecord> getEntityClass() {
		return CmsWorkflowRecord.class;
	}
}