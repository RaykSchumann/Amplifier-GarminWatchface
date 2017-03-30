using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;

class AmplifierView extends Ui.WatchFace {

    // the BitmapResource for the background image
    var background; 
        
    // the length of the minute hand
    var minute_radius_min = 40;  //70
    var minute_radius_max1 = 137;
    var minute_radius_max2 = 140;
    var minute_radius_max3 = 143;    
    var offset_x_min = 110;   
    var offset_y_min = 75;
    var offset_x_max = 110;   
    var offset_y_max = 95;

    var index;
    var images;
    var bitmap;
    
    var index2;
    var images2;
    var bitmap2;    


    function initialize() {
        WatchFace.initialize();

    }



    function onLayout(dc) {
    
            background = Ui.loadResource(Rez.Drawables.background);
         //   center_x = dc.getWidth() / 2;
        //	center_y = dc.getHeight() / 2;
        index = 0;
        images = [Rez.Drawables.one,
        	Rez.Drawables.two,
        	Rez.Drawables.three,
        	Rez.Drawables.four,
        	Rez.Drawables.five,
        	Rez.Drawables.six,
        	Rez.Drawables.seven,
        	Rez.Drawables.eight,
        	Rez.Drawables.nine,
        	Rez.Drawables.ten,
        	Rez.Drawables.eleven,
        	Rez.Drawables.twelve,        	
        	Rez.Drawables.midnight];

        bitmap = Ui.loadResource(images[index]);

        index2 = 0;
        images2 = 	[Rez.Drawables.am,
        			Rez.Drawables.pm];

        bitmap2 = Ui.loadResource(images2[index2]);

    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {

        var now = Sys.getClockTime();
        var hour = now.hour;
        var minute = now.min;
        var sec = now.sec;
        var minute_angle = 0;
        var x0;
		var y0;
        var x1;
		var y1;        
        var x2;
		var y2;
        var x3;
		var y3;
        var x4;
		var y4;
        var x5;
		var y5;
        var x6;
		var y6;
        var timenow = Time.now();
        var info = Calendar.info(timenow, Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$ $3$", [info.day_of_week, info.month, info.day]);
        var minuteStr = "Minutes";
 

 		var hourstring =  hour.toString() + ":" + minute.format("%02d").toString();
        
 
    	index2 = 0;
         	if (hour > 12 ) {
        		index2 = 1;		//  shows pm
        		}
 
         if (hour > 12) {
        	hour = hour - 12;
			}

  
   			index = hour -1;
         	if (hour == 0 ) {
        		index = 12;		//  shows midnight
        		}


        // Set background image
		dc.drawBitmap(0, 0, background);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
 
    	// Write hour
        bitmap = null;
        bitmap = null;
        bitmap = Ui.loadResource(images[index]);
        
        var bx = (dc.getWidth() / 2) - (bitmap.getWidth() / 2);
        var by = 165; //(dc.getHeight() * 0.9 ) ;        


        dc.drawBitmap(bx, by, bitmap); 

    	// Write hour am/pm
        bitmap2 = null;
        bitmap2 = Ui.loadResource(images2[index2]);
        
        bx = (dc.getWidth() / 2) - (bitmap2.getWidth() / 2);
        by = 200; //(dc.getHeight() * 0.9 ) ;        

        dc.drawBitmap(bx, by, bitmap2); 



		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_BLACK);
   //     dc.drawText( (dc.getWidth() / 2), 10 , Gfx.FONT_SYSTEM_XTINY , hourstring, Gfx.TEXT_JUSTIFY_CENTER );
        dc.drawText( (dc.getWidth() / 2), 12 , Gfx.FONT_SYSTEM_XTINY , dateStr, Gfx.TEXT_JUSTIFY_CENTER ); //90

		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText( (dc.getWidth() / 2), 70 , Gfx.FONT_SYSTEM_XTINY , minuteStr, Gfx.TEXT_JUSTIFY_CENTER );
   
    // Write minute
		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_BLACK);
		minute_angle = (60 - minute) + 60; // runs from right to left + 60 angle offset 


		x0 =  Math.cos(2 * Math.PI / 360 * (minute_angle-5)) * minute_radius_min + offset_x_min;
		y0 =  110 - Math.sin(2 * Math.PI / 360 * (minute_angle-5)) * minute_radius_min + offset_y_min;
		x1 =  Math.cos(2 * Math.PI / 360 * (minute_angle-1)) * minute_radius_max1 + offset_x_max;
		y1 =  110 - Math.sin(2 * Math.PI / 360 * (minute_angle-1)) * minute_radius_max1 + offset_y_max;
		x2 =  Math.cos(2 * Math.PI / 360 * minute_angle) * minute_radius_max2 + offset_x_max;
		y2 =  110 - Math.sin(2 * Math.PI / 360 * minute_angle) * minute_radius_max2 + offset_y_max;	
		x3 =  Math.cos(2 * Math.PI / 360 * (minute_angle+1)) * minute_radius_max1 + offset_x_max;
		y3 =  110 - Math.sin(2 * Math.PI / 360 * (minute_angle+1)) * minute_radius_max1 + offset_y_max;	
		x4 =  Math.cos(2 * Math.PI / 360 * (minute_angle+5)) * minute_radius_min + offset_x_min;
		y4 =  110 - Math.sin(2 * Math.PI / 360 * (minute_angle+5)) * minute_radius_min + offset_y_min;
		x5 =  Math.cos(2 * Math.PI / 360 * minute_angle) * minute_radius_min + offset_x_min;
		y5 =  110 - Math.sin(2 * Math.PI / 360 * minute_angle) * minute_radius_min + offset_y_min;
	

		x6 =  Math.cos(2 * Math.PI / 360 * minute_angle) * minute_radius_max3 + offset_x_max;
		y6 =  110 - Math.sin(2 * Math.PI / 360 * minute_angle) * minute_radius_max3 + offset_y_max;		

        // draw the minute hand
        
        
var    pointarray =[[x0,y0],[x1,y1],[x2,y2],[x3,y3],[x4,y4],[x5,y5]] ; 
		dc.fillPolygon(pointarray);

		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
		dc.drawLine(x2,y2,x6,y6);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
