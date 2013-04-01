﻿package utilities.Engine.Combat{
	import flash.display.MovieClip;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.Avatar;
	import utilities.Engine.LevelManager;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Mathematics.RectangleCollision;
	import flash.geom.Point;
	public class AvatarManager extends utilities.Engine.DefaultManager{
		public static var avatar:MovieClip;
		public static var avatars:Array;
		public function AvatarManager(){
			setUp();			
		}
		
		private function setUp():void{
			avatars =[];
			createAvatar();
		}
		
		public function getAvatarLocation():Point{
			return avatars[0].getAvatarLocation();
		}
		
		public function getAvatarAngle():Number{
			return avatars[0].getAngle();
		}
		
		public function deselectActors():void {
			for each(var myAvatar:Avatar in avatars) {
				myAvatar.deselectActor();
			}
		}
		
		public function deselectSomeActors():void {
			for each(var myAvatar:Avatar in avatars) {
				myAvatar.deselectActor();
			}
		}
		
		public override function updateLoop():void{
			for each(var myAvatar:Avatar in avatars){
				myAvatar.updateLoop();
				
				for(var i:int = 0; i<LevelManager.levels.length;i++){
				//a really uneccessarily long way to write hitTestObject, because I can
					//checks for collision
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.levels[i], true) != false) {
						//resolves the collision & returns if this touched the top of the other object
						if (utilities.Mathematics.RectangleCollision.resolveCollisionBetweenMovingAndStationaryObjects(myAvatar, LevelManager.levels[i])) {
							myAvatar.jumpingEnded();
						}
					}
				}
				for (var j:int = 0; j < EnemyManager.enemies.length;j++){
				//a really uneccessarily long way to write hitTestObject, because I can
					//checks for collision
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, EnemyManager.enemies[j], true) != false) {
						//resolves the collision & returns if this touched the top of the other object
						if (utilities.Mathematics.RectangleCollision.resolveCollisionBetweenMovingAndStationaryObjects(myAvatar, EnemyManager.enemies[j])) {
							myAvatar.jumpingEnded();
							myAvatar.jump();
							EnemyManager.enemies[j].markDeathWithoutXpFlag();
						}
					}
				}
				myAvatar.setPreviousPosition();
			}
		}
		
		private static function createAvatar():void{
			avatar = new utilities.Actors.Avatar();
			avatars.push(avatar);
		}
		
		public override function getArray():Array{
			return avatars;
		}
		
		public function getAvatar():MovieClip{
			return avatars[0];
		}
	}
}
