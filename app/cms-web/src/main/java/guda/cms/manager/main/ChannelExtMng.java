package guda.cms.manager.main;

import guda.cms.entity.main.Channel;
import guda.cms.entity.main.ChannelExt;

public interface ChannelExtMng {
	public ChannelExt save(ChannelExt ext, Channel channel);

	public ChannelExt update(ChannelExt ext);
}