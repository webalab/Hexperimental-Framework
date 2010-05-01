package com.hexperimental
{

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;
import XML;

public class Config extends Object
{
	public static var THIS:Config;
	public static var ROOT:*;
	public static var onLoaded:Function;
	
	private var _stack:Array = new Array();
	
	public static function init():void{
		//Grab all flashvars.
		for ( var key:* in ROOT.loaderInfo.parameters ){
			instance()._stack[key] = ROOT.loaderInfo.parameters[key];
		}
		//if config flashvar is set, load it. 
		if(instance()._stack['config']){
			instance().loadData(instance()._stack['config']);
		}		
	}
	
	public function loadData( config_file:String ):void{
			var ldr:URLLoader = new URLLoader( new URLRequest( config_file ) );
			ldr.addEventListener(Event.COMPLETE,parseConfig);	
	}
	
	public function parseConfig(e:Event):void{
		var xml:XML = new XML(e.currentTarget.data);
		for each( var item:* in xml.children()){
			var varName:String =item.localName();
			_stack[varName]=item[0];
		}
		onLoaded(); 
	}
	
	public static function instance():Config{
		if( THIS == null ){
			THIS = new Config();
		}
		return THIS;
	}
	
	
	public static function get(var_:String):String{
		return instance()._stack[var_];
	}
	

	public function Config()
	{
		super();
	}
	
}

}