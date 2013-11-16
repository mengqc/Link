package game.core
{
	import game.TextureManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class GridItem extends Sprite
	{
		private var _img : Image;
		private var _cursorImg : Image;
		private var _type : int = 0;
		private var _col : int;
		private var _row : int;
		private var _selected : Boolean = false;
		
		public function GridItem(col : int, row : int, type : int)
		{
			super();
			_col = col;
			_row = row;
			update(type);
		}
		
		public function update(type : int) : void {
			_type = type;
			if(type == 0){
				visible = false;
			}else{
				visible = true;
				selected = false;
				var texture : Texture = TextureManager.s.getTextureById(String(type));
				if(texture){
					if(!_img){
						_img = new Image(texture);
						addChild(_img);
					}else{
						_img.texture = texture;
					}
				}
			}
		}
		
		public function set selected(v : Boolean) : void {
			if(_selected != v){
				_selected = v;
				if(_selected){
					if(!_cursorImg){
						_cursorImg = new Image(TextureManager.s.getTextureById("cursor"));
					}
					addChild(_cursorImg);
				}else{
					removeChild(_cursorImg);
				}
			}
		}
		
		public function get selected() : Boolean {
			return _selected;
		}
		
		public function get type() : int {
			return _type;
		}
		
		public function get col() : int {
			return _col;
		}
		
		public function get row() : int {
			return _row;
		}
		
	}
}