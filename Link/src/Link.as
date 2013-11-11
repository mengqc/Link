package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import game.Game;
	import game.GameMain;
	
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
			_starling.start();
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e : Event) : void {
		}
		
	}
}