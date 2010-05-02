package com.hexperimental
{
import com.adobe.images.JPGEncoder;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.utils.ByteArray;
import flash.display.BitmapData;
import flash.net.URLRequestMethod;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import com.adobe.images.PNGEncoder;
	
public class Encoder extends Object
{
	public var entryPoint:String;
	public var encoderPath:String;
	public var onEncodeDone:Function;
	public var onEncodeStarts:Function;
	public var onEncodeProgress:Function;
	public function Encoder()
	{
		super();
	}

	////////////////////////////////////////////////////////////////////////////////////
	// Creating PNG Image
	////////////////////////////////////////////////////////////////////////////////////
	public function createPNG(m:BitmapData, fileName:String="snapshot.jpg"):void {	
		onEncodeStarts();
		var serverUniqueFileName:String=fileName;
		var pngSource:BitmapData = m;
		pngSource.draw(m);
		var pngStream:ByteArray = PNGEncoder.encode(pngSource);
		var header:URLRequestHeader = new URLRequestHeader ("Content-type", "application/octet-stream");
		var pngURLRequest:URLRequest = new URLRequest ( entryPoint + encoderPath + "?name=" + fileName);

		pngURLRequest.requestHeaders.push(header);				
		pngURLRequest.method = URLRequestMethod.POST;				
		pngURLRequest.data = pngStream;
		var pngURLLoader:URLLoader = new URLLoader();
		pngURLLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
		pngURLLoader.addEventListener( Event.COMPLETE, imageUrlLoaderComplete );
		pngURLLoader.addEventListener( IOErrorEvent.IO_ERROR, sendIOError );
		pngURLLoader.load( pngURLRequest );
	}
	
		
	
	////////////////////////////////////////////////////////////////////////////////////
	// Creating JPG Image
	////////////////////////////////////////////////////////////////////////////////////
	public function createJPG(m:BitmapData, q:Number=100, fileName:String="snapshot.jpg"):void {			
		onEncodeStarts();
		var serverUniqueFileName:String=fileName;
		var jpgSource:BitmapData = m;
		jpgSource.draw(m);
		var jpgEncoder:JPGEncoder = new JPGEncoder(q);
		var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
		var header:URLRequestHeader = new URLRequestHeader ("Content-type", "application/octet-stream");
		var jpgURLRequest:URLRequest = new URLRequest ( entryPoint + encoderPath + "?name=" + fileName);

		jpgURLRequest.requestHeaders.push(header);				
		jpgURLRequest.method = URLRequestMethod.POST;				
		jpgURLRequest.data = jpgStream;
		var jpgURLLoader:URLLoader = new URLLoader();
		jpgURLLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
		jpgURLLoader.addEventListener( Event.COMPLETE, imageUrlLoaderComplete );
		jpgURLLoader.addEventListener( IOErrorEvent.IO_ERROR, sendIOError );
		jpgURLLoader.load( jpgURLRequest );
	}
	

		//Fired when URL Loading Complete
		private function imageUrlLoaderComplete( evt:Event ):void	{
			onEncodeDone();
//			navigateToURL( new URLRequest( redirectPath ), "_self" );
			/*
			_parent.removeChild( savingSplash );
						
						message = new TextField();
					  message.defaultTextFormat = new TextFormat("Arial", 14, 0xffffff);
					  message.text = "  Image Saved successfully      \n       Click to continue  ";
					  message.selectable= false;
			  		savedSplash.addChild( message );
				    var stg:Point = _parent.getStageSize();
				    savedSplash.x = (stg.x/2)-(savedSplash.width/2)
				    savedSplash.y = (stg.y/2)-(savedSplash.height/2)		
						_parent.addChild( savedSplash );
			//**/
		}
		//If something goes wrong with the server while uploading the image. 
		private function sendIOError( event:Event ):void {
			trace("Error occured");
		}	
		

		
		
		
		
}

}