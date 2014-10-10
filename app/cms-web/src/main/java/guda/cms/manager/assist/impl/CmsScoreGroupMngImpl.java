package guda.cms.manager.assist.impl;

import guda.cms.dao.assist.CmsScoreGroupDao;
import guda.cms.entity.assist.CmsScoreGroup;
import guda.cms.manager.assist.CmsScoreGroupMng;
import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsScoreGroupMngImpl implements CmsScoreGroupMng {
	@Transactional(readOnly = true)
	public Pagination getPage(int pageNo, int pageSize) {
		Pagination page = dao.getPage(pageNo, pageSize);
		return page;
	}

	@Transactional(readOnly = true)
	public CmsScoreGroup findById(Integer id) {
		CmsScoreGroup entity = dao.findById(id);
		return entity;
	}
	
	@Transactional(readOnly = true)
	public CmsScoreGroup findDefault(Integer siteId){
		return dao.findDefault(siteId);
	}

	public CmsScoreGroup save(CmsScoreGroup bean) {
		dao.save(bean);
		return bean;
	}

	public CmsScoreGroup update(CmsScoreGroup bean) {
		Updater<CmsScoreGroup> updater = new Updater<CmsScoreGroup>(bean);
		bean = dao.updateByUpdater(updater);
		return bean;
	}

	public CmsScoreGroup deleteById(Integer id) {
		CmsScoreGroup bean = dao.deleteById(id);
		return bean;
	}
	
	public CmsScoreGroup[] deleteByIds(Integer[] ids) {
		CmsScoreGroup[] beans = new CmsScoreGroup[ids.length];
		for (int i = 0,len = ids.length; i < len; i++) {
			beans[i] = deleteById(ids[i]);
		}
		return beans;
	}

	private CmsScoreGroupDao dao;

	@Autowired
	public void setDao(CmsScoreGroupDao dao) {
		this.dao = dao;
	}
}