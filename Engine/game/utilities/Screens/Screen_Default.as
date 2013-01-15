package utilities{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screen_Dynamic_Blocker;
	public class Screen_Default extends MovieClip{
		public var uiManager;
		private var blocker;
		private var myScreen;
		
		public function Screen_Default(uimanager,screen_swf){
			myScreen = screen_swf;
			setScreen();
			addDynamicBlocker();
			addScreenGraphics();
			addMouseHandler();
			addOverHandler();
			addOutHandler();
			uiManager = uimanager;
		}
		
		private function setScreen():void{
			//myScreen = screen_swf;
			//trace(myScreen,"myScreen");
		}
		
		private function addScreenGraphics():void{
			//trace("this",this);
			//trace("myScreen",myScreen);
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
			blocker = new utilities.Screen_Dynamic_Blocker;
			this.addChild(blocker)
		}
		
		private function removeDynamicBlocker():void{
			this.removeChild(blocker);
		}
		
		private function updateDynamicBlocker():void{
			blocker.update_dynamic_blocker_because_the_screen_was_resized();
		}
		
		//removing the screen
		public function removeThisScreen(){
			removeOutHandler();
			removeOverHandler();
			removeMouseHandler();
			removeDynamicBlocker();
			uiManager.removeScreen(this);
		}
	}
}