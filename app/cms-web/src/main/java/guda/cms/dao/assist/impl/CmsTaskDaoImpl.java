package guda.cms.dao.assist.impl;

import guda.cms.dao.assist.CmsTaskDao;
import guda.cms.entity.assist.CmsTask;
import guda.common.hibernate3.Finder;
import guda.common.hibernate3.HibernateBaseDao;
import guda.common.page.Pagination;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class CmsTaskDaoImpl extends HibernateBaseDao<CmsTask, Integer> implements CmsTaskDao {
	public Pagination getPage(Integer siteId,int pageNo, int pageSize) {
		Finder f=Finder.create("from CmsTask task where task.site.id=:siteId").setParam("siteId", siteId);
		Pagination page = find(f, pageNo, pageSize);
		return page;
	}
	
	@SuppressWarnings("unchecked")
	public List<CmsTask> getList(){
		Finder f=Finder.create("from CmsTask");
		return find(f);
	}

	public CmsTask findById(Integer id) {
		CmsTask entity = get(id);
		return entity;
	}

	public CmsTask save(CmsTask bean) {
		getSession().save(bean);
		return bean;
	}

	public CmsTask deleteById(Integer id) {
		CmsTask entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}
	
	@Override
	protected Class<CmsTask> getEntityClass() {
		return CmsTask.class;
	}
}