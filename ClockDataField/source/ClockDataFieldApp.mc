using Toybox.Application as App;

class ClockDataFieldApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart() {
    }

    function onStop() {
    }

    function getInitialView() {
        return [ new ClockDataFieldView() ];
    }

}