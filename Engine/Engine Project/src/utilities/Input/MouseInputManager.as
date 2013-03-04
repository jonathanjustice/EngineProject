﻿package utilities.Input{
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
		private var delta:Point = new Point;
		private var oldMouse:Point = new Point;
		private var maximumEase:Number = 30;
		public function MouseInputManager():void{
			setUp();
		}
		
		public function setUp():void {
			Main.theStage.addEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
		}
		
		public function startDragWorld(event:MouseEvent):void {
			isDragging = true;
			mouseOffSet = Main.getMouseCoordinates();
			worldOffSet = Game.getGameContainerCoordinates();
			Main.theStage.addEventListener(Event.ENTER_FRAME, isDraggingWorld);
			Main.theStage.addEventListener(MouseEvent.MOUSE_UP, stopDragWorld);
			
		}
		
		//drag the game container with the mouse
		//when you stop dragging it, it eases to a stop
		//limit the maximum ease speed
		public function isDraggingWorld(e:Event):void {
			if (isDragging) {
				var mousePoint:Point = new Point();
				mousePoint = Main.getMouseCoordinates();
				delta.x = (mousePoint.x - oldMouse.x);
				delta.y = (mousePoint.y - oldMouse.y);
				utilities.Engine.Game.gameContainer.x = mousePoint.x + worldOffSet.x - mouseOffSet.x;
				utilities.Engine.Game.gameContainer.y = mousePoint.y + worldOffSet.y - mouseOffSet.y;
			}else if (!isDragging) {
				delta.x *= .8;
				delta.y *= .8;
				if (delta.x > maximumEase) {
					delta.x = maximumEase;
				}
				if (delta.y > maximumEase) {
					delta.y = maximumEase;
				}
				if (delta.x < -maximumEase) {
					delta.x = -maximumEase;
				}
				if (delta.y < -maximumEase) {
					delta.y = -maximumEase;
				}
				if (delta.x < .05 && delta.x > -.05) {
					delta.x = 0;
				}
				if (delta.y < .05 && delta.y > -.05) {
					delta.y = 0;
				}
				if (delta.x == 0 && delta.y == 0 ) {
					Main.theStage.addEventListener(Event.ENTER_FRAME, isDraggingWorld);
				}
				utilities.Engine.Game.gameContainer.x += delta.x;
				utilities.Engine.Game.gameContainer.y += delta.y;
			}
			oldMouse = Main.getMouseCoordinates();
		}
		
		public function stopDragWorld(event:MouseEvent):void {
			isDragging = false;
			Main.theStage.removeEventListener(MouseEvent.MOUSE_UP, startDragWorld);
		}
	}
}

