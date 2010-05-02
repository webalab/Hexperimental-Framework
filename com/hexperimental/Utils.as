package com.hexperimental
{


import flash.utils.ByteArray;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.display.BitmapData;

public class Utils extends Object {
	

	public function Utils() {
		super();
	}
	
	
	public static function stringToDate(targetDate_:Date, timezone_:Number ):String{
		var dt:Date = dateToDate( targetDate_, timezone_ );
		var output:String = '';
		var seconds:Number = Math.floor(dt.getTime() / 1000);
		var minutes:Number = Math.floor(seconds / 60);
		var hours:Number = Math.floor(minutes / 60);
		var days:Number = Math.floor(hours / 24);
		//Storing the remainder of this division problem
		
		seconds %= 60;
		minutes %= 60;
		hours %= 24;
		output = formatText(days)+" "+formatText(dt.getUTCHours())+":"+formatText(dt.getMinutes())+":"+formatText(dt.getSeconds())
		return output;
	}
	
	public static function dateToDate( targetDate_:Date, timezone_:Number ):Date{		
		timezone_*=-1;
		var targetDate:Date = targetDate_;
		var timeOffset:Number =(timezone_ * 60 * 60 * 1000);
		var userDate:Date = new Date();
		var userTimeOffset:Number = userDate.getTimezoneOffset() * 60 * 1000;
		var timeZoneOffset:Date = new Date( userTimeOffset - timeOffset );		
		targetDate = new Date( targetDate.getTime() - timeZoneOffset.getTime() );
		var timeLeft:Number = targetDate.time - userDate.time
		return new Date( Math.abs(timeLeft));
	}

	public static function clone(source:Object):* {
		var copier:ByteArray = new ByteArray();
		copier.writeObject(source);
		copier.position = 0;
		return( copier.readObject() );
	}

	
	public static function gfx( asset_:* ):Sprite{
		
		var spt:Sprite = new Sprite();
		spt.addChild( asset_ );	
		var w_:Number = ( spt.width==0 ) ? 75 : spt.width;
		var h_:Number = ( spt.height==0 ) ? 75 : spt.height;
		var bmpD:BitmapData = new BitmapData( w_ , h_ );
		bmpD.draw(spt);
		
		var s:Sprite = new Sprite();
		s.graphics.beginBitmapFill(bmpD);
		s.graphics.drawRect(0,0,bmpD.width,bmpD.height);
		return s;
	}
	

	private static function formatText(d_:Number):String{
  	var d:String = d_.toString();
    return (d.length==1)?'0'+d:d;
	}




}

}