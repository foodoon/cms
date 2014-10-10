package guda.cms.manager.assist.impl;

import guda.cms.dao.assist.CmsAdvertisingSpaceDao;
import guda.cms.entity.assist.CmsAdvertisingSpace;
import guda.cms.manager.assist.CmsAdvertisingSpaceMng;
import guda.common.hibernate3.Updater;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsAdvertisingSpaceMngImpl implements CmsAdvertisingSpaceMng {
	@Transactional(readOnly = true)
	public List<CmsAdvertisingSpace> getList(Integer siteId) {
		return dao.getList(siteId);
	}

	@Transactional(readOnly = true)
	public CmsAdvertisingSpace findById(Integer id) {
		CmsAdvertisingSpace entity = dao.findById(id);
		return entity;
	}

	public CmsAdvertisingSpace save(CmsAdvertisingSpace bean) {
		dao.save(bean);
		return bean;
	}

	public CmsAdvertisingSpace update(CmsAdvertisingSpace bean) {
		Updater<CmsAdvertisingSpace> updater = new Updater<CmsAdvertisingSpace>(
				bean);
		bean = dao.updateByUpdater(updater);
		return bean;
	}

	public CmsAdvertisingSpace deleteById(Integer id) {
		CmsAdvertisingSpace bean = dao.deleteById(id);
		return bean;
	}

	public CmsAdvertisingSpace[] deleteByIds(Integer[] ids) {
		CmsAdvertisingSpace[] beans = new CmsAdvertisingSpace[ids.length];
		for (int i = 0, len = ids.length; i < len; i++) {
			beans[i] = deleteById(ids[i]);
		}
		return beans;
	}

	private CmsAdvertisingSpaceDao dao;

	@Autowired
	public void setDao(CmsAdvertisingSpaceDao dao) {
		this.dao = dao;
	}
}