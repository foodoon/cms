package guda.cms.web.form;

import guda.cms.dao.domain.DemoDO;


public class DemoEditForm extends DemoForm{

    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public DemoDO toDO(){
        DemoDO demoDO  =super.toDO();
        demoDO.setId(this.id);
        return demoDO;
    }

    public void initForm(DemoDO demoDO){
        if(demoDO == null){
           return ;
        }
                this.setId(demoDO.getId());
                this.setName(demoDO.getName());
                this.setPassword(demoDO.getPassword());
                this.setGmtCreate(demoDO.getGmtCreate());
                this.setAmount(demoDO.getAmount());
            }

}
