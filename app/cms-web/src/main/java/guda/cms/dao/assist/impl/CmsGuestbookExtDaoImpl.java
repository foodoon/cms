package guda.cms.dao.assist.impl;

import guda.cms.dao.assist.CmsGuestbookExtDao;
import guda.cms.entity.assist.CmsGuestbookExt;
import guda.common.hibernate3.HibernateBaseDao;

import org.springframework.stereotype.Repository;

@Repository
public class CmsGuestbookExtDaoImpl extends
		HibernateBaseDao<CmsGuestbookExt, Integer> implements
		CmsGuestbookExtDao {

	public CmsGuestbookExt findById(Integer id) {
		CmsGuestbookExt entity = get(id);
		return entity;
	}

	public CmsGuestbookExt save(CmsGuestbookExt bean) {
		getSession().save(bean);
		return bean;
	}

	public CmsGuestbookExt deleteById(Integer id) {
		CmsGuestbookExt entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<CmsGuestbookExt> getEntityClass() {
		return CmsGuestbookExt.class;
	}
}