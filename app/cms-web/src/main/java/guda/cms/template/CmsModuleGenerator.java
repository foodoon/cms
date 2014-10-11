package guda.cms.template;


public class CmsModuleGenerator {
	private static String packName = "guda.cms.template";
	private static String fileName = "cms.properties";

	public static void main(String[] args) {
		new ModuleGenerator(packName, fileName).generate();
	}
}
