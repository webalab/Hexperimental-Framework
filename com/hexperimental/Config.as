package com.hexperimental
{

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import XML;
	import flash.display.Sprite;

	public class Config extends Sprite
	{
		public static var THIS:Config;
		private var _stack:Array = new Array();

	
		/*
		* 
		*/
		public static function init( root_:* = null ):void{
		
			//-abort if no root_ argument
			if( !root_ ){ return; }
		
			//-Grab all flashvars.
			for ( var key:* in root_.loaderInfo.parameters ){
				instance()._stack[key] = root_.loaderInfo.parameters[key];
			}
		
			//-if config flashvar is set, load it. 
			if(instance()._stack['config']){
				instance().loadData(instance()._stack['config']);
			}
				
		}

	
		/*
		* 
		*/	
		public function loadData( fileName_:String ):void{
				var ldr:URLLoader = new URLLoader( new URLRequest( fileName_ ) );
				ldr.addEventListener(Event.COMPLETE,parseConfig);	
		}

	
		/*
		* 
		*/
		private function parseConfig(e:Event):void{
			var xml:XML = new XML(e.currentTarget.data);
			for each( var item:* in xml.children()){
				var varName:String =item.localName();
				_stack[varName]=item[0];
			}
			dispatchEvent( new Event(Event.COMPLETE) );
		}
	
	
		/*
		* 
		*/
		public static function instance():Config{
			if( THIS == null ){
				THIS = new Config();
			}
			return THIS;
		}
	
	
		/*
		* 
		*/
		public static function get(var_:String):String{
			return instance()._stack[var_];
		}
	

		/*
		* 
		*/
		public function Config()
		{
			super();
		}
	
	}

}