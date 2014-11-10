AVAudioPlayer
=============
AVAudioPlayer 簡單的播放器結合 FinishPlaying Block

使用方法
=============
[AVAudioPlayer playMP3Name:@"Westlife - My Love" completion: ^{
	    // play finish do something ...
	}];
	
其他方法跟原生差不多:

設置播放時間   + (void)setCurrentTime:(int)time;   [AVAudioPlayer setCurrentTime:(int)];
播放           + (void)play;                       [AVAudioPlayer play];
暫停           + (void)pause;                      [AVAudioPlayer pause];

判斷是否播放中 + (BOOL)isPlaying;                  [AVAudioPlayer isPlaying];

當前播放時間   + (int)currentTime;                 [AVAudioPlayer currentTime];
音樂總長時間   + (int)duration;                    [AVAudioPlayer duration];
