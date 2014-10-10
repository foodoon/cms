package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.core.entity.CmsRole;

import java.util.List;

public interface CmsRoleDao {
	public List<CmsRole> getList();

	public CmsRole findById(Integer id);

	public CmsRole save(CmsRole bean);

	public CmsRole updateByUpdater(Updater<CmsRole> updater);

	public CmsRole deleteById(Integer id);
}