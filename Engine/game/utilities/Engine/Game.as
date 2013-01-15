package utilities.Engine{
	import flash.events.Event;
	import flash.display.MovieClip;
	import utilities.Screens.GameContainer;
	import utilities.Engine.Builders.LevelBuilder;
	import utilities.Engine.Builders.LootManager;
	import utilities.Engine.Combat.CombatManager;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Actors.Avatar;
	import utilities.Mathematics.QuadTree;
	
	public class Game extends MovieClip{
		public static var theGame;
		public static var avatarManager;
		public static var bulletManager;
		public static var enemyManager;
		public static var combatManager;
		public static var lootManager;
		public static var levelBuilder;
		public static var levelManager;
		public static var avatar;
		private static var quadTree;
		private static var gamePaused:Boolean=true;
		private static var gameManager;
		
		//Not adding objects directly to stage so that I can manipulate the world globally when needed
		//usually for things like zooming in and out, recentering the camera, etc.
		public static var gameContainer;
		
		public function Game(){
			theGame = this;
			createGameContainer();
			createQuadTree();
			//startGame("debug");
		}
		
		private static function createGameContainer():void{
			gameContainer = new utilities.Screens.GameContainer();
			Main.theStage.addChild(gameContainer);
			
		}
		
		private static function createQuadTree():void{
			quadTree = new utilities.Mathematics.QuadTree();
		}
		
		public static function returnFocusToGameContainer(){
			Main.theStage.focus = null;
		}
		
		//star the game from various places, such as a loaded game, new game, restarted game, etc.
		public static function startGame(startLocation:String){
			switch(startLocation){
				case "debug":
				
					trace("Started Game: From debug method");
					createManagersAndControllers();
					enableMasterLoop();
					break;
				case "start":
				
					trace("Started Game: From the Start Screen");
					createManagersAndControllers();
					enableMasterLoop();
					break;
				case "pause":
					enableMasterLoop();
					break;
				case "restart":
					//game has been restarted
					
					//stop the loop while I clear everything out of it
					disableMasterLoop();
					//clear everything so it can be resetup
					clearGame();
					//recreate everything
					
					//restart the loop
					enableMasterLoop();
					break;
			}
			returnFocusToGameContainer();
		}
		
		public static function enableMasterLoop(){
			gamePaused=false;
			gameContainer.addEventListener(Event.ENTER_FRAME, masterLoop);
		}
		
		public static function disableMasterLoop(){
			gamePaused=true;
			gameContainer.removeEventListener(Event.ENTER_FRAME, masterLoop);
		}
		
		//clear everything out of the arrays
		//useful for restarting a level or the game
		public static function clearGame(){
			
			//gameContainer.removeChild(avatar);
			//game.removeChild(pauseBtn);
			//avatar = null;
			//pauseBtn = null;
		}
		
		//this should get broken down into more stuff
		private static function createManagersAndControllers(){
			//createAvatar();
			createLevelManager();
			createLevelBuilder();
			createAvatarManager();
			createBulletManager();
			createEnemyManager();
			createCombatManager();
			createLootManager();
		}
		
		private static function createLevelManager(){
			levelManager = new LevelManager();
		}
		
		private static function createLevelBuilder(){
			levelBuilder = new utilities.Engine.Builders.LevelBuilder();
		}
		
		private static function createAvatarManager(){
			avatarManager = new AvatarManager();
		}
		
		private static function createBulletManager(){
			bulletManager = new BulletManager();
		}
		
		private static function createEnemyManager(){
			enemyManager = new EnemyManager();
		}
		
		private static function createCombatManager(){
			combatManager = new CombatManager();
		}
		
		private static function createLootManager(){
			lootManager = new LootManager();
		}
		
		
		
		private static function masterLoop(event:Event){
			if(!gamePaused){
				updateAvatarManager();
				updateBulletManager();
				updateEnemyManager();
				updateLootManager();
				//updateCombatManager();
				updateUIManager();
			}else{
				//can use this for when the game is paused but I still need to update UI stuff
			}
		}
		
		private static function updateAvatarManager(){
			avatarManager.updateLoop();
		}
		
		private static function updateBulletManager(){
			bulletManager.updateLoop();
		}
			
		private static function updateEnemyManager(){
			//var avatarLocation:Point = new Point(Main.avatar.x,Main.avatar.y);
			enemyManager.updateLoop();
		}
		
		private static function updateLootManager(){
			//var avatarLocation:Point = new Point(Main.avatar.x,Main.avatar.y);
			lootManager.updateLoop();
		}
		
		
		//for when you need to communicate things to the UI manager
		private static function updateUIManager(){
			//uiManager.updateLoop();
		}
		
		public static function pauseGame(){
			gamePaused = true;
			bulletManager.pauseAllBulletTimes()
		}
		
		public static function resumeGame(){
			gamePaused = false;
			bulletManager.resumeAllBulletTimes()
		}
		
		public static function getBulletManager(){
			return bulletManager;
		}
		
		public static function getGameContainer():MovieClip{
			return gameContainer;
		}
		
		/*public static function addActorToGameContainer(actor){
			gameContainer.addChild(actor);
		}*/
	}
}