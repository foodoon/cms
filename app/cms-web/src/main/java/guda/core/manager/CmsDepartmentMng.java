package guda.core.manager;

import guda.common.page.Pagination;
import guda.core.entity.CmsDepartment;

import java.util.List;

public interface CmsDepartmentMng {

	/**
	 * 
	 * @param parentId 父层部门id
	 * @param all 是否查询所有部门
	 * @return
	 */
	public List<CmsDepartment> getList(Integer parentId,boolean all);
	
	public Pagination getPage( String name, int pageNo,int pageSize);

	public CmsDepartment findById(Integer id);

	public CmsDepartment save(CmsDepartment bean);
	
	public CmsDepartment save(CmsDepartment bean,Integer channelIds[],Integer[]ctgIds);

	public CmsDepartment update(CmsDepartment bean);
	
	public CmsDepartment update(CmsDepartment bean,Integer channelIds[],Integer[]ctgIds);

	public void updatePriority(Integer[] ids, Integer[] priorities);

	public CmsDepartment deleteById(Integer id);
	
	public CmsDepartment[] deleteByIds(Integer ids[]);

	public boolean nameExist(String name);


}