package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsVoteRecord;
import guda.cms.entity.assist.CmsVoteTopic;
import guda.core.entity.CmsUser;

import java.util.Date;

public interface CmsVoteRecordMng {
	public CmsVoteRecord save(CmsVoteTopic topic, CmsUser user, String ip,
			String cookie);

	public int deleteByTopic(Integer topicId);

	public Date lastVoteTimeByUserId(Integer userId, Integer topicId);

	public Date lastVoteTimeByIp(String ip, Integer topicId);

	public Date lastVoteTimeByCookie(String cookie, Integer topicId);
}