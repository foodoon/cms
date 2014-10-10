package guda.core.dao.impl;

import guda.common.hibernate3.HibernateBaseDao;
import guda.core.dao.CmsConfigDao;
import guda.core.entity.CmsConfig;

import org.springframework.stereotype.Repository;

@Repository
public class CmsConfigDaoImpl extends HibernateBaseDao<CmsConfig, Integer>
		implements CmsConfigDao {
	public CmsConfig findById(Integer id) {
		CmsConfig entity = get(id);
		return entity;
	}

	@Override
	protected Class<CmsConfig> getEntityClass() {
		return CmsConfig.class;
	}
}