package guda.cms.biz;

import guda.cms.dao.domain.DemoDO;
import guda.tools.web.page.BaseQuery;
import guda.tools.web.page.BizResult;

public interface DemoBiz {

        BizResult detail(int id);

        BizResult list(BaseQuery baseQuery);

        BizResult delete(int id);

        BizResult create(DemoDO demoDO);

        BizResult update(DemoDO demoDO);

}
