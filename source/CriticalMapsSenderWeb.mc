using Toybox.Background;
using Toybox.System;
using Toybox.Position;
using Toybox.Time;
using Toybox.Communications;
using Toybox.Math;
using Toybox.Lang;
using Toybox.Application.Properties;

using CriticalMapsAPIBarrel as CM;

var lastResponse = -1;
var numResponse = 0;
var nearestCM = 0;
var countCM10 = 0;
var chatText = "";
var mapMarkers = [];

class CriticalMapsSenderWeb extends Toybox.System.ServiceDelegate {

    function initialize() {
        System.ServiceDelegate.initialize();
    }
    
    function loadDefaultValues() {
        numResponse = Properties.getValue("sendCounter");
        if (! numResponse instanceof Toybox.Lang.Long && ! numResponse instanceof Toybox.Lang.Number) {
            System.println("sendCounter is not numeric");
            resetCounter();
        }
    }
    
    function resetCounter() {
        numResponse = 0;
        Properties.setValue("sendCounter", numResponse);
    }

    function sendPositionData() {
        var callback = new Lang.Method($, :callbackCM);
        CM.sendPositionData(callback);
    }
}

function callbackCM(responseCode, data) {
    var result = CM.callbackCM(responseCode, data);
    lastResponse = result["responseCode"];
    if (lastResponse == 200){
        numResponse += 1;
        Properties.setValue("sendCounter", numResponse);
        nearestCM = result["nearestCM"];
        countCM10 = result["countCM10"];
        chatText = result["chatText"];
        mapMarkers = result["mapMarkers"];
    } else if(lastResponse == -402) {
        // to many data for garmin
        numResponse += 1;
    }
}