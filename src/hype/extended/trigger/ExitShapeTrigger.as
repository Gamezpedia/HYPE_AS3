package hype.extended.trigger {
	import hype.framework.trigger.AbstractTrigger;
	import hype.framework.trigger.ITrigger;

	import flash.display.DisplayObject;

	/**
	 * Trigger that fires when an object has exited from a shape.
	 */
	public class ExitShapeTrigger extends AbstractTrigger implements ITrigger {
		private var _shape:DisplayObject;
		private var _shapeFlag:Boolean;
		private var _enterFlag:Boolean;
		
		
		/**
		 * Constructor
		 * 
		 * @param callback Function to call when this trigger fires
		 * @param target Target object to track
		 * @param shape DisplayObject that defines the shape
		 * @param shapeFlag True if the actual shape of the shape is to be used
		 * false if only the bounding box should be used
		 */
		public function ExitShapeTrigger(callback:Function, target:Object, shape:DisplayObject, shapeFlag:Boolean=false) {
			super(callback, target);
			_shape = shape;
			_shapeFlag = shapeFlag;
			
			_enterFlag = false;
		}
		
		public function run(target:Object):Boolean {
			var result:Boolean = false;
			var displayTarget:DisplayObject = target as DisplayObject;
			
			if (_shape.hitTestPoint(displayTarget.x, displayTarget.y, _shapeFlag)) {
				_enterFlag = true;
			} else if (_enterFlag) {
				result = true;
			}
			
			return result;
		}
	}
}
