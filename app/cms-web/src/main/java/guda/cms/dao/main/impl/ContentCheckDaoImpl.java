package guda.cms.dao.main.impl;

import guda.cms.dao.main.ContentCheckDao;
import guda.cms.entity.main.ContentCheck;
import guda.common.hibernate3.HibernateBaseDao;

import org.springframework.stereotype.Repository;

@Repository
public class ContentCheckDaoImpl extends HibernateBaseDao<ContentCheck, Long>
		implements ContentCheckDao {
	public ContentCheck findById(Long id) {
		ContentCheck entity = get(id);
		return entity;
	}

	public ContentCheck save(ContentCheck bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	protected Class<ContentCheck> getEntityClass() {
		return ContentCheck.class;
	}
}