package guda.cms.dao.assist;

import guda.cms.entity.back.CmsField;

import java.sql.SQLException;
import java.util.List;

public interface CmsOracleDataBackDao {

	public List<String> listTables();

	public List<CmsField> listFields(String tablename);
	
	public List<String> getColumns(String tablename);

	public String createTableDDL(String tablename);
	
	public List<String> getFkConstraints(String tablename);
	
	public String createFKconstraintDDL(String constraint);
	
	public List<String> createIndexDDL(String tablename);
	
	public List<String> getSequencesList(String user);
	
	public String createSequenceDDL(String sqname);
	
	public String getDefaultCatalog()throws SQLException;
	
	public String getJdbcUserName()throws SQLException;
	
	public void setDefaultCatalog(String catalog) throws SQLException;

	public List<Object[][]> createTableData(String tablename);
	
	public void executeSQL(String sql,String prefix) throws SQLException;
	
	public void executeSQLWithNoResult(String sql);

}