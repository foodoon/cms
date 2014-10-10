package guda.core.dao.impl;

import guda.common.hibernate3.HibernateBaseDao;
import guda.core.dao.CmsGroupDao;
import guda.core.entity.CmsGroup;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class CmsGroupDaoImpl extends HibernateBaseDao<CmsGroup, Integer>
		implements CmsGroupDao {
	@SuppressWarnings("unchecked")
	public List<CmsGroup> getList() {
		String hql = "from CmsGroup bean order by bean.priority asc,bean.id asc";
		return find(hql);
	}

	public CmsGroup getRegDef() {
		String hql = "from CmsGroup bean where bean.regDef=true";
		return (CmsGroup) findUnique(hql);
	}

	public CmsGroup findById(Integer id) {
		CmsGroup entity = get(id);
		return entity;
	}

	public CmsGroup save(CmsGroup bean) {
		getSession().save(bean);
		return bean;
	}

	public CmsGroup deleteById(Integer id) {
		CmsGroup entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<CmsGroup> getEntityClass() {
		return CmsGroup.class;
	}
}