using Toybox.WatchUi;

using CriticalMapsAPIBarrel;

class CriticalMapsSenderDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onImagePress() {
        CriticalMapsSenderWeb.sendPositionData();
    }

    function onMenu() {
        var menu = new WatchUi.Menu();
        menu.setTitle("CM Menu");
        menu.addItem("Reset Counter", :item_reset_counter);
        menu.addItem("DeviceId:", :item_info);

        menu.addItem(CriticalMapsAPIBarrel.getDeviceIdRaw().substring( 0, 20), :item_info);
        menu.addItem(CriticalMapsAPIBarrel.getDeviceIdRaw().substring(20, 40), :item_info);
        
        menu.addItem("Last Rsp: " + lastResponse, :item_info);
        menu.addItem("Num Rsp: " + numResponse, :item_info);

        WatchUi.pushView(menu, new CriticalMapsSenderMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}