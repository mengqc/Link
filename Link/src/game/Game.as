package game
{
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		private var _grid : Array;
		
		public function Game()
		{
			super();
			
			initMap();
		}
		
		private function initMap() : void {
			_grid = [];
			for(var i : int = 0; i < 9; i++){
				_grid[i] = [];
				for(var j : int = 0; j < 9; j++){
					_grid[i][j] = 0;
				}
			}
		}
		
	}
}