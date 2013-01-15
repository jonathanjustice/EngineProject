﻿package utilities.Engine{
	import utilities.Engine.DefaultManager;
	import utilities.Actors.GameBoardPieces.Level;
	import utilities.Actors.GameBoardPieces.Wall;
	import flash.geom.Point;
	public class LevelManager extends utilities.Engine.DefaultManager{
		public static var level;
		public static var levels:Array;
		public function LevelManager(){
			levels =[];
			createLevel();
			trace("level manager");
		}
		
		public function setUp(){
			create_a_bunch_of_walls_forTesting();
		}
		
		public function create_a_bunch_of_walls_forTesting(){
			var theX:Number = 100;
			var theY:Number = 100;
			for(var i:int=0;i<10;i++){
				theX+=50;
				theY+=50;
				var wall = new Wall();
				wall.x=theX;
				wall.y=theY;
				levels.push(wall);
				wall.setPreviousPosition();
			}
		}
		
		public function getLevelLocation():Point{
			return levels[0].getLevelLocation();
		}
		
		public override function updateLoop(){
			for each(var level:Level in levels){
				level.updateLoop();
			}
		}
		
		private static function createLevel():void{
			level = new utilities.Actors.GameBoardPieces.Level();
			levels.push(level);
		}
		
		public override function getArray():Array{
			return levels;
		}
		
		public function getLevel():Object{
			return levels[0];
		}
	}
}
