package game.utils
{
	import flash.events.Event;
	
	import starling.events.Touch;
	
	public class InputEvent extends Event
	{
		public static const CLICK : String = "CLICK";
		public static const MOUSE_DOWN : String = "MOUSE_DOWN";
		public static const MOUSE_UP : String = "MOUSE_UP";
		public static const MOUSE_OVER : String = "MOUSE_OVER";
		public static const MOUSE_MOVE : String = "MOUSE_MOVE";
		
		private var _touch : Touch;
		
		public function InputEvent(type:String, touch : Touch, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_touch = touch;
		}
		
		public function get touch() : Touch {
			return _touch;
		}
		
		override public function clone():Event {
			return new InputEvent(type, touch, bubbles, cancelable);
		}
		
	}
}