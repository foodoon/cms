package guda.core.manager;

import guda.core.entity.CmsConfig;
import guda.core.entity.CmsConfigAttr;
import guda.core.entity.MarkConfig;
import guda.core.entity.MemberConfig;

import java.util.Date;

public interface CmsConfigMng {
	public CmsConfig get();

	public void updateCountCopyTime(Date d);

	public void updateCountClearTime(Date d);

	public CmsConfig update(CmsConfig bean);

	public MarkConfig updateMarkConfig(MarkConfig mark);

	public void updateMemberConfig(MemberConfig memberConfig);
	
	public void updateConfigAttr(CmsConfigAttr configAttr);
}