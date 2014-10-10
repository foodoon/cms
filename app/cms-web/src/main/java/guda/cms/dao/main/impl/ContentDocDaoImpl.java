package guda.cms.dao.main.impl;

import guda.cms.dao.main.ContentDocDao;
import guda.cms.entity.main.ContentDoc;
import guda.common.hibernate3.HibernateBaseDao;

import org.springframework.stereotype.Repository;

@Repository
public class ContentDocDaoImpl extends HibernateBaseDao<ContentDoc, Integer>
		implements ContentDocDao {
	public ContentDoc findById(Integer id) {
		ContentDoc entity = get(id);
		return entity;
	}

	public ContentDoc save(ContentDoc bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	protected Class<ContentDoc> getEntityClass() {
		return ContentDoc.class;
	}
}