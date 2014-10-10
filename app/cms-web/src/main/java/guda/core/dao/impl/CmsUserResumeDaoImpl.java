package guda.core.dao.impl;

import guda.common.hibernate3.HibernateBaseDao;
import guda.core.dao.CmsUserResumeDao;
import guda.core.entity.CmsUserResume;

import org.springframework.stereotype.Repository;

@Repository
public class CmsUserResumeDaoImpl extends HibernateBaseDao<CmsUserResume, Integer> implements CmsUserResumeDao {
	public CmsUserResume findById(Integer id) {
		CmsUserResume entity = get(id);
		return entity;
	}

	public CmsUserResume save(CmsUserResume bean) {
		getSession().save(bean);
		return bean;
	}
	
	@Override
	protected Class<CmsUserResume> getEntityClass() {
		return CmsUserResume.class;
	}
}