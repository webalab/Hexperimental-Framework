package com.hexperimental
{

import flash.events.*;
import flash.net.URLRequest;
import flash.net.FileReference;
import flash.net.FileFilter;
import flash.net.URLVariables;
import flash.net.URLRequestMethod;
import Digitalizer;
import flash.text.TextField;
import flash.display.Sprite;
import flash.events.Event;

public class Uploader extends Sprite
{
	public static var PROGRESS:String ='_progress_';
	public static var DONE:String = '_done_';
	public static var ENTRY_POINT:String; 
	public static var UPLOAD_FILE:String;


	private var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
	private var URLrequest:URLRequest;
	private var fileRef:FileReference;
	public var onUploadComplete:Function;
	public var onUploadProgress:Function;
	public var onUploadStarts:Function;
	public var onBrowseCanceled:Function;
	
	public var timeString:String;
	public var self:Uploader=null;
	
	public function Uploader() {
		super();
		fileRef = new FileReference();
		URLrequest = new URLRequest( Uploader.ENTRY_POINT + Uploader.UPLOAD_FILE );	
		fileRef.addEventListener(Event.SELECT, syncVars);
		fileRef.addEventListener(Event.CANCEL, cancelBrowsing);
		fileRef.addEventListener(Event.COMPLETE, uploadedHandler);
		fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
	}
	

	public function browse():void{
		var allTypes:Array = new Array(imageTypes);		
		fileRef.browse(allTypes);
	}
	public function cancelBrowsing(e:Event):void{
		onBrowseCanceled();		
	}	
	public function syncVars(e:Event):void{
	 	var file:FileReference = FileReference(e.target);


    var variables:URLVariables = new URLVariables();
		var dt:Date = new Date();
    variables.todayDate  = dt.time;
		timeString = variables.todayDate;
    variables.Name = "Dude"; // This could be an input field variable like in my contact form tutorial : )
		variables.Email = "someDude@someEmail.com"; // This one the same
    URLrequest.method = URLRequestMethod.POST;
    URLrequest.data = variables;
		fileRef.upload(URLrequest);
		onUploadStarts();
	}
	
	public function uploadedHandler( e:Event = null ):void{
		var file:FileReference = FileReference(e.target);
		onUploadComplete( timeString+file.name );
	}
	
	public function progressHandler( e:ProgressEvent ):void{
		var file:FileReference = FileReference(e.target);
		onUploadProgress( file.name, e.bytesLoaded, e.bytesTotal );
	}
		
}

}