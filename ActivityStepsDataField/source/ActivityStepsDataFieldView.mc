using Toybox.WatchUi as Ui;
using Toybox.ActivityMonitor as ActivityMonitor;

class TimerState {
	var last = 0;
	var current = 0;

	function initialize() {

	}

	function update(time) {
		last = current;
		current = (time == null) ? 0 : time;
		last = (current == 0) ? 0 : last;
	}

	function started() {
		return current > 0;
	}

	function stopped() {
		return current == 0;
	}

	function running() {
		return current > last;
	}

	function paused() { 
		return current == last;
	}
}

class ActivityStepsDataFieldView extends Ui.SimpleDataField {

	var activitySteps = 0;
	var lastSteps = 0;	
	var timer;	
	// Skip first tick after starting/unpausing activity. 
	// Otherwise would include steps from last tick while waiting/paused.  
	var firstTick = true;

    function initialize() {
        SimpleDataField.initialize();
        label = Ui.loadResource(Rez.Strings.DataFieldLabel);
        timer = new TimerState();
    }

   	function getSteps() {
    	var steps = ActivityMonitor.getInfo().steps;
    	return (steps != null) ? steps : 0;
    }

    function compute(info) {
    	timer.update(info.timerTime);

   		if (timer.paused()) {
   			if (timer.stopped()) {
   				activitySteps = 0;
    			lastSteps = 0;
   			}
   			firstTick = true; 
    		return activitySteps;
		}

    	var steps = getSteps();
		activitySteps += firstTick ? 0 : (steps - lastSteps);
        firstTick = false;
        lastSteps = steps;

        return activitySteps;
    }

}