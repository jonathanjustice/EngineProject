package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;

	public class Wall extends SelectableActor{
		private var isBulletBlocker:Boolean=false;;
		public function Wall(){
			setUp();
		}
		
		public function setUp():void{
			defineGraphicsDefaultRectangle();
			addActorToGameEngine();
			setPreviousPosition();
		}
		
		public function updateLoop():void{
			
		}
	}
}