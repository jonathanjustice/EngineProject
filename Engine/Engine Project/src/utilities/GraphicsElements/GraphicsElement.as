package utilities.GraphicsElements{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import utilities.Actors.SelectableActor;
	import utilities.GraphicsElements.Test_rect;
	import utilities.GraphicsElements.Test_square;
	import utilities.Saving_And_Loading.swfLoader;
	
	
	public class GraphicsElement extends MovieClip {
		/*
		 * File paths for swfs
		 * */
		
		//private var avatar:String = new String("../lib/avatar_swf.swf");
		private var avatar:String = new String("../src/assets/swf_frank.swf");
		private var goon:String = new String("../src/assets/swf_goon.swf");
		private var afs:String = new String("../src/assets/swf_afs.swf");
		private var tank:String = new String("../src/assets/swf_tank.swf");
	//private var wall:String = new String("../src/assets/swf_wall.swf");
		
		/*
		 * Everything else
		 * */
		private var myGraphic:Sprite = new Sprite(); 
		public var newGraphic:MovieClip = new MovieClip(); 
		public var assignedGraphic:MovieClip = new MovieClip(); 
		public var assignedGraphics:Array = new Array();
		private var currentParent:MovieClip = new MovieClip();
		
		public function GraphicsElement():void{
			
		}
		
		//objects in the graphic's swf can be accessed through: assignedGraphics[0].swf_child
		public function assignGraphic(graphic:DisplayObject):void {
			assignedGraphics.push(graphic);
			parent.addChild(graphic);
			//trace("assignedGraphics:", assignedGraphics);
			parent.removeChild(this);
			if (currentParent is SelectableActor) {
				currentParent.addClickability_onLoadComplete(graphic);
			}
		}
		
		//loads a swf based on the filePath from the actor type
		public function loadSwf(filePath:String, swfParent:MovieClip):void {
			currentParent = swfParent;
			switch(filePath) {
				case "frank":
					filePath = avatar;
					break;
				case "goon":
					filePath = goon;
					break;
				case "afs":
					filePath = afs;
					break;
				case "tank":
					filePath = tank;
					break;
				case "wall":
					//filePath = wall;
					break;
				
				
			}
			var loader:swfLoader = new swfLoader();
			loader.beginLoad(this, filePath);
			loader = null;
		}
		
		//format for using movieclips from a MAIN project FLA library
		//used only for quick testing or other stupid bullshit
		public function drawGraphicFromMainFLA():void{
			var newGraphic:utilities.GraphicsElements.Test_rect = new utilities.GraphicsElements.Test_rect();
			this.addChild(newGraphic);
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		
		//wall
		public function drawGraphicDefaultRectangle():void{
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,300,100);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}
