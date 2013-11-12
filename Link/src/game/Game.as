package game
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Game extends Sprite
	{
		private var _grid : Array;
		private var _spGrid : Array;
		private var _row : int;
		private var _col : int;
		
		public function Game()
		{
			super();
			
			TextureManager.s.initTextures();
			
			initMap(4, 8);
			randFillMap();
			initRender();
			initEvents();
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
			var pairNum : int = _row * _col / 8;
			var ptList : Array = [];
			for(var i : int = 1; i <=_row; i++){
				for(var j : int = 1; j <= _col; j++){
					ptList.push(new Point(i, j));
				}
			}
			for(var k : int = 1; k <= pairNum; k++){
				for(var t : int = 0; t < 8; t++){
					var pos : Point = ptList.splice(Math.random() * ptList.length, 1)[0];
					_grid[pos.x][pos.y] = k;
				}
			}
		}
		
		private function initRender() : void {
			_spGrid = [];
			for(var i : int = 0; i < _grid.length; i++){
				_spGrid[i] = [];
				for(var j : int = 0; j < _grid[i].length; j++){
					var gridItem : GridItem = new GridItem();
					_spGrid[i][j] = gridItem;
					addChild(gridItem);
					gridItem.x = j * 50;
					gridItem.y = i * 50;
					gridItem.update(_grid[i][j]);
				}
			}
		}
		
		private function initEvents() : void {
			addEventListener(TouchEvent.TOUCH, onTouched);
		}
		
		private var _selectedItem : GridItem;
		
		private function onTouched(e : TouchEvent) : void {
			var touch : Touch = e.getTouch(stage);
			if(touch){
				var pos : Point = touch.getLocation(stage);
				if(touch.phase == "hover"){
					if(_selectedItem){
						_selectedItem.unselect();
					}
					var col : int = Math.min(int(pos.x / 50), _col);
					var row : int = Math.min(int(pos.y / 50), _row);
					_selectedItem = _spGrid[row][col];
					_selectedItem.select();
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