package utilities.GraphicsElements{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import utilities.GraphicsElements.Test_rect;
	import utilities.GraphicsElements.Test_square;
	import utilities.Saving_And_Loading.swfLoader;
	
	
	public class GraphicsElement extends MovieClip {
		/*
		 * File paths for swfs
		 * */
		private var threeRects:String = new String("../lib/Test_swf.swf");
		private var avatar:String = new String("../lib/avatar_swf.swf");
		
		/*
		 * Everything else
		 * */
		private var myGraphic:Sprite = new Sprite(); 
		public var newGraphic:MovieClip = new MovieClip(); 
		public var assignedGraphic:MovieClip = new MovieClip(); 
		public var assignedGraphics:Array = new Array();
		
		public function GraphicsElement():void{
			
		}
		
		//objects in the graphic's swf can be accessed through: assignedGraphics[0].swf_child
		public function assignGraphic(graphic:DisplayObject):void {
			assignedGraphics.push(graphic);
			this.addChild(graphic);
		}
		
		//loads a swf
		//avatar
		public function loadSwf():void{
			var loader:swfLoader = new swfLoader();
			loader.beginLoad(this, avatar);
			this.addChild(assignedGraphic);
		}
		
		//format for using movieclips from a MAIN project FLA library
		public function drawGraphic2():void{
			var newGraphic:utilities.GraphicsElements.Test_rect = new utilities.GraphicsElements.Test_rect();
			this.addChild(newGraphic);
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		
		//wall
		public function drawGraphic3():void{
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,300,100);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
		
		//goon
		public function drawGraphic4():void{
			myGraphic.graphics.lineStyle(3,0x1111ff);
			myGraphic.graphics.beginFill(0x11FF88);
			myGraphic.graphics.drawRect(0,0,75,75);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
		
		//AFS
		public function drawGraphic5():void{
			myGraphic.graphics.lineStyle(3,0x2266ff);
			myGraphic.graphics.beginFill(0x223322);
			myGraphic.graphics.drawRect(0,0,75,75);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
		
		//Tanks
		public function drawGraphic6():void{
			myGraphic.graphics.lineStyle(3,0x33FF55);
			myGraphic.graphics.beginFill(0x883322);
			myGraphic.graphics.drawRect(0,0,75,75);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}
