package game
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import starling.textures.Texture;

	public class TextureManager
	{
		private static var _inst : TextureManager;
		
		private var _textureDict : Object = {};
		
		public function TextureManager()
		{
			if(!_inst){
				_inst = this;
			}else{
				throw AppError.MULTI_INST;
			}
		}
		
		public static function get s() : TextureManager {
			if(!_inst){
				_inst = new TextureManager();
			}
			return _inst;
		}
		
		public function initTextures() : void {
			_textureDict["1"] = Texture.fromColor(GameConfig.ITEM_WIDTH, GameConfig.ITEM_HEIGHT, 0xFFFF0000);
			_textureDict["2"] = Texture.fromColor(GameConfig.ITEM_WIDTH, GameConfig.ITEM_HEIGHT, 0xFFFFFF00);
			_textureDict["3"] = Texture.fromColor(GameConfig.ITEM_WIDTH, GameConfig.ITEM_HEIGHT, 0xFF00FF00);
			_textureDict["4"] = Texture.fromColor(GameConfig.ITEM_WIDTH, GameConfig.ITEM_HEIGHT, 0xFF0000FF);
			
			var shape : Shape = new Shape();
			shape.graphics.beginFill(0, 0);
			shape.graphics.lineStyle(5, 0);
			shape.graphics.drawRect(0, 0, GameConfig.ITEM_WIDTH, GameConfig.ITEM_HEIGHT);
			shape.graphics.endFill();
			var bmd : BitmapData = new BitmapData(GameConfig.ITEM_WIDTH, GameConfig.ITEM_HEIGHT, true, 0);
			bmd.draw(shape);
			_textureDict["cursor"] = Texture.fromBitmapData(bmd);
		}
		
		public function getTextureById(id : String) : Texture {
			return _textureDict[id];
		}
		
	}
}