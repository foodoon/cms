package guda.core.dao.impl;

import guda.common.hibernate3.HibernateBaseDao;
import guda.core.dao.CmsUserExtDao;
import guda.core.entity.CmsUserExt;

import org.springframework.stereotype.Repository;

@Repository
public class CmsUserExtDaoImpl extends HibernateBaseDao<CmsUserExt, Integer> implements CmsUserExtDao {
	public CmsUserExt findById(Integer id) {
		CmsUserExt entity = get(id);
		return entity;
	}

	public CmsUserExt save(CmsUserExt bean) {
		getSession().save(bean);
		return bean;
	}
	
	@Override
	protected Class<CmsUserExt> getEntityClass() {
		return CmsUserExt.class;
	}
}