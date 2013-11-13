package game
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class GridItem extends Sprite
	{
		private var _img : Image;
		private var _cursorImg : Image;
		private var _type : int = 0;
		public var col : int;
		public var row : int;
		
		public function GridItem()
		{
			super();
		}
		
		public function update(type : int) : void {
			_type = type;
			if(_img){
				removeChild(_img);
			}
			var texture : Texture = TextureManager.s.getTextureById(String(type));
			if(texture){
				if(!_img){
					_img = new Image(texture);
				}else{
					_img.texture = texture;
				}
			}
			if(_img){
				addChild(_img);
			}
		}
		
		public function select() : void {
			if(!_cursorImg){
				_cursorImg = new Image(TextureManager.s.getTextureById("cursor"));
			}
			addChild(_cursorImg);
		}
		
		public function unselect() : void {
			removeChild(_cursorImg);
		}
		
		public function get type() : int {
			return _type;
		}
		
	}
}