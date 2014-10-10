package guda.cms.dao.main;

import guda.cms.entity.main.ChannelExt;
import guda.common.hibernate3.Updater;

public interface ChannelExtDao {
	public ChannelExt save(ChannelExt bean);

	public ChannelExt updateByUpdater(Updater<ChannelExt> updater);
}