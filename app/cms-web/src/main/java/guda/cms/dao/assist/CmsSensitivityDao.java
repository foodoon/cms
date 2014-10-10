package guda.cms.dao.assist;

import guda.cms.entity.assist.CmsSensitivity;
import guda.common.hibernate3.Updater;

import java.util.List;

public interface CmsSensitivityDao {
	public List<CmsSensitivity> getList(boolean cacheable);

	public CmsSensitivity findById(Integer id);

	public CmsSensitivity save(CmsSensitivity bean);

	public CmsSensitivity updateByUpdater(Updater<CmsSensitivity> updater);

	public CmsSensitivity deleteById(Integer id);
}