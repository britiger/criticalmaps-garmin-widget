using Toybox.WatchUi;

var outText = "";

class CriticalMapsSenderView extends WatchUi.View {
	
	var myTimer = new Timer.Timer();
	
    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    	sendUpdate();  	
    	myTimer.start(method(:sendUpdate), 30000, true);
    }

    function onUpdate(dc) {
    	if(chatText.equals("")) {
        	outPutText("# Positions send: " + numResponse);
        } else {
        	outPutText(chatText);
        	System.println(chatText);
        }
        
        var v_count = View.findDrawableById("v_count");
        var v_next = View.findDrawableById("v_next");

       	v_count.setText(countCM10+"");
       	if (nearestCM == 999) {
       		v_next.setText("you are alone.");
       	} else {
       		v_next.setText(nearestCM.format("%.2f") + " km");
       	}
        
        View.onUpdate(dc);
    }

	function outPutText(text) {
		var lab = View.findDrawableById("outputtext");
		lab.setText(text + "");
	}
	
	function sendUpdate() {
		CriticalMapsSenderWeb.sendPositionData();
		WatchUi.requestUpdate();
	}
	
    function onHide() {
    }

}
