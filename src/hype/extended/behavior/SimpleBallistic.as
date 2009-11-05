package hype.extended.behavior {
	import hype.framework.behavior.AbstractBehavior;
	import hype.framework.behavior.IBehavior;
	import hype.framework.core.HypeMath;

	import flash.display.DisplayObject;

	public class SimpleBallistic extends AbstractBehavior implements IBehavior {
		
		private var _friction:Number;
		private var _gravityX:Number;
		private var _gravityY:Number;
		private var _xSpeed:Number;
		private var _ySpeed:Number;
		
		public function SimpleBallistic(target:Object, _drag:Number, minForce:Number, maxForce:Number, gravity:Number, gravityAngle:Number=90) {
			var angle:Number = Math.PI * 2 * Math.random();
			var force:Number = minForce + (Math.random() * (maxForce - minForce));
			
			super(target);
			
			_friction = _drag;
			
			_gravityX = Math.cos(gravityAngle * HypeMath.D2R) * gravity;
			_gravityY = Math.sin(gravityAngle * HypeMath.D2R) * gravity;

			_xSpeed = force * Math.cos(angle);
			_ySpeed = force * Math.sin(angle);
		}
		
		public function run(target:Object):void {
			var clip:DisplayObject = target as DisplayObject;
			
			_xSpeed += _gravityX;
			_ySpeed += _gravityY;
	
			_xSpeed *= _friction;
			_ySpeed *= _friction;
			
			clip.x += _xSpeed;
			clip.y += _ySpeed;
		}
	}
}


