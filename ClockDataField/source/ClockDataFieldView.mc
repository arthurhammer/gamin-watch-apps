using Toybox.WatchUi as Ui;
using Toybox.System as System;

class ClockDataFieldView extends Ui.SimpleDataField {

    function initialize() {
        SimpleDataField.initialize();
        label = Ui.loadResource(Rez.Strings.DataFieldLabel);
    }

	function pad(num) {
		return (num < 10) ? ("0" + num) : num; 
	}
	
	function formatTime(time, showSeconds) {
		var h = pad(time.hour);
		var m = pad(time.min);
		var s = pad(time.sec);
		return h + ":" + m + (showSeconds ? (":" + s) : "");
	}

    function compute(info) {
       	var time = System.getClockTime();
   		var is24Hour = System.getDeviceSettings().is24Hour;
   		var showSeconds = Application.getApp().getProperty("ShowSeconds");

   		if (!is24Hour && time.hour > 12) {
   			time.hour -= 12;
       	}

       	return formatTime(time, showSeconds);
    }

}