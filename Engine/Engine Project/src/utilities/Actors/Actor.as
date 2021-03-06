﻿package utilities.Actors{
	import flash.display.AVM1Movie;
	import flash.display.MovieClip;
	import utilities.Screens.progressBar;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.*;
	import utilities.Actors.LootDrops.*;
	import utilities.Actors.TreasureChest;
	import utilities.Engine.Builders.LootManager;
	import utilities.Actors.Stats.WeaponStats;
	import utilities.GraphicsElements.GraphicsElement;
	import utilities.GraphicsElements.Animation;
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.QuadTree;
	import flash.geom.Point;
	
	public class Actor extends MovieClip {
		private var idleImpatientTime:int = 0;
		private var idleTime:int = 0;
		private var maxIdleTime:int = 90;
		private var isIdle:Boolean = true;
		public var assignedGraphic:Array = new Array();
		private var markedForDeletion:Boolean=false;
		private var availableForTargeting:Boolean=true;
		private var progressBar:MovieClip;
		private var progressBarGraphic:MovieClip;
		private var highLight:MovieClip;
		private var mass:Number;
		private var previousPosition:Point = new Point(0,0);
		private var quadTreeNode:int;
		private var weaponStats:Object;
		private var actorGraphic:MovieClip;
		private var target:MovieClip;
		private var hasTarget:Boolean = false;
		public var health:Number = 1;
		public var maximumHealth:Number = 1;
		public var gravity:Number = 4;
		public var originalGravity:Number = 3;
		private var currentGravity:Number=0;
		private var gravityModifier:Number = 2;
		private var maxGravity:Number = 10;
		private var hitBoxWidth:Number = 0;
		private var hitBoxHeight:Number = 0;
		private var isInvincible:Boolean = false;
		private var animationState:String = "idle"
		private var isSwfLoaded:Boolean = false;
		public var xVelocity:Number=0;//velocity
		public var yVelocity:Number=0;
		
		public function Actor(){
			defineWeaponStats();
			setAnimationState("idle");
			//trace("Actor:new actor")
		}
		
		/*
		------------GRAVITY
					
		*/
		public function applyGravity(isGravitySystemEnabled:Boolean):void {
			//trace("isGravitySystemEnabled:",isGravitySystemEnabled);
			if (isGravitySystemEnabled) {
				currentGravity += gravityModifier;
				
				if (currentGravity > maxGravity) {
					currentGravity = maxGravity
				}
				yVelocity += currentGravity;
			}
		}
		
		//usually through jumping
		public function modifiyGravity(gravityModifier:Number):void {
			currentGravity = -gravityModifier;
		}
		
		public function resetGravity():void {
			currentGravity = originalGravity;
		}
		
		/*
		------------BEHAVIOR
					This needs to be put somewhere else, this is an awful place for it as long as I am using 1 giant master stats file
					might make sense once once things are more generative...
		*/
		public function defineProperties():void{
			
		}
		
		public function defineWeaponStats():void{
			weaponStats = new utilities.Actors.Stats.WeaponStats();
		}
					
		public function Point_Actor_At_Target(target:Point):void{
			MathFormulas.Point_Object_At_Target(this,target);
		}
		
		/*
		------------CREATION, DESTRUCTION, DAMAGE & DEATH
					
		*/
					
		//creation & destruction
		public function addActorToGameEngine():void {
			utilities.Engine.Game.gameContainer.addChild(this);
		}
		
		public function removeActorFromGameEngine(actor:MovieClip,array:Array):void{
			actor.availableForTargeting=false;
			var index:int = array.indexOf(actor);
			array.splice(index,1);
			utilities.Engine.Game.gameContainer.removeChild(actor);
			actor.setTargetToFalse();
		}
		
		public function takeDamage(amount:Number):void{
			this.health -= amount;
			checkForDamage();
			trace("Actor: takeDamage: actor:", this);
			trace("Actor: takeDamage: health:",health);
		}
		
		public function checkForDamage():void {
			//trace("Actor: checkForDamage: actor:",this);
			if(health <= 0){
				markDeathFlag();
			}
		}
		
		//flag actor for deletion, normally on death, collision or time out
		public function markDeathFlag():void{
			markedForDeletion = true;
			availableForTargeting = false;//prevent null reference errors
		}
		
		//this is kinda bad, could be more abstract. I don't think i should have to make a billion cases for each and every item in the game
		//determine what needs to be deleted and then delete it
		public function checkForDeathFlag():void{
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
				}else if(this is Powerup_default){
					removeActorFromGameEngine(this,Game.powerupManager.getArray());
				}/*
				else if(this == CardDrop){
					//removeActorFromGameEngine(this,Game.lootManager.getArray());;
				}*/
			}
		}
		
		
		/*
		------------DISPLAY & FEEDBACK
					
		*/
		
		//create the grapic for the actor
		//uses a default vector rectangle if nothing else is defined 
		//filepath is passed in from the actor type
		//graphicsElement handles the loading, poorly :(
		public function defineGraphics(filePath:String):void {
			//trace("filePath:",filePath);
			actorGraphic = new utilities.GraphicsElements.GraphicsElement();
			actorGraphic.loadSwf(filePath,this);
			this.addChild(actorGraphic);
		}
		
		//only used for placeholder graphics where a swf or png does not exist yet
		public function defineGraphicsDefaultRectangle():void{
			actorGraphic = new utilities.GraphicsElements.GraphicsElement();
			actorGraphic.drawGraphicDefaultRectangle();
			this.addChild(actorGraphic);
			
		}
		
		public function createProgressBar(bar:String):void{
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
		public function updateProgressBarGraphic(amount:Number):void{
			//progressBarGraphic.innerBar.scaleX = amount/100;
		}
		
		//for only showing progress or health bars when necessary
		//
		public function setProgressBarVisibility(visibility:Boolean):void{
			if (visibility == true){
				//progressBarGraphic.visible = true;
			}
			if (visibility == false){
				//progressBarGraphic.visible = false;
			}
		}
		
		//used for highlighting things, usually on roll-over or collision
		public function setHighlightState(highlightState:Boolean):void{
			if (highlightState == true){
				//highLight.visible = true;
			}
			if (highlightState == false){
				//highLight.visible = false;
			}
		}
		
		//this also needs to send the type
		//or maybe I can just determine the type in the factory
		public function send_Loot_Data_To_Factory():void{
			LootManager.lootFactory.generateLoot(this.x,this.y);
		}
		
		//this function will thow an undefined object error if runs before the assigned graphic is assigned
		public function playAnimation(animation:String):void {	
			this.assignedGraphic[0].swf_child.gotoAndStop(animation);
			//trace("Actor: playAnimation");
		}
		
		/*
		------------GETTERS & SETTERS
					
		*/
					
		public function getIsIdle():Boolean {
			return isIdle;
		}
					
		public function setIsIdle(idleState:Boolean):void {
			isIdle = idleState;
		}
					
		public function getMaxIdleTime():int {
			return maxIdleTime;
		}
		
		public function setIdleImpatientTime(time:int):void {
			idleImpatientTime = time
		}
		
		public function getIdleImpatientTime():int {
			return idleImpatientTime;
		}
					
		public function getIdleTime():int {
			return idleTime;
		}
		
		public function setIdleTime(time:int):void {
			idleTime = time;
		}
					
		public function getAnimationState():String {
			return animationState;
		}
		
		public function setAnimationState(animState:String):void {
			animationState = animState;
		}
		
		public function getLocation():Point{
			var point:Point=new Point(this.x,this.y);
			return point;
		}

		//useful for collision detection, in case the object gets into an invalid location
		public function setPreviousPosition():void{
			previousPosition.x = this.x;
			previousPosition.y = this.y;
		}
		
		//useful for collision detection
		//in case the object gets into an invalid location
		//you can use this to put it back where it was if a new location cannot be resolved
		public function getPreviousPosition():Point{
			return previousPosition;
		}
		
		//returns the angle in god-awful flash degrees
		//convert it somewhere else if you want, try one of the MathFormulas functions
		public function getAngle():Number{
			return this.rotation;
		}
		
		//use the quadtree class to figure out what node the actor is in
		public function setQuadTreeNode():void{
			quadTreeNode = QuadTree.setNode(this);
			//trace("node",node);
		}
		
		//needs to have quadtree class updated so it works right
		public function getQuadTreeNode():int{
			return quadTreeNode;
		}
		
		public function get_availableForTargeting():Boolean{
			return availableForTargeting;
		}
		
		public function set_availableForTargetingToTrue():void{
			availableForTargeting = true;
		}
		
		public function setTarget(newTarget:MovieClip):void{
			if(target == newTarget){
				trace("Actot: the old and new targets werer the same: what happened?");
			}
			target = newTarget;
			setTargetToTrue();
		}
		
		public function getTarget():MovieClip{
			return target;
		}
		
		public function getActor():MovieClip{
			return this;
		}
		
		public function get_hasTargetFlag():Boolean{
			return hasTarget;
		}
		
		public function get_hitBoxWidth():Number {
			trace("get_hitBoxWidth",hitBoxWidth);
			return hitBoxWidth;
		}
		
		public function get_hitBoxHeight():Number {
			trace("get_hitBoxHeight",hitBoxHeight);
			return hitBoxHeight;
		}
		
		public function setHitBoxWidth(size:Number):void{
			hitBoxWidth = size;
			trace("setHitBoxWidth",size);
		}
		
		public function setHitBoxHeight(size:Number):void{
			hitBoxHeight = size;
			trace("hitBoxHeight",size);
		}
		
		//if this actor is tracking a target
		//force it to no longer track that target
		public function setTargetToFalse():void{
			hasTarget = false;
			target = null;
		}
		public function setTargetToTrue():void{
			hasTarget = true;
		}
		
		public function getIsInvincible():Boolean {
			return isInvincible;
		}
		
		public function setInvincibility(invincibility:Boolean):void {
			isInvincible = invincibility;
		}
		
		public function traceProperties():void {
			trace("health:",health);
			trace("actorGraphic.assignedGraphic",actorGraphic.assignedGraphic);
			trace("actorGraphic.assignedGraphic.mc_circle",actorGraphic.assignedGraphic.mc_circle);
			trace("actorGraphic.assignedGraphic.children",actorGraphic.assignedGraphic.children);
			trace("actorGraphic.assignedGraphic.numChildren",actorGraphic.assignedGraphic.numChildren);
		}
		
		public function testFunction():void{
			trace(this, "Actor: class exists, probably means you fucked up somewhere else, or you can't access the object you want inside the class.");
		}
		
		public function setIsSwfLoaded(loadState:Boolean):void {
			isSwfLoaded = loadState;
		}
		
		public function getIsSwfLoaded():Boolean {
			return isSwfLoaded;
		}
	}
}