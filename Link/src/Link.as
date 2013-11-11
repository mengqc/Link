package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import game.GameMain;
	
	public class Link extends Sprite
	{
		public function Link()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			GameMain.s.initialize(stage);
		}
		
		private function onAddedToStage(e : Event) : void {
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onResize(e : Event) : void {
			GameMain.s.onResize(stage.stageWidth, stage.stageHeight);
		}
		
		private function onEnterFrame(e : Event) : void {
			GameMain.s.onProcessData();
			GameMain.s.onProcessRender();
		}
		
	}
}