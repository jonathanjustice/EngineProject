﻿package utilities.Actors.LootDrops{
	import utilities.Actors.LootDrops.LootDrop;
	public class LootDrop_DNA extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_DNA(){
			setUp();
		}
		
		public function setUp(){
			defineGraphics();
		}
			
		public override function defineProperties(){
			//var newDNA = new graphics_DNA();
			//this.addChild(newDNA);
		}
	}
}