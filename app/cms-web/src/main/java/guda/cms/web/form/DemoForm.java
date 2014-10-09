package guda.cms.web.form;

import java.util.Date;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import guda.cms.dao.domain.DemoDO;
import com.sun.istack.internal.NotNull;

public class DemoForm {
         private Integer id;

         private String name;

         private String password;

         private Date gmtCreate;

         private Long amount;

       public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public Date getGmtCreate() {
        return gmtCreate;
    }
    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }
    public Long getAmount() {
        return amount;
    }
    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public DemoDO toDO(){
DemoDO demoDO  = new DemoDO();
                demoDO.setName(this.name);
                demoDO.setPassword(this.password);
                demoDO.setGmtCreate(this.gmtCreate);
                demoDO.setAmount(this.amount);
        return demoDO;
    }

}
