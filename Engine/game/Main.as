package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import utilities.Mathematics.MathFormulas;
	import utilities.Engine.Game;
	import utilities.Engine.UIManager;
	import utilities.Input.KeyInputManager;
	import flash.geom.Point;

	public class Main extends MovieClip{
		
		public static var theStage;
		public static var game;
		public static var uiContainer;//empty MC?
		public static var uiManager;//empty MC?
		public static var keyInputManager;

		//check to see if the stage exists
		//usually only necessary if this is on the web or deployed inside another swf
		public function Main():void {
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
			trace(stage);
		}
		
		//once the stage exists, launch the game
        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			initialSetup();
        }
		
		//define the stage for use in other classes
		//launch the engine
		//set up a some important managers
		private function initialSetup():void{
			defineTheStage();
			createKeyInputManager();
			createUIManager();
			createTheGameEngine();
			openStartScreen();
		}
		
		//make sure to get rid of this eventually
		private function defineTheStage():void{
			//trace("the stage exists")
			theStage = this.stage;
		}
		
		private function createKeyInputManager():void{
			//trace("the input manager exists")
			keyInputManager = new utilities.Input.KeyInputManager();
		}
		
		private static function createUIManager():void{
			uiManager = new UIManager()
		}
		
		private function createTheGameEngine():void{
			game = new utilities.Engine.Game();
		}
		
		private function openStartScreen():void{
			uiManager.openStartScreen();
		}
		
		//If you lose focus, you can use this to regain it to the stage
		//useful when you click on buttons or click outside the game
		public static function returnFocusToGampelay(){
			theStage.focus = null;
		}
	}
}