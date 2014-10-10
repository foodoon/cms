package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.common.page.Pagination;
import guda.core.entity.CmsDepartment;

import java.util.List;

public interface CmsDepartmentDao {

	public List<CmsDepartment> getList(Integer parentId,boolean all);

	public Pagination getPage(String name, int pageNo,int pageSize);

	public CmsDepartment findById(Integer id);

	public CmsDepartment findByName(String name);

	public CmsDepartment save(CmsDepartment bean);

	public CmsDepartment deleteById(Integer id);

	public CmsDepartment updateByUpdater(Updater<CmsDepartment> updater);

}