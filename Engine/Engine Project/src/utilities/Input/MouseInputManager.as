package utilities.Input{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyCodes;
	import utilities.Engine.DefaultManager;
	import utilities.Engine.Game;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	public class MouseInputManager extends utilities.Engine.DefaultManager{
		
		public static var isDragging:Boolean = false;
		private var mouseOffSet:Point = new Point;
		private var worldOffSet:Point = new Point;
		public function MouseInputManager():void{
			
			setUp();
		}
		
		public function setUp():void {
			trace("utilities.Engine.Game.gameContainer:",utilities.Engine.Game.gameContainer);
			//utilities.Engine.Game.gameContainer.addEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
			Main.theStage.addEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
		}
		/*
		public static function getMouseCoordinates():Point{
			var mousePoint:Point = new Point(mouseX,mouseY);
			trace("mousePoint:",mousePoint);
			return mousePoint;
		}
		*/
		public function startDragWorld(event:MouseEvent):void {
			isDragging = true;
			mouseOffSet = Main.getMouseCoordinates();
			worldOffSet = Game.getGameContainerCoordinates();
			Main.theStage.addEventListener(Event.ENTER_FRAME, isDraggingWorld);
			Main.theStage.addEventListener(MouseEvent.MOUSE_UP, stopDragWorld);
		}
		
		public function isDraggingWorld(e:Event):void {
			if (isDragging) {
				var mousePoint:Point = new Point();
				mousePoint = Main.getMouseCoordinates();
				utilities.Engine.Game.gameContainer.x = mousePoint.x + worldOffSet.x - mouseOffSet.x;
				utilities.Engine.Game.gameContainer.y = mousePoint.y + worldOffSet.y - mouseOffSet.y;
			}
		}
		
		public function stopDragWorld(event:MouseEvent):void {
			isDragging = false;
			Main.theStage.removeEventListener(MouseEvent.MOUSE_UP, startDragWorld);
		}
	}
}

