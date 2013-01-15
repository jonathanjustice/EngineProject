package utilities.Actors.GameBoardPieces{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Actors.Actor;

	public class Wall extends utilities.Actors.Actor{
		public function Wall(){
			setUp();
		}
		
		public function setUp(){
			defineGraphics2();
			addActorToGameEngine();
			setPreviousPosition();
		}
		
		public function updateLoop(){
			
		}
	}
}