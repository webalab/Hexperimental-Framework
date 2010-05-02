package com.hexperimental
{
import flash.text.TextField;
import flash.display.Sprite;
import flash.text.TextFormat;
import flash.events.MouseEvent;
import flash.system.System;
import flash.utils.*;
import flash.display.DisplayObject;

/**
 * Class.
 * 
 * @langversion ActionScript 3.0
 * @playerversion Flash 10.0
 * 
 * @author antonio perez salas
 * @since  12.12.2009
 */

public class Debugger extends Sprite
{
	public static var PROD:Boolean = true;
	public var debugText:TextField;	
	
	private var _rootReference:*;
	private var _instance:DisplayObject;
	
	public function Debugger( rootReference_:* ){
		_rootReference = rootReference_;
		super();
		if(PROD){return}
		debugText = new TextField();
		debugText.defaultTextFormat = new TextFormat("Arial", 10, 0x000000);
		debugText.text = "";
		debugText.setTextFormat(new TextFormat("Arial","12") );
		debugText.width = 200;
		debugText.height= 15;
		debugText.border = true;
		debugText.background = true;
		debugText.backgroundColor = 0x000000;
		debugText.x = debugText.y =0;
		debugText.addEventListener(MouseEvent.MOUSE_OVER,onOver);
		debugText.addEventListener(MouseEvent.MOUSE_OUT,onOut);
		debugText.addEventListener(MouseEvent.CLICK,onClick);
		_instance = _rootReference.addChild( debugText );
	}

	public function onOver(e:MouseEvent):void{
		_rootReference.setChildIndex( _instance, _rootReference.numChildren-1 );
		debugText.height = _rootReference.stage.stageHeight;
	}
	public function onOut(e:MouseEvent):void{
			debugText.height = 15;
	}	
	public function onClick(e:MouseEvent):void{
			System.setClipboard(debugText.text);
	}

	public function log( msg_:*):void{
		if(PROD){return}
		_rootReference.setChildIndex( _instance, _rootReference.numChildren-1 );
		
		var msg_s:String =''//>'+getQualifiedClassName(msg_)+">";

		
		if( getQualifiedClassName(msg_) == "String" || getQualifiedClassName(msg_)=='int' ){
			msg_s+= '> '+msg_;
		} else {
			msg_s+= '> '+getQualifiedClassName(msg_)+'\n';
			for (var key:* in msg_){
				msg_s+= '...'+key+': '+msg_[key]+'\n';
			}
		}
		
		debugText.text= msg_s+"\n"+debugText.text;
		debugText.setTextFormat(new TextFormat("Verdana","11","0xffffff",true) );
	}
	
	public function clear():void{
		debugText.visible = false;
		debugText.text = '';
	}
	

	
}

}