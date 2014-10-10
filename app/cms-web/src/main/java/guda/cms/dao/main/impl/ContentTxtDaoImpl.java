package guda.cms.dao.main.impl;

import guda.cms.dao.main.ContentTxtDao;
import guda.cms.entity.main.ContentTxt;
import guda.common.hibernate3.HibernateBaseDao;

import org.springframework.stereotype.Repository;

@Repository
public class ContentTxtDaoImpl extends HibernateBaseDao<ContentTxt, Integer>
		implements ContentTxtDao {
	public ContentTxt findById(Integer id) {
		ContentTxt entity = get(id);
		return entity;
	}

	public ContentTxt save(ContentTxt bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	protected Class<ContentTxt> getEntityClass() {
		return ContentTxt.class;
	}
}