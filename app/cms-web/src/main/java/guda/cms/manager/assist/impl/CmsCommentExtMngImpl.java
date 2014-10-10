package guda.cms.manager.assist.impl;

import guda.cms.dao.assist.CmsCommentExtDao;
import guda.cms.entity.assist.CmsComment;
import guda.cms.entity.assist.CmsCommentExt;
import guda.cms.manager.assist.CmsCommentExtMng;
import guda.common.hibernate3.Updater;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsCommentExtMngImpl implements CmsCommentExtMng {
	public CmsCommentExt save(String ip, String text, CmsComment comment) {
		CmsCommentExt ext = new CmsCommentExt();
		ext.setText(text);
		ext.setIp(ip);
		ext.setComment(comment);
		comment.setCommentExt(ext);
		dao.save(ext);
		return ext;
	}

	public CmsCommentExt update(CmsCommentExt bean) {
		Updater<CmsCommentExt> updater = new Updater<CmsCommentExt>(bean);
		bean = dao.updateByUpdater(updater);
		return bean;
	}

	public int deleteByContentId(Integer contentId) {
		return dao.deleteByContentId(contentId);
	}

	private CmsCommentExtDao dao;

	@Autowired
	public void setDao(CmsCommentExtDao dao) {
		this.dao = dao;
	}
}