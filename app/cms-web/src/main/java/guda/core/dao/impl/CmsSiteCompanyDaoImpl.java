package guda.core.dao.impl;

import guda.common.hibernate3.HibernateBaseDao;
import guda.core.dao.CmsSiteCompanyDao;
import guda.core.entity.CmsSiteCompany;

import org.springframework.stereotype.Repository;

@Repository
public class CmsSiteCompanyDaoImpl extends
		HibernateBaseDao<CmsSiteCompany, Integer> implements CmsSiteCompanyDao {

	public CmsSiteCompany save(CmsSiteCompany bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	protected Class<CmsSiteCompany> getEntityClass() {
		return CmsSiteCompany.class;
	}
}