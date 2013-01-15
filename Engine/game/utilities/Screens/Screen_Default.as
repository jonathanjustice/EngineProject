﻿package utilities.Screens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.*;
	import utilities.Engine.UIManager;
	public class Screen_Default extends MovieClip{
		public var uiManager;
		private var blocker;
		private var myScreen;
		
		public function Screen_Default(){
			//trace("super");
			setUp();
		}
		
		public function setUp(){
			//myScreen = screen_swf;
			setScreen();
			addDynamicBlocker();
			addScreenGraphics();
			addScreenToUIContainer();
			addClickHandler();
			addOverHandler();
			addOutHandler();
			mouseEnabledHandler();
		}
		
		public function setScreen():void{
			//myScreen = screen_swf;
			//trace(myScreen,"myScreen");
		}
		
		public function addScreenGraphics():void{
			//trace("this",this);
			//trace("myScreen",myScreen);
			//myScreen = new MovieClip();
			this.addChild(myScreen);
		}
		
		//CLICKING
		public function addClickHandler(){
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function removeClickHandler(){
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function clickHandler(event:MouseEvent){
			
		}
		
		//MOUSEING OVER
		public function addOverHandler(){
			this.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function removeOverHandler(){
			this.removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function overHandler(event:MouseEvent){
			
		}
		
		public function mouseEnabledHandler(){
			
		}
		
		//MOUSING OUT
		public function addOutHandler(){
			this.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function removeOutHandler(){
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function outHandler(event:MouseEvent){
			
		}
		
		private function addDynamicBlocker():void{
			blocker = new utilities.Screens.Screen_Dynamic_Blocker;
			this.addChild(blocker)
		}
		
		private function removeDynamicBlocker():void{
			this.removeChild(blocker);
		}
		
		private function updateDynamicBlocker():void{
			blocker.update_dynamic_blocker_because_the_screen_was_resized();
		}
		
		/*public function addScreenToGame(){
			//utilities.Engine.Game.gameContainer.addChild(this);
			utilities.Engine.UIManager.uiContainer.addChild(this);
			
		}
		*/
		public function addScreenToUIContainer(){
			utilities.Engine.UIManager.uiContainer.addChild(this);
		}
		
		//removing the screen
		public function removeThisScreen(){
			removeOutHandler();
			removeOverHandler();
			removeClickHandler();
			removeDynamicBlocker();
			utilities.Engine.UIManager.uiContainer.removeChild(this);
		}
	}
}