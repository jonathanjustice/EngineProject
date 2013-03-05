package utilities.Engine{
	import flash.display.MovieClip;
	import utilities.Actors.Actor;
	import flash.geom.Point;
	import utilities.Actors.SelectableActor;
	public class DefaultManager extends MovieClip{
		
		public function DefaultManager(){
			
		}
		
		public function testFunction():void{
			trace(this,"class exists, probably means you fucked up somewhere else")
		}
		
		public function updateLoop():void{
			
		}
		
		public function getArray():Array{
			var array:Array = new Array();
			return array;
		}
		
		public function get_Index_of_actor_in_array(actor:MovieClip,array:Array):int{
			array = getArray();
			var index:int = array.indexOf(actor);
			return index;
		}
		
		public function getArrayLength():int{
			var array:Array = new Array(); 
			return array.length-1;
		}
		
		public function deslectAll():void {
			
		}
		
		public function allItemsCollidingWithMouse(array:Array):Array {
			var colldingWithMouse:Array = new Array();
			var mousePoint:Point = new Point();
				mousePoint = Main.getMouseCoordinates();
			for each(var actor:SelectableActor in array) {
				
				if (actor.hitTestPoint(mousePoint.x,mousePoint.y)) {
					colldingWithMouse.push(actor);
				}
				/*if (actor.getIsSelected() == true) {
					colldingWithMouse.push(actor);
				}*/
			}
			//trace("colldingWithMouse",colldingWithMouse);
			return colldingWithMouse;
		}
		
		public function allItemsSelected(array:Array):Array {
			var selectedItems:Array = new Array();
			var mousePoint:Point = new Point();
				mousePoint = Main.getMouseCoordinates();
			for each(var actor:SelectableActor in array) {
				if (actor.getIsSelected() == true) {
					if (actor.hitTestPoint(mousePoint.x,mousePoint.y)) {
						//don't unselect it
					}else {
						selectedItems.push(actor);
					}
				}
			}
			//trace("selectedItems",selectedItems);
			return selectedItems;
		}
	}
}