AVAudioPlayer
=============
AVAudioPlayer 簡單的播放器結合 FinishPlaying Block

使用方法
=============

[AVAudioPlayer playMP3Name:@"Westlife - My Love" completion: ^{  
	    // play finish do something ...  
	}];  
	
其他方法跟原生差不多:

設置播放時間  
[AVAudioPlayer setCurrentTime:(int)];

播放  
[AVAudioPlayer play];

暫停  
[AVAudioPlayer pause];

判斷是否播放中  
[AVAudioPlayer isPlaying];

當前播放時間  
[AVAudioPlayer currentTime];

音樂總長時間  
[AVAudioPlayer duration];
