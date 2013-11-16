package game.core
{
	import flash.geom.Point;
	
	import game.GameConfig;
	import game.utils.Input;
	import game.utils.InputEvent;
	
	import starling.display.Sprite;
	
	public class GameScene extends Sprite
	{
		private var _spGrid : Vector.<Vector.<GridItem>>;
		private var _input : Input;
		private var _model : GridModel;
		private var _selectedItem : GridItem;
		
		public function GameScene()
		{
			super();
			_input = new Input(this);
			_input.addEventListener(InputEvent.CLICK, onClicked);
		}
		
		/**
		 * 按大小初始化初始化游戏组件
		 */
		public function initialize(col : int, row : int) : void {
			if(!_model){
				_model = new GridModel(col, row);
			}else{
				_model.setSize(col, row);
			}
			initView();
		}
		
		public function randFillMap() : void {
			_model.randFillMap();
		}
		
		/**
		 * 根据数据模型初始化视图
		 */
		public function initView() : void {
			_spGrid = new Vector.<Vector.<GridItem>>();
			for(var i : int = 0; i < _model.mapRow; i++){
				_spGrid[i] = new Vector.<GridItem>();
				for(var j : int = 0; j < _model.mapCol; j++){
					var gridItem : GridItem = new GridItem(j, i, _model.getValue(j, i));
					_spGrid[i][j] = gridItem;
					addChild(gridItem);
					gridItem.x = j * GameConfig.ITEM_WIDTH;
					gridItem.y = i * GameConfig.ITEM_HEIGHT;
				}
			}
		}
		
		/**
		 * 根据数据模型更新视图状态
		 */
		public function updateViewState() : void {
			for(var i : int = 0; i < _model.mapRow; i++){
				for(var j : int = 0; j < _model.mapCol; j++){
					_spGrid[i][j].update(_model.getValue(j, i));
				}
			}
		}
		
		private function onClicked(e : InputEvent) : void {
			var input : Input = e.target as Input;
			var pos : Point = e.touch.getLocation(input.source);
			var col : int = Math.min(int(pos.x / GameConfig.ITEM_WIDTH), _model.col);
			var row : int = Math.min(int(pos.y / GameConfig.ITEM_HEIGHT), _model.row);
			var secondItem : GridItem = _spGrid[row][col];
			if(secondItem.visible){
				//选中
				if(_selectedItem){
					if(_selectedItem.type == secondItem.type && _model.isCanEliminate(_selectedItem, secondItem)){
						//可消除
						removeGridItem(_selectedItem);
						removeGridItem(secondItem);
						_selectedItem = null;
						if(_model.isAllClear){
							randFillMap();
							updateViewState();
						}
					}else{
						_selectedItem.selected = false;
						_selectedItem = secondItem;
						_selectedItem.selected = true;
					}
				}else if(!_selectedItem){
					//选中第一个
					_selectedItem = secondItem;
					_selectedItem.selected = true;
				}
			}
		}
		
		/**
		 * 消除格子
		 */
		private function removeGridItem(item : GridItem) : void {
			_model.setValue(item.col, item.row, 0);
			_spGrid[item.row][item.col].update(0);
		}
		
	}
}