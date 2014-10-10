package guda.core.entity.base;

import guda.core.entity.CmsUser;
import guda.core.entity.CmsWorkflowEvent;

import java.io.Serializable;


/**
 * This is an object that contains data related to the jc_workflow_event_user table.
 * Do not modify this class because it will be overwritten if the configuration file
 * related to this class is modified.
 *
 * @hibernate.class
 *  table="jc_workflow_event_user"
 */

public abstract class BaseCmsWorkflowEventUser  implements Serializable {

	public static String REF = "CmsWorkflowEventUser";
	public static String PROP_USER = "user";
	public static String PROP_EVENT = "event";
	public static String PROP_ID = "id";


	// constructors
	public BaseCmsWorkflowEventUser () {
		initialize();
	}

	/**
	 * Constructor for primary key
	 */
	public BaseCmsWorkflowEventUser (java.lang.Integer id) {
		this.setId(id);
		initialize();
	}

	/**
	 * Constructor for required fields
	 */
	public BaseCmsWorkflowEventUser (
		java.lang.Integer id,
		guda.core.entity.CmsWorkflowEvent event,
		guda.core.entity.CmsUser user) {

		this.setId(id);
		this.setEvent(event);
		this.setUser(user);
		initialize();
	}

	public BaseCmsWorkflowEventUser(CmsWorkflowEvent event, CmsUser user) {
		super();
		this.event = event;
		this.user = user;
	}

	protected void initialize () {}



	private int hashCode = Integer.MIN_VALUE;

	// primary key
	private java.lang.Integer id;

	// many to one
	private guda.core.entity.CmsWorkflowEvent event;
	private guda.core.entity.CmsUser user;



	/**
	 * Return the unique identifier of this class
     * @hibernate.id
     *  generator-class="identity"
     *  column="event_user_id"
     */
	public java.lang.Integer getId () {
		return id;
	}

	/**
	 * Set the unique identifier of this class
	 * @param id the new ID
	 */
	public void setId (java.lang.Integer id) {
		this.id = id;
		this.hashCode = Integer.MIN_VALUE;
	}




	/**
	 * Return the value associated with the column: event_id
	 */
	public guda.core.entity.CmsWorkflowEvent getEvent () {
		return event;
	}

	/**
	 * Set the value related to the column: event_id
	 * @param event the event_id value
	 */
	public void setEvent (guda.core.entity.CmsWorkflowEvent event) {
		this.event = event;
	}


	/**
	 * Return the value associated with the column: user_id
	 */
	public guda.core.entity.CmsUser getUser () {
		return user;
	}

	/**
	 * Set the value related to the column: user_id
	 * @param user the user_id value
	 */
	public void setUser (guda.core.entity.CmsUser user) {
		this.user = user;
	}



	public boolean equals (Object obj) {
		if (null == obj) return false;
		if (!(obj instanceof guda.core.entity.CmsWorkflowEventUser)) return false;
		else {
			guda.core.entity.CmsWorkflowEventUser cmsWorkflowEventUser = (guda.core.entity.CmsWorkflowEventUser) obj;
			if (null == this.getId() || null == cmsWorkflowEventUser.getId()) return false;
			else return (this.getId().equals(cmsWorkflowEventUser.getId()));
		}
	}

	public int hashCode () {
		if (Integer.MIN_VALUE == this.hashCode) {
			if (null == this.getId()) return super.hashCode();
			else {
				String hashStr = this.getClass().getName() + ":" + this.getId().hashCode();
				this.hashCode = hashStr.hashCode();
			}
		}
		return this.hashCode;
	}


	public String toString () {
		return super.toString();
	}


}