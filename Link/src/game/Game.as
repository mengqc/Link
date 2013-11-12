package game
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		private var _grid : Array;
		private var _row : int;
		private var _col : int;
		
		public function Game()
		{
			super();
			
			initMap(7, 7);
			randFillMap();
			traceGrid();
		}
		
		private function initMap(row : int, col : int) : void {
			_grid = [];
			_row = row;
			_col = col;
			
			for(var i : int = 0; i < row + 2; i++){
				_grid[i] = [];
				for(var j : int = 0; j < col + 2; j++){
					_grid[i][j] = 0;
				}
			}
			
		}
		
		private function randFillMap() : void {
			var pairNum : int = _row * _col / 2;
			var ptList : Array = [];
			for(var i : int = 1; i <=_row; i++){
				for(var j : int = 1; j <= _col; j++){
					ptList.push(new Point(i, j));
				}
			}
			for(var k : int = 1; k <= pairNum; k++){
				for(var t : int = 0; t < 2; t++){
					var pos : Point = ptList.splice(Math.random() * ptList.length, 1)[0];
					_grid[pos.x][pos.y] = k;
				}
			}
		}
		
		private function traceGrid() : void {
			for(var i : int = 0; i < _grid.length; i++){
				trace(_grid[i]);
			}
		}
		
	}
}