package guda.core.entity;

import guda.core.entity.base.BaseCmsWorkflowRecord;



public class CmsWorkflowRecord extends BaseCmsWorkflowRecord {
	private static final long serialVersionUID = 1L;

/*[CONSTRUCTOR MARKER BEGIN]*/
	public CmsWorkflowRecord () {
		super();
	}

	/**
	 * Constructor for primary key
	 */
	public CmsWorkflowRecord (java.lang.Integer id) {
		super(id);
	}

	/**
	 * Constructor for required fields
	 */
	public CmsWorkflowRecord (
		java.lang.Integer id,
		guda.core.entity.CmsSite site,
		guda.core.entity.CmsWorkflowEvent event,
		guda.core.entity.CmsUser user,
		java.util.Date recordTime,
		java.lang.Integer type) {

		super (
			id,
			site,
			event,
			user,
			recordTime,
			type);
	}

/*[CONSTRUCTOR MARKER END]*/


}