package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	public class ScreenStart extends utilities.Screens.Screen_Default{
		private var blocker;
		private var myScreen;
		
		public function ScreenStart(){
			
		}
		
		public override function clickHandler(event:MouseEvent){
			//trace("parent:",event.target.parent.name);
			//trace("target:",event.target.name);
			switch (event.target){
				
				case myScreen.btn_start:
				trace("clicked start screen");
					removeThisScreen();
					utilities.Engine.Game.startGame("start");
					break;
				/*case view.tab_store:
					setScreenState("store",currentTab);
					break;*/
				
			}
		}
		
		public override function mouseEnabledHandler(){
			myScreen.btn_start.buttonMode = true;
			//Main.returnFocusToGampelay();
		}
		
		public override function setScreen():void{
			
			//myScreen = screen_swf;
			myScreen = new Screen_Start();
			trace("ScreenStart: myScreen is:",myScreen);
		}
		
		public override function addScreenGraphics():void{
			trace("ScreenStart: addScreenGraphics",myScreen);
			this.addChild(myScreen);
		}
		
		//CLICKING
		/*public function addClickHandler(){
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
		}*/
	}
}