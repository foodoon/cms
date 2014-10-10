package guda.cms.manager.assist.impl;

import guda.cms.dao.assist.CmsMysqlDataBackDao;
import guda.cms.entity.back.CmsField;
import guda.cms.manager.assist.CmsMysqlDataBackMng;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CmsMysqlDataBackMngImpl implements CmsMysqlDataBackMng {

	@Transactional(readOnly = true)
	public String createTableDDL(String tablename) {
		return dao.createTableDDL(tablename);
	}

	@Transactional(readOnly = true)
	public List<Object[]> createTableData(String tablename) {
		return dao.createTableData(tablename);
	}

	@Transactional(readOnly = true)
	public List<CmsField> listFields(String tablename) {
		return dao.listFields(tablename);
	}

	@Transactional(readOnly = true)
	public List<String> listTabels(String catalog) {
		return dao.listTables(catalog);
	}

	@Transactional(readOnly = true)
	public List<String> listDataBases() {
		return dao.listDataBases();
	}

	@Transactional(readOnly = true)
	public String getDefaultCatalog() throws SQLException {
		return dao.getDefaultCatalog();
	}
	
	public void setDefaultCatalog(String catalog) throws SQLException{
		 dao.setDefaultCatalog(catalog);
	}

	public Boolean executeSQL(String sql) {
		return dao.executeSQL(sql);
	}

	private CmsMysqlDataBackDao dao;

	@Autowired
	public void setDao(CmsMysqlDataBackDao dao) {
		this.dao = dao;
	}

}