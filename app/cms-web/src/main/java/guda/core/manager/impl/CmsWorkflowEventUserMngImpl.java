package guda.core.manager.impl;

import guda.core.dao.CmsWorkflowEventUserDao;
import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflowEvent;
import guda.core.entity.CmsWorkflowEventUser;
import guda.core.manager.CmsWorkflowEventUserMng;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsWorkflowEventUserMngImpl implements CmsWorkflowEventUserMng {
	public Set<CmsWorkflowEventUser> save(CmsWorkflowEvent event,Set<CmsUser>users){
		Set<CmsWorkflowEventUser>eventUsers=new HashSet<CmsWorkflowEventUser>();
		event.setUsers(eventUsers);
		if (users != null) {
			CmsWorkflowEventUser eventUser;
			for (CmsUser user : users) {
				eventUser = new CmsWorkflowEventUser(event, user);
				dao.save(eventUser);
				eventUsers.add(eventUser);
			}
		}
		return eventUsers;
	}

	public Set<CmsWorkflowEventUser> update(CmsWorkflowEvent event,Set<CmsUser>users){
		deleteByEvent(event.getId());
		return save(event, users);
	}
	
	public void deleteByEvent(Integer eventId){
		 dao.deleteByEvent(eventId);
	}

	private CmsWorkflowEventUserDao dao;

	@Autowired
	public void setDao(CmsWorkflowEventUserDao dao) {
		this.dao = dao;
	}
}