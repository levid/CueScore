package com.levid.cuescore;

import org.appcelerator.titanium.ITiAppInfo;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.TiProperties;
import org.appcelerator.kroll.common.Log;

/* GENERATED CODE
 * Warning - this class was generated from your application's tiapp.xml
 * Any changes you make here will be overwritten
 */
public final class TestAppInfo implements ITiAppInfo
{
	private static final String LCAT = "AppInfo";
	
	public TestAppInfo(TiApplication app) {
		TiProperties properties = app.getSystemProperties();
		TiProperties appProperties = app.getAppProperties();
					
					properties.setString("ti.deploytype", "development");
					appProperties.setString("ti.deploytype", "development");
	}
	
	public String getId() {
		return "com.levid.cuescore";
	}
	
	public String getName() {
		return "test";
	}
	
	public String getVersion() {
		return "1.0";
	}
	
	public String getPublisher() {
		return "levid";
	}
	
	public String getUrl() {
		return "http://www.levid.com";
	}
	
	public String getCopyright() {
		return "2012 by levid";
	}
	
	public String getDescription() {
		return "not specified";
	}
	
	public String getIcon() {
		return "appicon.png";
	}
	
	public boolean isAnalyticsEnabled() {
		return true;
	}
	
	public String getGUID() {
		return "20a1b139-3c1e-4bf7-8ceb-f6b25ea7446a";
	}
	
	public boolean isFullscreen() {
		return false;
	}
	
	public boolean isNavBarHidden() {
		return false;
	}
}
