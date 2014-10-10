package guda.cms.manager.assist;

import guda.cms.entity.assist.CmsVoteItem;
import guda.cms.entity.assist.CmsVoteSubTopic;
import guda.cms.entity.assist.CmsVoteTopic;

import java.util.Collection;
import java.util.List;
import java.util.Set;

public interface CmsVoteSubTopicMng {

	public CmsVoteSubTopic findById(Integer id);
	
	public List<CmsVoteSubTopic> findByVoteTopic(Integer voteTopicId);
	
	public CmsVoteTopic save(CmsVoteTopic bean, Set<CmsVoteSubTopic> subTopics);

	public CmsVoteSubTopic save(CmsVoteSubTopic bean, List<CmsVoteItem> items);

	public CmsVoteSubTopic update(CmsVoteSubTopic bean, Collection<CmsVoteItem> items);
	
	public CmsVoteTopic update(CmsVoteTopic bean, Collection<CmsVoteSubTopic> subTopics);
	
	public Collection<CmsVoteSubTopic> update(Collection<CmsVoteSubTopic> subTopics,CmsVoteTopic topic);

	public CmsVoteSubTopic deleteById(Integer id);

	public CmsVoteSubTopic[] deleteByIds(Integer[] ids);

}