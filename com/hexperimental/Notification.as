package com.hexperimental
{
import flash.text.TextField;
import flash.display.Sprite;
import flash.text.TextFormat;
import flash.events.MouseEvent;
import flash.system.System;
import flash.utils.*;
import flash.display.DisplayObject;
import Date;

import flash.events.Event;

/**
 * Class.
 * 
 * @langversion ActionScript 3.0
 * @playerversion Flash 10.0
 * 
 * @author antonio perez salas
 * @since  12.12.2009
 */

public class Notification extends Sprite
{

	public var _msg:TextField;	
	public static var THIS:Notification=null;
	public static var ROOT:*;
	public static var WIDTH:Number = 200;
	public static var HEIGHT:Number = 50;
	public static var PADDING:Number = 3;
	public static var OUT_MARGIN:Number = 10;
	public static var THEMES:Array
	private var _rootReference:*;
	private var _position:String;
	private var _delay:Number;
	private var _background:String;
	private var _instances:Array;
	private var current_count:Number=0;
	private static var DEFAULT_DELAY:Number = 3;

	public static function instance():Notification{
		if( THIS == null ){
			THIS = new Notification();
		}
		return THIS;
	}

	public function Notification(){
		_instances = new Array();
		THEMES = new Array();
		THEMES['notice']={outline:0x666666,filling:0xaaaaaa}		
		THEMES['success']={outline:0x009900,filling:0xaaaaaa}
		THEMES['warning']={outline:0x999900,filling:0xaaaaaa}
		THEMES['error']={outline:0x990000,filling:0xaaaaaa}
		super();
	}

	public function throwAlert( msg_:String, theme_:String = 'notice', position_:String="TR", delay_:Number = 3 ):void{

		var now:Date = new Date();
		var notificationId:String = "_" + now.getTime().toString() + Math.random() * 999;
		var notif:Sprite = new Sprite();
		notif.addChild( createBackground(THEMES[theme_].outline,THEMES[theme_].filling) );
		notif.addChild( createTextField(msg_) );
		notif.name = notificationId;
		notif.addEventListener( MouseEvent.CLICK,onClick );
		/*
			TODO HANDLE MULTIPLE NOTIFICATIONS ON DIFFERENT PLACES. 
		*/
		if(position_=="TR"){
			notif.x = ROOT.stage.stageWidth - (notif.width + OUT_MARGIN )
			notif.y = OUT_MARGIN+ ( current_count * (notif.height + OUT_MARGIN ) )
		}
		if(position_=="TL"){
			notif.x = OUT_MARGIN;
			notif.y = OUT_MARGIN+ ( current_count * (notif.height + OUT_MARGIN ) );
		}
		if(position_=="BR"){
			notif.x = ROOT.stage.stageWidth - (notif.width + OUT_MARGIN )
			notif.y = ROOT.stage.stageHeight - (notif.height + OUT_MARGIN )
		}
		if(position_=="BL"){
			notif.x = OUT_MARGIN
			notif.y = ROOT.stage.stageHeight - (notif.height + OUT_MARGIN )
		}
		if(position_=="TC"){
			notif.x = ROOT.stage.stageWidth/2 - (notif.width /2 )
			notif.y = OUT_MARGIN
		}
		if(position_=="CC"){
			notif.x = ROOT.stage.stageWidth/2 - (notif.width/2 )
			notif.y = ROOT.stage.stageHeight/2 - (notif.height/2 )
		}
		if(position_=="BC"){
			notif.x = ROOT.stage.stageWidth/2 - (notif.width/2 )
			notif.y = ROOT.stage.stageHeight - (notif.height + OUT_MARGIN )
		}

		var _instance:DisplayObject = ROOT.addChild( notif );
		var _intervalId:uint;
		
		if( delay_ > 0 ){
			_intervalId = setTimeout( fadeOut, delay_*1000, notif );
		}else{
			_intervalId =0;
		}
		
		_instances[notificationId]={intervalId:_intervalId,instance:notif}
		current_count++;
	}
	
	private function onClick(e:MouseEvent):void{
		var id:String = e.currentTarget.name;
		fadeOut( _instances[id].instance );
	}
	
	private function fadeOut( target:Object ):void{
		var id:String = target.name;
		if( _instances[id].intervalId != 0 ){
			clearTimeout( _instances[id].intervalId);
		}
		_instances[id].instance.addEventListener(Event.ENTER_FRAME, fadeAnimation);
	}
	
	private function fadeAnimation( e:Event ):void{
		e.currentTarget.alpha-=.05;
		if( e.currentTarget.alpha <= 0 ){
			e.currentTarget.removeEventListener( Event.ENTER_FRAME, fadeAnimation );
			ROOT.removeChild(_instances[e.currentTarget.name].instance);
			current_count--;
		}else{
			
		}
	}
	
	private function createBackground( borderColor:uint, fillingColor:uint):Sprite{
		var sprt:Sprite = new Sprite();
		sprt.graphics.beginFill(fillingColor,.7);
		sprt.graphics.lineStyle(4,borderColor);
		sprt.graphics.drawRoundRect(0,0,WIDTH,HEIGHT,15,15);
		sprt.graphics.endFill();
		return sprt;
	}
	
	private function createTextField(msg_:String):TextField{
		_msg = new TextField();
		_msg.text = msg_;
		_msg.setTextFormat(new TextFormat("Arial","12") );
		_msg.multiline = true;
		_msg.wordWrap = true;
		_msg.width = WIDTH-(PADDING*2);
		_msg.height = HEIGHT-(PADDING*2);
		_msg.x = _msg.y =PADDING;
		_msg.border = false;
		_msg.selectable = false;
		return _msg;
	}

	public function onOver(e:MouseEvent):void{
	}
	public function onOut(e:MouseEvent):void{
	}	

	

	
}

}