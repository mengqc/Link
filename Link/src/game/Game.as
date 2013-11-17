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
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function resize(width : Number, height : Number) : void {
			trace("game resize");
			_gameScene.x = (stage.stageWidth - _gameScene.width) / 2;
			_gameScene.y = (stage.stageHeight - _gameScene.height) / 2;
		}
		
		private function onAddedToStage(e : Event) : void {
			TextureManager.s.initTextures();
			_gameScene.initialize(8, 4);
			_gameScene.randFillMap();
			_gameScene.updateViewState();
			resize(stage.stageWidth, stage.stageHeight);
		}
	}
}