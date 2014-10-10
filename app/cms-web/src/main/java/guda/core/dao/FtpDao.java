package guda.core.dao;

import guda.common.hibernate3.Updater;
import guda.core.entity.Ftp;

import java.util.List;

public interface FtpDao {
	public List<Ftp> getList();

	public Ftp findById(Integer id);

	public Ftp save(Ftp bean);

	public Ftp updateByUpdater(Updater<Ftp> updater);

	public Ftp deleteById(Integer id);
}