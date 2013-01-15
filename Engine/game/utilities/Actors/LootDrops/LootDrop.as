package utilities.Actors.LootDrops{
	import utilities.Actors.Actor;
	public class LootDrop extends utilities.Actors.Actor{
		
		//public var lootAmount:Number=1;
		
		public function LootDrop(){
			
		}
		
		public override function defineProperties(){
			
		}
		
		public static function setAmount(amt){
			trace("set amount");
			//trace("amount",lootAmount);
			//lootAmount = amt;
		}
		
		public function move_loot_to_target(){
			//only do this if the math doesn't slow the game down too much
		}
		
		public function addLootToTotals(){
			
		}
		
		public function playCollectedAnimation(){
			
		}
		
	}
}