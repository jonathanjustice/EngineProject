package utilities.Actors.LootDrops{
	import utilities.Actors.LootDrops.LootDrop;
	public class LootDrop_Coin extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_Coin(){
			setUp();
		}
		
		public function setUp(){
			defineGraphics();
		}
			
		public override function defineProperties(){
			var newCoin;
			if(amount <= 5){
				//newCoin = new graphic_CoinSmall();
			}else if(amount > 5 && amount <= 25){
				//newCoin = new graphic_CoinLarge();
			}else if(amount > 5 && amount <= 100){
				//newCoin = new graphic_CoinBag();
			}else if(amount > 5 && amount <= 500){
				//newCoin = new graphic_CoinBars();
			}else if(amount > 5 && amount <= 5000){
				//newCoin = new graphic_CoinBars();
			}
			this.addChild(newCoin);
		}
	}
}