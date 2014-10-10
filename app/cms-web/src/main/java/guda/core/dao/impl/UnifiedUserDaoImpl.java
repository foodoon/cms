package guda.core.dao.impl;

import guda.common.hibernate3.HibernateBaseDao;
import guda.common.page.Pagination;
import guda.core.dao.UnifiedUserDao;
import guda.core.entity.UnifiedUser;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

@Repository
public class UnifiedUserDaoImpl extends HibernateBaseDao<UnifiedUser, Integer>
		implements UnifiedUserDao {
	public UnifiedUser getByUsername(String username) {
		return findUniqueByProperty("username", username);
	}

	public List<UnifiedUser> getByEmail(String email) {
		return findByProperty("email", email);
	}

	public int countByEmail(String email) {
		String hql = "select count(*) from UnifiedUser bean where bean.email=:email";
		Query query = getSession().createQuery(hql);
		query.setParameter("email", email);
		return ((Number) query.iterate().next()).intValue();
	}

	public Pagination getPage(int pageNo, int pageSize) {
		Criteria crit = createCriteria();
		Pagination page = findByCriteria(crit, pageNo, pageSize);
		return page;
	}

	public UnifiedUser findById(Integer id) {
		UnifiedUser entity = get(id);
		return entity;
	}

	public UnifiedUser save(UnifiedUser bean) {
		getSession().save(bean);
		return bean;
	}

	public UnifiedUser deleteById(Integer id) {
		UnifiedUser entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<UnifiedUser> getEntityClass() {
		return UnifiedUser.class;
	}
}