using Toybox.Application;
using Toybox.WatchUi;

using CriticalMapsAPIBarrel;

class CriticalMapsSenderApp extends Application.AppBase {

	static var id;

    function initialize() {
        AppBase.initialize();
        
        var mySettings = System.getDeviceSettings();
		self.id = mySettings.uniqueIdentifier;
		
		System.println("DeviceID: " + self.id);
    }

    // onStart() is called on application start up
    function onStart(state) {
    	
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	System.println(CriticalMapsAPIBarrel.getDeviceId());
        return [ new CriticalMapsSenderView(), new CriticalMapsSenderDelegate() ];
    }

}
