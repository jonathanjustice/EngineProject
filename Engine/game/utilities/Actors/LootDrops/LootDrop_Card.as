﻿package utilities.Actors.LootDrops{
	import utilities.Actors.LootDrops.LootDrop;
	import flash.display.MovieClip;
	public class LootDrop_Card extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_Card(){
			trace("card");
			trace(this.x,this.y);
			setUp();
		}
		
		public function setUp(){
			defineGraphics();
		}
			
		public override function defineProperties(){
			var newCard = new MovieClip;
			//var newCard = new graphics_Card();
			this.addChild(newCard);
		}
	}
}