package game
{
	import flash.geom.Point;
	
	import game.utils.Input;
	import game.utils.InputEvent;
	
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
		private var _input : Input;
		
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e : Event) : void {
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
					if(_grid[i][j]){
						var gridItem : GridItem = new GridItem();
						_spGrid[i][j] = gridItem;
						addChild(gridItem);
						gridItem.col = j;
						gridItem.row = i;
						gridItem.x = j * GameConfig.ITEM_WIDTH;
						gridItem.y = i * GameConfig.ITEM_HEIGHT;
						gridItem.update(_grid[i][j]);
					}else{
						_spGrid[i][j] = null;
					}
				}
			}
		}
		
		private function initEvents() : void {
			_input = new Input(stage);
			_input.addEventListener(InputEvent.CLICK, onClicked);
		}
		
		private var _selectedItems : Array = [];
		
		private function onClicked(e : InputEvent) : void {
			var input : Input = e.target as Input;
			var pos : Point = e.touch.getLocation(input.source);
			var col : int = Math.min(int(pos.x / GameConfig.ITEM_WIDTH), _col);
			var row : int = Math.min(int(pos.y / GameConfig.ITEM_HEIGHT), _row);
			var secondItem : GridItem = _spGrid[row][col];
			if(secondItem){
				//选中
				if(_selectedItems.length == 1){
					if(_selectedItems[0].type == secondItem.type){
						_selectedItems.push(secondItem);
						secondItem.select();
						if(isCanEliminate(_selectedItems[0], _selectedItems[1]);){
							//可消除
							
						}
					}
				}else if(_selectedItems.length == 0){
					//选中第一个
					_selectedItems.push(secondItem);
					secondItem.select();
				}else{
					//取消选择
					for each(var gridItem : GridItem in _selectedItems){
						gridItem.unselect();
					}
					_selectedItems.length = 0;
				}
			}
		}
		
		private function isCanEliminate(item1 : GridItem, item2 : GridItem) : Boolean {
			
			return false;
		}
		
		private function traceGrid() : void {
			for(var i : int = 0; i < _grid.length; i++){
				trace(_grid[i]);
			}
		}
		
	}
}