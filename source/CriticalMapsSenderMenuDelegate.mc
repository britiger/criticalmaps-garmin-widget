using Toybox.WatchUi;
using Toybox.System;
using Toybox.Communications;

class CriticalMapsSenderMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_info) {
            System.println("Show Info");
            CriticalMapsSenderWeb.sendPositionData();
        } else if (item == :item_reset_counter) {
            CriticalMapsSenderWeb.resetCounter();
        }
    }
    
}