package game
{
	import flash.display.Stage;

	public class GameMain
	{
		private static var _inst : GameMain;
		private var _stage : Stage;
		
		public function GameMain()
		{
			if(!_inst){
				_inst = this;
			}else{
				throw AppError.MULTI_INST;
			}
		}
		
		public static function get s() : GameMain {
			if(!_inst){
				_inst = new GameMain();
			}
			return _inst;
		}
		
		public function initialize(root : Stage) : void {
			_stage = root;
		}
		
		public function onResize(width : Number, height : Number) : void {
			
		}
		
		public function onProcessData() : void {
			
		}
		
		public function onProcessRender() : void {
			
		}
		
	}
}