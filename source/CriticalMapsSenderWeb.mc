using Toybox.Background;
using Toybox.System;
using Toybox.Position;
using Toybox.Time;
using Toybox.Communications;
using Toybox.Math;

using CriticalMapsAPIBarrel as CM;

var lastResponse = -1;
var numResponse = 0;
var nearestCM = 0;
var countCM10 = 0;
var chatText = "";

(:background)
class CriticalMapsSenderWeb extends Toybox.System.ServiceDelegate {	

    function initialize() {
        System.ServiceDelegate.initialize();
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
        nearestCM = result["nearestCM"];
        countCM10 = result["countCM10"];
        chatText = result["chatText"];
    } else if(lastResponse == -402) {
        // to many data for garmin
        numResponse += 1;
    }
}