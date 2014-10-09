package guda.cms.dao;

import guda.cms.dao.domain.DemoDO;
import guda.cms.dao.domain.DemoDOCriteria;
import java.util.List;

public interface DemoDOMapper {
    int countByExample(DemoDOCriteria example);

    int deleteByPrimaryKey(Integer id);

    int insert(DemoDO record);

    int insertSelective(DemoDO record);

    List<DemoDO> selectByExample(DemoDOCriteria example);

    DemoDO selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DemoDO record);

    int updateByPrimaryKey(DemoDO record);
}