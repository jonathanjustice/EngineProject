package utilities.Audio{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	public class SoundManager extends MovieClip{
		
		
		// this is the only way to set volume for sounds
		//private var soundTransform:SoundTransform = new SoundTransform(0.1);	
		private var soundTransfroms:Array = new Array;
		private var soundEffectsChannels:Array = new Array;
		private var musicChannels:Array = new Array;
		//private var musicChannel:SoundChannel = new SoundChannel;
		private var sxfChannel_01:SoundChannel = new SoundChannel;
		private var musicSound:Sound = new Sound(new URLRequest("GuileTheme.mp3"));
		public var sfxType:String = "";
		
		public function SoundPlayer():void{
			createMusicChannel();
			//requestSounds();
		}
		
		public function createMusicChannel():void {
			var musicChannel:SoundChannel = new SoundChannel();
			//soundChannel.name = "soundysound";
			musicChannels.push(musicChannel);
		//	soundChannel.
			//musicSound
		}
		
		//will get replaced by whatever loading stuff Scott does
		public function loadSound():void{
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
		
		public function stopAllMusicChannels():void{
			for each(var soundChannel:SoundChannel in musicChannels) {
				soundChannel.stop();				
			}
		}
		
		public function stopAllSoundEffectsChannels():void{
			for each(var soundChannel:SoundChannel in soundEffectsChannels) {
				soundChannel.stop();				
			}
		}
	}
}