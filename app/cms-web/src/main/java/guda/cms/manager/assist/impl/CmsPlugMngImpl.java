package guda.cms.manager.assist.impl;

import guda.cms.dao.assist.CmsPlugDao;
import guda.cms.entity.assist.CmsPlug;
import guda.cms.manager.assist.CmsPlugMng;
import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsPlugMngImpl implements CmsPlugMng {
	@Transactional(readOnly = true)
	public Pagination getPage(int pageNo, int pageSize) {
		Pagination page = dao.getPage(pageNo, pageSize);
		return page;
	}
	
	public List<CmsPlug> getList(String author,Boolean used){
		return dao.getList(author,used);
	}

	@Transactional(readOnly = true)
	public CmsPlug findById(Integer id) {
		CmsPlug entity = dao.findById(id);
		return entity;
	}
	
	@Transactional(readOnly = true)
	public CmsPlug findByPath(String plugPath){
		return dao.findByPath(plugPath);
	}

	public CmsPlug save(CmsPlug bean) {
		dao.save(bean);
		return bean;
	}

	public CmsPlug update(CmsPlug bean) {
		Updater<CmsPlug> updater = new Updater<CmsPlug>(bean);
		bean = dao.updateByUpdater(updater);
		return bean;
	}

	public CmsPlug deleteById(Integer id) {
		CmsPlug bean = dao.deleteById(id);
		return bean;
	}
	
	public CmsPlug[] deleteByIds(Integer[] ids) {
		CmsPlug[] beans = new CmsPlug[ids.length];
		for (int i = 0,len = ids.length; i < len; i++) {
			beans[i] = deleteById(ids[i]);
		}
		return beans;
	}

	private CmsPlugDao dao;

	@Autowired
	public void setDao(CmsPlugDao dao) {
		this.dao = dao;
	}
}