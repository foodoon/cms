package guda.cms.dao.main;

import guda.cms.entity.main.ChannelCount;
import guda.common.hibernate3.Updater;
import net.sf.ehcache.Ehcache;

public interface ChannelCountDao {
	public int clearCount(boolean week, boolean month);

	public int freshCacheToDB(Ehcache cache);

	public ChannelCount findById(Integer id);

	public ChannelCount save(ChannelCount bean);

	public ChannelCount updateByUpdater(Updater<ChannelCount> updater);
}