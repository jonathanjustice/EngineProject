package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;

	public class Wall extends utilities.Actors.Actor{
		private var isBulletBlocker:Boolean=false;;
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