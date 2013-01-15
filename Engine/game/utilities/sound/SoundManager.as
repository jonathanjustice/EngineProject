package{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	public class SoundManager extends MovieClip{
		
		
		// this is the only way to set volume for sounds
		//private var drainTransform:SoundTransform = new SoundTransform(0.1);	
		private var musicChannel:SoundChannel = new SoundChannel;
		private var sxfChannel_01:SoundChannel = new SoundChannel;
		private var musicSound:Sound = new Sound(new URLRequest("GuileTheme.mp3"));
		public var sfxType:String = "";
		
		public function SoundPlayer():void{
			
			//requestSounds();
		}
		
		public function setUpSounds():void{
			musicSound.addEventListener(Event.COMPLETE, LOAD_music);
		}
		
		private function LOAD_music($evt:Event):void{
			musicSound.removeEventListener(Event.COMPLETE, LOAD_music);
			playMusic();
      	}
		
		public function playMusic():void{
			var musicVolume = .15;
			var myTransform:SoundTransform = new SoundTransform(musicVolume,0);
            musicChannel.soundTransform = myTransform;
			musicChannel = musicSound.play(0, int.MAX_VALUE);
			musicChannel.soundTransform = myTransform;
		}
		
		public function stopAllSoundChannels():void{
			sxfChannel_01.stop();
		}
	}
}