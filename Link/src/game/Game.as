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
					if(_selectedItems[0].type == secondItem.type && isCanEliminate(_selectedItems[0], secondItem)){
						//可消除
						removeGridItem(_selectedItems[0]);
						removeGridItem(secondItem);
						_selectedItems.length = 0;
					}else{
						for each(var gridItem : GridItem in _selectedItems){
							gridItem.unselect();
						}
						_selectedItems.length = 0;
						_selectedItems.push(secondItem);
						secondItem.select();
					}
				}else if(_selectedItems.length == 0){
					//选中第一个
					_selectedItems.push(secondItem);
					secondItem.select();
				}
			}
		}
		
		private function removeGridItem(item : GridItem) : void {
			_grid[item.row][item.col] = 0;
			_spGrid[item.row][item.col] = null;
			removeChild(item);
		}
		
		private function isCanEliminate(item1 : GridItem, item2 : GridItem) : Boolean {
			if(item1.col == item2.col && item1.row == item2.row){
				//相同的点不能连通
				return false;
			}
			var ptA : Point = new Point(item1.col, item1.row);
			var ptB : Point = new Point(item2.col, item2.row)
			var isLinked : Boolean = false;
			//直线连通检测
			isLinked = isLineLinkable(ptA, ptB);
			if(isLinked){
				return true;
			}
			
			//一折连通检测
			var cornerPt : Point = isCornerLinkable(ptA, ptB);
			if(cornerPt){
				return true;
			}
			
			//两折连通检测
			var corners : Array = isCorner2Linkable(ptA, ptB);
			if(corners){
				return true;
			}
			
			return false;
		}
		
		private function isLineLinkable(pt1 : Point, pt2 : Point) : Boolean {
			//pt.x代表col，pt.y代表row
			if(pt1.x == pt2.x){	//列相同
				var startRow : int = pt1.y <= pt2.y ? pt1.y : pt2.y;
				var endRow : int = pt1.y >= pt2.y ? pt1.y : pt2.y;
				var dltRow : int = endRow - startRow - 1;
				while(dltRow > 0){
					if(_grid[startRow + dltRow][pt1.x]){
						//有一个点不为0，则无法连通
						return false;
					}
					dltRow--;
				}
				return true;
			}else if(pt1.y == pt2.y){ //行相同
				var startCol : int = pt1.x <= pt2.x ? pt1.x : pt2.x;
				var endCol : int = pt1.x >= pt2.x ? pt1.x : pt2.x;
				var dltCol : int = endCol - startCol - 1;
				while(dltCol > 0){
					if(_grid[pt1.y][startCol + dltCol]){
						//有一个点不为0，则无法连通
						return false;
					}
					dltCol--;
				}
				return true;
			}else{ //col和row没有一个相同的则无法直线连通
				return false;
			}
		}
		
		private function isCornerLinkable(pt1 : Point, pt2 : Point) : Point {
			if(pt1.x != pt2.x && pt1.y != pt2.y){
				//col和row均不相等，符合拐角检测条件
				var ptList : Array = [new Point(pt1.x, pt2.y), new Point(pt2.x, pt1.y)];
				for each(var cornerPt : Point in ptList){
					if(_grid[cornerPt.y][cornerPt.x] == 0){
						if(isLineLinkable(pt1, cornerPt) && isLineLinkable(cornerPt, pt2)){
							return cornerPt;
						}
					}
				}
				return null;
			}else{
				//不符合拐角检测规则
				return null;
			}
		}
		
		private function isCorner2Linkable(pt1 : Point, pt2 : Point) : Array {
			//col和row均不相等，符合2拐角检测条件
			//横向扫描
			var mid : int = (pt1.x + pt2.x) / 2;
			var offset : int = 0;
			var cornerPt : Point = null;
			var sign : int = 1;
			var cursor : int = 0;
			var bothOut : Boolean = false;
			var isIn : Boolean = false;
			var cornerPt2 : Point = null;
			while(true){
				cursor = mid + sign * offset;
				cornerPt = new Point(cursor, pt1.y);
				isIn = isInBounds(cursor, true);
				if(isIn && _grid[cornerPt.y][cornerPt.x] == 0
					&& isLineLinkable(pt1, cornerPt)
				){
					cornerPt2 = isCornerLinkable(cornerPt, pt2);
					if(cornerPt2){
						return [cornerPt, cornerPt2];
					}
				}
				if(sign == 1){
					offset++;
					bothOut &&= !isIn;
					if(bothOut){
						break;
					}
				}else{
					bothOut = !isIn;
				}
				sign *= -1;
			}
			
			//纵向扫描
			mid = (pt1.y + pt2.y) / 2;
			offset = 0;
			cornerPt = null;
			sign = 1;
			cursor = 0;
			bothOut = false;
			isIn = false;
			cornerPt2 = null;
			while(true){
				cursor = mid + sign * offset;
				cornerPt = new Point(pt1.x, cursor);
				isIn = isInBounds(cursor, false);
				if(isIn && _grid[cornerPt.y][cornerPt.x] == 0
					&& isLineLinkable(pt1, cornerPt)){
					cornerPt2 = isCornerLinkable(cornerPt, pt2);
					if(cornerPt2){
						return [cornerPt, cornerPt2];
					}
				}
				if(sign == 1){
					offset++;
					bothOut &&= !isIn;
					if(bothOut){
						break;
					}
				}else{
					bothOut = !isIn;
				}
				sign *= -1;
			}
			return null;
		}
		
		private function isInBounds(n : int, isHorizontal : Boolean = true) : Boolean {
			if(isHorizontal){
				if(n >= 0 && n < _grid[0].length){
					return true;
				}else{
					return false;
				}
			}else{
				if(n >= 0 && n < _grid.length){
					return true;
				}else{
					return false;
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