package guda.cms.dao.assist.impl;

import guda.cms.dao.assist.CmsGuestbookCtgDao;
import guda.cms.entity.assist.CmsGuestbookCtg;
import guda.common.hibernate3.HibernateBaseDao;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class CmsGuestbookCtgDaoImpl extends
		HibernateBaseDao<CmsGuestbookCtg, Integer> implements
		CmsGuestbookCtgDao {
	@SuppressWarnings("unchecked")
	public List<CmsGuestbookCtg> getList(Integer siteId) {
		String hql = "from CmsGuestbookCtg bean"
				+ " where bean.site.id=? order by bean.priority asc";
		return find(hql, siteId);
	}

	public CmsGuestbookCtg findById(Integer id) {
		CmsGuestbookCtg entity = get(id);
		return entity;
	}

	public CmsGuestbookCtg save(CmsGuestbookCtg bean) {
		getSession().save(bean);
		return bean;
	}

	public CmsGuestbookCtg deleteById(Integer id) {
		CmsGuestbookCtg entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<CmsGuestbookCtg> getEntityClass() {
		return CmsGuestbookCtg.class;
	}
}