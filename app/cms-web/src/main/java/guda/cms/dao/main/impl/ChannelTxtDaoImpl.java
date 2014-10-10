package guda.cms.dao.main.impl;

import guda.cms.dao.main.ChannelTxtDao;
import guda.cms.entity.main.ChannelTxt;
import guda.common.hibernate3.HibernateBaseDao;

import org.springframework.stereotype.Repository;

@Repository
public class ChannelTxtDaoImpl extends HibernateBaseDao<ChannelTxt, Integer>
		implements ChannelTxtDao {
	public ChannelTxt findById(Integer id) {
		ChannelTxt entity = get(id);
		return entity;
	}

	public ChannelTxt save(ChannelTxt bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	protected Class<ChannelTxt> getEntityClass() {
		return ChannelTxt.class;
	}
}