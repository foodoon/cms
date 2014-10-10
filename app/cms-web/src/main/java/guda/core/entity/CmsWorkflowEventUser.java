package guda.core.entity;

import guda.core.entity.base.BaseCmsWorkflowEventUser;



public class CmsWorkflowEventUser extends BaseCmsWorkflowEventUser {
	private static final long serialVersionUID = 1L;

	public CmsWorkflowEventUser(CmsWorkflowEvent event, CmsUser user) {
		super(event, user);
	}
	
	

/*[CONSTRUCTOR MARKER BEGIN]*/
	public CmsWorkflowEventUser () {
		super();
	}

	/**
	 * Constructor for primary key
	 */
	public CmsWorkflowEventUser (java.lang.Integer id) {
		super(id);
	}

	/**
	 * Constructor for required fields
	 */
	public CmsWorkflowEventUser (
		java.lang.Integer id,
		guda.core.entity.CmsWorkflowEvent event,
		guda.core.entity.CmsUser user) {

		super (
			id,
			event,
			user);
	}


/*[CONSTRUCTOR MARKER END]*/


}