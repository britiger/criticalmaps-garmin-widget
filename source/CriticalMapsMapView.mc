using Toybox.WatchUi;
using Toybox.Position;

class CriticalMapsMapView extends WatchUi.MapView {

    // Initialize the MapView
    function initialize() {
        MapView.initialize();

        var mapsize = 1000; // 1 km mapsize
        var borderFactor = 1.2;

        if (nearestCM < 0.5) {
            mapsize = mapsize * 0.5 * borderFactor; // minimum distance 500m
        } else if (nearestCM > 50) {
            mapsize = mapsize * 50 * borderFactor; // maximum distance 75km
        } else {
            mapsize = mapsize * nearestCM * borderFactor; // use nearest postion
        }

        // retrieve current Postion and center map
        var location = Position.getInfo().position;
        var top_left = location.getProjectedLocation(Math.toRadians(315), mapsize);
        var bottom_right = location.getProjectedLocation(Math.toRadians(135), mapsize);
        MapView.setMapVisibleArea(top_left, bottom_right);

        // Set my position on map
        var allMarkers = [];
        var myPosition = new WatchUi.MapMarker(location);
        myPosition.setLabel(WatchUi.loadResource(Rez.Strings.marker_me));
        myPosition.setIcon(WatchUi.MAP_MARKER_ICON_PIN,0,0);
        allMarkers.add(myPosition);
        
        // Set fullscreen
        MapView.setScreenVisibleArea(0, 0, System.getDeviceSettings().screenWidth, System.getDeviceSettings().screenHeight);

        // Add other positions (other color)
        allMarkers.addAll(mapMarkers);
        MapView.setMapMarker(allMarkers);

        // Set the map mode to move zoom browse mode
        MapView.setMapMode(WatchUi.MAP_MODE_BROWSE);
    }

}
