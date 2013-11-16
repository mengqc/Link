package game
{
	import game.core.GameScene;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var _gameScene : GameScene;
		
		public function Game()
		{
			super();
			_gameScene = new GameScene();
			addChild(_gameScene);
			_gameScene.x = 200;
			_gameScene.y = 100;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function resize(width : Number, height : Number) : void {
			trace("game resize");
		}
		
		private function onAddedToStage(e : Event) : void {
			TextureManager.s.initTextures();
			_gameScene.initialize(8, 4);
			_gameScene.randFillMap();
			_gameScene.updateViewState();
		}
	}
}