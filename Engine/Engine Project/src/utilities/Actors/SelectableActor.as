package utilities.Actors{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
	public class SelectableActor extends Actor{
		private var selected:Boolean = false;
		public function SelectableActor(){
			this.addEventListener(MouseEvent.CLICK, clickedActor);
		}
		
		private function clickedActor(event:MouseEvent):void {
			if (selected) {
				deselectActor();
			}else {
				selectActor();
			}
		}
		
		public function deselectActor():void {
			trace("deselect");
			selected = false;
			removeStroke();
		}
		
		public function selectActor():void {
			trace("select");
			selected = true;
			addStroke();
		}
		
		public function addStroke():void {
			var glowFilter:BitmapFilter = getGlowFilter();
			filters = [ glowFilter ];
		}
		
		private function getGlowFilter():BitmapFilter {
            var color:Number = 0x00ff00;
            var alpha:Number = 1;
            var blurX:Number = 10;
            var blurY:Number = 10;
            var strength:Number = 2;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.HIGH;

            return new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner,knockout);
        }
		
		public function removeStroke():void {
			var glowFilter:BitmapFilter = clearGlowFilter();
			filters = [ glowFilter ];
		}
		
		private function clearGlowFilter():BitmapFilter {
            var color:Number = 0x000000;
            var alpha:Number = 1;
            var blurX:Number = 0;
            var blurY:Number = 0;
            var strength:Number = 0;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.LOW;

            return new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner,knockout);
        }
	}
}