package {
import flash.display.MovieClip;
	public class BitmapDataObject extends MovieClip {
		public function BitmapDataObject() {
			
		}
		
		public function getBitmapData(imageToSaveToBitmap:Object){
			var bitmapDataContainer = new MovieClip();
			//emptyBitmapDataShot.setUp(this);
			//if the game already has some fun bitmap data, erase that business
			if ( bmd ){
				bmd = null;
			}
			//target.width and target.height can also be replaced with a fixed number.
			var bmd : BitmapData = new BitmapData(1280, 1024,true, 0x00000000);
			imageToSaveToBitmap = stage;
			bmd.draw( stage );
			var bitmap:Bitmap = new Bitmap(bmd);
			FAKE_STAGE.addChild(empty);
			bitmapDataContainer.addChild(bm);
			bitmap.x = 0;
			bitmap.y = 0; 
			bitmapDataContainer.x = 0;
			bitmapDataContainer.y = 0;
			bitmapDataContainer.alpha =1;
			//screenShots.push(bitmapDataContainer);
		}
		
	}
}