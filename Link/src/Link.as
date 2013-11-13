package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import game.Game;
	
	import starling.core.Starling;
	
	public class Link extends Sprite
	{
		private var _starling : Starling;
		
		public function Link()
		{
			super();
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_starling = new Starling(Game, stage);
			stage.addEventListener(Event.RESIZE, onResize);
			_starling.start();
		}
		
		private function onResize(e : Event) : void {
			_starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
	}
}