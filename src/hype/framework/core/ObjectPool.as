package hype.framework.core {

	/**
	 * Creates and manages pools of objects
	 */
	public class ObjectPool {
		
		private var _objectClass:Class;
		private var _max:uint;
		private var _count:uint;
		private var _activeSet:ObjectSet;
		private var _inactiveSet:ObjectSet;
		
		/**
		 * Callback for when new objects are created
		 */
		public var onCreate:Function;
		
		/**
		 * Callback for when new objects are successfully requested
		 */
		public var onRequest:Function;
		
		/**
		 * Callback for when objects are released (returned to the pool)
		 */
		public var onRelease:Function;
		
		/**
		 * Constructor
		 * 
		 * @param objectClass Class of objects to pool
		 * @param max The maximum number of objects to create
		 */
		public function ObjectPool(objectClass:Class, max:uint) {
			_objectClass = objectClass;
			_max = max;
			_count = 0;
			
			_activeSet = new ObjectSet();
			_inactiveSet = new ObjectSet();
		}
		
		/**
		 * The active set of objects
		 */
		public function get activeSet():ObjectSet {
			return _activeSet;
		}
		
		/**
		 * Request a new object. If no objects are available, null is returned.
		 * 
		 * @return The new or recycled object
		 */
		public function request():Object {
			var obj:Object;
			
			if (_inactiveSet.length > 0) {
				obj = _inactiveSet.pull();
				_activeSet.insert(obj);
				onRequest(this, obj);
				
				return obj;
			} else if (_count < _max) {
				obj = new _objectClass();
				++_count;
				_activeSet.insert(obj);
				onCreate(this, obj);
				onRequest(this, obj);
				
				return obj;
			} else {
				return null;
			}
		}
		
		/**
		 * Create all of the objects the pool can contain at once.
		 */
		public function createAll():void {
			while(_count < _max) {
				request();
			}
		}
		
		/**
		 * Release an object back into the pool.
		 * 
		 * @param object The object to return to the pool
		 * 
		 * @return Whether the object was returned successfully
		 */
		public function release(object:Object):Boolean {
			if (_activeSet.remove(object)) {
				_inactiveSet.insert(object);
				onRelease(this, object);
				
				return true;
			} else {
				return false;
			}
		}
	}
}
