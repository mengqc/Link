package game.utils
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;

	public class Input extends EventDispatcher
	{
		private var _source : DisplayObject;
		private var _isMouseDown : Boolean = false;
		
		public function Input(sp : DisplayObject)
		{
			_source = sp;
			_source.addEventListener(TouchEvent.TOUCH, onTouched);
		}
		
		protected function onTouched(e : TouchEvent) : void {
			var touch : Touch = e.getTouch(_source);
			if(touch){
				switch(touch.phase){
					case "began":
						_isMouseDown = true;
						dispatchMouseDown(touch);
						break;
					case "ended":
						dispatchMouseUp(touch);
						if(_isMouseDown){
							dispatchClick(touch);
						}
						_isMouseDown = false;
						break;
					case "hover":
						dispatchMouseMove(touch);
						break;
					default:
						break;
				}
			}
		}
		
		protected function dispatchMouseDown(touch : Touch) : void {
			dispatchEvent(new InputEvent(InputEvent.MOUSE_DOWN, touch));
		}
		
		protected function dispatchMouseUp(touch : Touch) : void {
			dispatchEvent(new InputEvent(InputEvent.MOUSE_UP, touch));
		}
		
		protected function dispatchClick(touch : Touch) : void {
			dispatchEvent(new InputEvent(InputEvent.CLICK, touch));
		}
		
		protected function dispatchMouseMove(touch : Touch) : void {
			dispatchEvent(new InputEvent(InputEvent.MOUSE_MOVE, touch));
		}
		
		public function get source() : DisplayObject {
			return _source;
		}
		
		public function get isMouseDown() : Boolean {
			return _isMouseDown;
		}
		
		public function destroy() : void {
			_source.removeEventListener(TouchEvent.TOUCH, onTouched);
			_source = null;
		}
		
	}
}