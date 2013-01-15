package utilities.Actors{
	import flash.display.MovieClip;
	import utilities.Screens.progressBar;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.*;
	import utilities.Actors.LootDrops.*;
	import utilities.Actors.TreasureChest;
	import utilities.Engine.Builders.LootManager;
	import utilities.Actors.Stats.WeaponStats;
	import utilities.GraphicsElements.GraphicsElement;
	import utilities.Mathematics.QuadTree;
	import flash.geom.Point;
	
	public class Actor extends MovieClip{
		private var markedForDeletion:Boolean=false;
		private var availableForTargeting:Boolean=true;
		private var progressBar;
		private var progressBarGraphic;
		private var highLight;
		private var mass;
		private var previousPosition:Point = new Point(0,0);
		private var quadTreeNode;
		private var weaponStats;
		private var actorGraphic;
		private var target:MovieClip;
		private var hasTarget:Boolean = false;
		public var health:Number=1;
		
		private static var test:Test = new Test();
		
		public function Actor(){
			defineWeaponStats();
			//trace("Actor:new actor")
		}
		
		//BEHAVIOR SECTION
		//This needs to be put somewhere else, this is an awful place for it as long as I am using 1 giant master stats file
		//might make sense once once things are more generative...
		public function defineWeaponStats(){
			//trace("Actor:define stats");
			weaponStats = new utilities.Actors.Stats.WeaponStats();
		}
		
		
		//flag actor for deletion, normally on death, collision or time out
		public function markDeathFlag(){
			markedForDeletion = true;
			availableForTargeting = false;//prevent null reference errors
		}
		
		//determine what needs to be deleted and then delete it
		public function checkForDeathFlag(){
			if(markedForDeletion){
				//delete it
				if(this is Bullet){
					removeActorFromGameEngine(this,Game.bulletManager.getArray());
				}else if(this is Enemy){
					//delete it
					removeActorFromGameEngine(this,Game.enemyManager.getArray());
				}else if(this is LootDrop){
					removeActorFromGameEngine(this,Game.lootManager.getTreasureChestArray());
				}
				else if(this is TreasureChest){
					removeActorFromGameEngine(this,Game.lootManager.getTreasureChestArray());
				}/*
				else if(this == CardDrop){
					//removeActorFromGameEngine(this,Game.lootManager.getArray());;
				}*/
			}
		}
		
		//DISPLAY & FEEDBACK SECTION
		
		
		//create the grapic for the actor
		//uses a default vector rectangle if nothing else is defined 
		public function defineGraphics(){
			actorGraphic = new utilities.GraphicsElements.GraphicsElement();
			actorGraphic.drawGraphic();
			this.addChild(actorGraphic);
		}
		
		public function defineGraphics2(){
			actorGraphic = new utilities.GraphicsElements.GraphicsElement();
			actorGraphic.drawGraphic2();
			this.addChild(actorGraphic);
		}
		
		public function createProgressBar(bar){
			/*switch(bar){
				case "Basic":
					progressBarGraphic = new ProgressGraphic_Basic();
					this.addChild(progressBarGraphic);
					break;
				case "Circular":
					progressBarGraphic = new ProgressGraphic_Basic();
					this.addChild(progressBarGraphic);
					break;
			}*/
		}
		
		//normally used for health bars or timed bars that fill up or down
		public function updateProgressBarGraphic(amount){
			//progressBarGraphic.innerBar.scaleX = amount/100;
		}
		
		//for only showing progress or health bars when necessary
		//
		public function setProgressBarVisibility(visibility){
			if (visibility == true){
				//progressBarGraphic.visible = true;
			}
			if (visibility == false){
				//progressBarGraphic.visible = false;
			}
		}
		
		//used for highlighting things, usually on roll-over or collision
		public function setHighlightState(highlightState){
			if (highlightState == true){
				//highLight.visible = true;
			}
			if (highlightState == false){
				//highLight.visible = false;
			}
		}
		
		//this also needs to send the type
		//or maybe I can just determine the type in the factory
		public function send_Loot_Data_To_Factory(){
			LootManager.lootFactory.generateLoot(this.x,this.y);
			
		}
		
		public function defineProperties(){
			
		}
		
		public function getLocation():Point{
			var point:Point=new Point(this.x,this.y);
			return point;
		}
		
		public function getX():Number{
			return this.x;
		}
		
		public function getY():Number{
			return this.y;
		}
		
		//useful for collision detection, in case the object gets into an invalid location
		public function setPreviousPosition(){
			previousPosition.x = this.x;
			previousPosition.y = this.y;
		}
		
		//useful for collision detection, in case the object gets into an invalid location
		public function getPreviousPosition(){
			return previousPosition;
		}
		
		//returns the angle in god-awful flash degrees
		//convert it somewhere else if you want, try one of the MathFormulas functions
		public function getAngle():Number{
			return this.rotation;
		}
		
		
		public function setQuadTreeNode(){
			quadTreeNode = QuadTree.setNode(this);
			//trace("node",node);
		}
		
		//needs to have quadtree class updated so it works right
		public function getQuadTreeNode(){
			return quadTreeNode;
		}
		
		public function addActorToGameEngine(){
			utilities.Engine.Game.gameContainer.addChild(this);
		}
		
		public function removeActorFromGameEngine(actor,array){
			actor.availableForTargeting=false;
			var index:int = array.indexOf(actor);
			array.splice(index,1);
			utilities.Engine.Game.gameContainer.removeChild(actor);
			actor.setTargetToFalse();
		}
		
		public function testFunction(){
			trace(this,"class exists, probably means you fucked up somewhere else, or you can't access the object you want inside the class.")
		}
		
		public function get_availableForTargeting():Boolean{
			return availableForTargeting;
		}
		
		public function set_availableForTargetingToTrue(){
			availableForTargeting = true;
		}
		
		public function setTarget(newTarget){
			//trace("Bullet: setTarget");
			if(target == newTarget){
				trace("the old and new targets werer the same: what happened?");
			}
			target = newTarget;
			setTargetToTrue();
		}
		
		public function getTarget(){
			return target;
		}
		
		public function getActor():Object{
			return this;
		}
		
		public function get_hasTargetFlag(){
			return hasTarget;
		}
		
		public function setTargetToFalse(){
			hasTarget = false;
			target = null;
		}
		public function setTargetToTrue(){
			hasTarget = true;
		}
	}
}