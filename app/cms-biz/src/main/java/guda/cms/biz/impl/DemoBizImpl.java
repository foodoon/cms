package guda.cms.biz.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import guda.cms.biz.DemoBiz;
import guda.cms.dao.DemoDOMapper;
import guda.cms.dao.domain.DemoDO;
import guda.cms.dao.domain.DemoDOCriteria;
import guda.tools.web.page.BaseQuery;
import guda.tools.web.page.BizResult;

public class DemoBizImpl implements DemoBiz{

    private final static Logger logger = LoggerFactory.getLogger(DemoBizImpl.class);

    @Autowired
    private DemoDOMapper demoDOMapper;

    public BizResult detail(int id) {
        BizResult bizResult = new BizResult();
        try{
            DemoDO demoDO = demoDOMapper.selectByPrimaryKey(id);
            bizResult.data.put("demoDO", demoDO);
            bizResult.success = true;
        }catch(Exception e){
            logger.error("query Demo error",e);
        }
        return bizResult;
}

    public BizResult list(BaseQuery baseQuery) {
        BizResult bizResult = new BizResult();
        try {
            DemoDOCriteria demoDOCriteria = new DemoDOCriteria();
            demoDOCriteria.setStartRow(baseQuery.getStartRow());
            demoDOCriteria.setPageSize(baseQuery.getPageSize());
            int totalCount = demoDOMapper.countByExample(demoDOCriteria);
            baseQuery.setTotalCount(totalCount);
            List<DemoDO> demoDOList = demoDOMapper.selectByExample(demoDOCriteria);
            bizResult.data.put("demoDOList", demoDOList);
            bizResult.data.put("query", baseQuery);
            bizResult.success = true;
        } catch (Exception e) {
            logger.error("view Demo list error", e);
        }
            return bizResult;
     }

    public BizResult delete(int id) {
        BizResult bizResult = new BizResult();
        try {
            demoDOMapper.deleteByPrimaryKey(id);
            bizResult.success = true;
        } catch (Exception e) {
            logger.error("delete demo error", e);
        }
        return bizResult;
    }

    public BizResult create(DemoDO demoDO) {
        BizResult bizResult = new BizResult();
        try {
            int id = demoDOMapper.insert(demoDO);
            bizResult.data.put("id", id);
            bizResult.success = true;
        } catch (Exception e) {
            logger.error("create Demo error", e);
        }
        return bizResult;
    }

    public BizResult update(DemoDO demoDO) {
        BizResult bizResult = new BizResult();
        try {
            int id = demoDOMapper.updateByPrimaryKeySelective(demoDO);
            bizResult.data.put("id", id);
            bizResult.success = true;
        } catch (Exception e) {
            logger.error("update Demo error", e);
        }
        return bizResult;
    }

    }
