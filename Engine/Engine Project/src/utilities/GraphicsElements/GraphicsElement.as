package utilities.GraphicsElements{
	import flash.display.Graphics;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import utilities.GraphicsElements.Test_rect;
	import utilities.GraphicsElements.Test_square;
	public class GraphicsElement extends MovieClip{
		private var myGraphic:Sprite = new Sprite(); 
		public var newGraphic:MovieClip = new MovieClip(); 
		
		public function GraphicsElement():void{
			
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		public function drawGraphic():void{
			myGraphic.graphics.lineStyle(3,0x00ff00);
			myGraphic.graphics.beginFill(0x0000FF);
			myGraphic.graphics.drawRect(0,0,75,75);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
		
		public function drawGraphic2():void{
			/*myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x0000FF);
			myGraphic.graphics.drawRect(0,0,100,100);
			myGraphic.graphics.endFill();
			myGraphic.x = -50;
			myGraphic.y = -50;*/
			//this.addChild(myGraphic);
			var newGraphic:utilities.GraphicsElements.Test_rect = new utilities.GraphicsElements.Test_rect();
			//var newGraphic:utilities.GraphicsElements.Test_square = new utilities.GraphicsElements.Test_square();
			//newGraphic.scaleX = 1;
			//newGraphic.scaleY = 1;
			trace("graphics elemenet: newGraphic.width",newGraphic.width);
			newGraphic.x = -1* (newGraphic.width/2);
			newGraphic.y = -1 * (newGraphic.height/2);
			trace("graphics elemenet: newGraphic.width",newGraphic.width);
			this.addChild(newGraphic);
			//trace()
		}
		
		public function drawGraphic3():void{
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,100,100);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}
