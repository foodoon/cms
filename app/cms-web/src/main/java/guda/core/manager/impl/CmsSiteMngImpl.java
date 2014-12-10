package guda.core.manager.impl;

import guda.cms.manager.assist.CmsResourceMng;
import guda.common.hibernate3.Updater;
import guda.core.dao.CmsSiteDao;
import guda.core.entity.CmsSite;
import guda.core.entity.CmsSiteCompany;
import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflow;
import guda.core.manager.CmsSiteCompanyMng;
import guda.core.manager.CmsSiteMng;
import guda.core.manager.CmsUserMng;
import guda.core.manager.CmsUserSiteMng;
import guda.core.manager.CmsWorkflowMng;
import guda.core.manager.FtpMng;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsSiteMngImpl implements CmsSiteMng {
	private static final Logger log = LoggerFactory.getLogger(CmsSiteMngImpl.class);

	@Transactional(readOnly = true)
	public List<CmsSite> getList() {
		return dao.getList(false);
	}
	
	@Transactional(readOnly = true)
	public List<CmsSite> getListFromCache() {
		return dao.getList(true);
	}
	
	@Transactional(readOnly = true)
	public List<CmsSite> getListByMaster(Boolean master) {
		return dao.getListByMaster(master);
	}
	
	@Transactional(readOnly = true)
	public List<CmsSite> getListByParent(Integer parentId){
		return dao.getListByParent(parentId);
	}
	
	@Transactional(readOnly = true)
	public boolean hasRepeatByProperty(String property){
		return (getList().size()-dao.getCountByProperty(property))>0?true:false;
	}
	
	@Transactional(readOnly = true)
	public List<CmsSite> getTopList(){
		return dao.getTopList();
	}

	@Transactional(readOnly = true)
	public CmsSite findByDomain(String domain) {
		return dao.findByDomain(domain);
	}
	
	@Transactional(readOnly = true)
	public CmsSite findByAccessPath(String accessPath){
		return dao.findByAccessPath(accessPath);
	}

	@Transactional(readOnly = true)
	public CmsSite findById(Integer id) {
		CmsSite entity = dao.findById(id);
		return entity;
	}
	
	public CmsSite save(CmsSite currSite, CmsUser currUser, CmsSite bean,
			Integer uploadFtpId) throws IOException {
		if (uploadFtpId != null) {
			bean.setUploadFtp(ftpMng.findById(uploadFtpId));
		}
		bean.init();
		dao.save(bean);
		// 复制本站模板
		cmsResourceMng.copyTplAndRes(currSite, bean);
		// 处理管理员
		cmsUserMng.addSiteToUser(currUser, bean, bean.getFinalStep());
		//保存站点相关公司信息
		CmsSiteCompany company=new CmsSiteCompany();
		company.setName(bean.getName());
		siteCompanyMng.save(bean,company);
		return bean;
	}

	public CmsSite update(CmsSite bean, Integer uploadFtpId) {
		CmsSite entity = findById(bean.getId());
		if (uploadFtpId != null) {
			entity.setUploadFtp(ftpMng.findById(uploadFtpId));
		} else {
			entity.setUploadFtp(null);
		}
		Updater<CmsSite> updater = new Updater<CmsSite>(bean);
		entity = dao.updateByUpdater(updater);
		return entity;
	}

	public void updateTplSolution(Integer siteId, String solution) {
		CmsSite site = findById(siteId);
		site.setTplSolution(solution);
	}
	
	public void updateRefers(Integer siteId, Integer[] referIds){
		CmsSite site = findById(siteId);
		Set<CmsSite>refers=site.getRefers();
		refers.clear();
		for(Integer referId:referIds){
			refers.add(findById(referId));
		}
		site.setRefers(refers);
	}
	
	public void updateAttr(Integer siteId,Map<String,String>attr){
		CmsSite site = findById(siteId);
		site.getAttr().putAll(attr);
	}

	public CmsSite deleteById(Integer id) {
		// 删除用户、站点关联
		cmsUserSiteMng.deleteBySiteId(id);
		// 删除工作流相关
		List<CmsWorkflow>workflows=workflowMng.getList(id, null);
		for(CmsWorkflow workflow:workflows){
			workflowMng.deleteById(workflow.getId());
		}
		CmsSite bean = dao.findById(id);
		bean.getRefers().clear();
		bean.getToRefers().clear();
		dao.deleteById(id);
		log.info("delete site "+id);
		// 删除模板
		/*
		try {
			cmsResourceMng.delTplAndRes(bean);
		} catch (IOException e) {
			log.error("delete Template and Resource fail!", e);
		}
		*/
		return bean;
	}

	public CmsSite[] deleteByIds(Integer[] ids) {
		CmsSite[] beans = new CmsSite[ids.length];
		for (int i = 0, len = ids.length; i < len; i++) {
			beans[i] = deleteById(ids[i]);
		}
		return beans;
	}

	private CmsUserMng cmsUserMng;
	private CmsUserSiteMng cmsUserSiteMng;
	private CmsResourceMng cmsResourceMng;
	private FtpMng ftpMng;
	private CmsSiteDao dao;
	@Autowired
	private CmsSiteCompanyMng siteCompanyMng;
	@Autowired
	private CmsWorkflowMng workflowMng;

	@Autowired
	public void setCmsUserMng(CmsUserMng cmsUserMng) {
		this.cmsUserMng = cmsUserMng;
	}

	@Autowired
	public void setCmsUserSiteMng(CmsUserSiteMng cmsUserSiteMng) {
		this.cmsUserSiteMng = cmsUserSiteMng;
	}

	@Autowired
	public void setCmsResourceMng(CmsResourceMng cmsResourceMng) {
		this.cmsResourceMng = cmsResourceMng;
	}

	@Autowired
	public void setFtpMng(FtpMng ftpMng) {
		this.ftpMng = ftpMng;
	}

	@Autowired
	public void setDao(CmsSiteDao dao) {
		this.dao = dao;
	}

}