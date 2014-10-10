package guda.cms.manager.assist;

import guda.cms.entity.back.CmsField;

import java.sql.SQLException;
import java.util.List;

public interface CmsMysqlDataBackMng {
	public List<String> listTabels(String catalog);

	public List<CmsField> listFields(String tablename);

	public List<String> listDataBases();

	public String createTableDDL(String tablename);

	public List<Object[]> createTableData(String tablename);
	
	public String getDefaultCatalog()throws SQLException;
	
	public void setDefaultCatalog(String catalog) throws SQLException;

	public Boolean executeSQL(String sql);
}