package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import game.Game;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class Link extends Sprite
	{
		private static var _inst : Link;
		
		private var _starling : Starling;
		
		public function Link()
		{
			super();
			_inst = this;
			
			var stageWidth:int  = 800;
			var stageHeight:int = 480;
			
			Starling.multitouchEnabled = true;
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;	// not necessary on iOS. Saves a lot of memory!
			
			_starling = new Starling(Game, stage);
			
			_starling.stage.stageWidth  = stageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight = stageHeight; // <- same size on all devices!
			_starling.simulateMultitouch  = false;
			_starling.enableErrorChecking = false;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onActive);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onDeActive);
			
			stage.addEventListener(flash.events.Event.RESIZE, onResize);
		}
		
		private function onRootCreated(e : *) : void {
			_starling.start();
		}
		
		private function onActive(e : *) : void {
			_starling.start();
		}
		
		private function onDeActive(e : *) : void {
			_starling.stop();
		}
		
		private function onResize(e : *) : void {
			_starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			if(gameRoot){
				gameRoot.resize(stage.stageWidth, stage.stageHeight);
			}
		}
		
		public function get gameRoot() : Game {
			return _starling.root as Game;
		}
		
		public static function get s() : Link {
			return _inst;
		}
		
	}
}