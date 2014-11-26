package guda.common.web.session.id;

import org.apache.commons.lang.StringUtils;

import java.util.UUID;


/**
 * 通过UUID生成SESSION ID
 */
public class JugUUIDGenerator implements SessionIdGenerator {
	public String get() {
		UUID uuid = UUID.randomUUID();
        return StringUtils.remove(uuid.toString(), '-');
	}


}
