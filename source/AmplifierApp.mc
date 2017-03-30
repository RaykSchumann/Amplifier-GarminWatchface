using Toybox.Application as App;

class AmplifierApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }
	// neue Version
    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new AmplifierView() ];
    }

}