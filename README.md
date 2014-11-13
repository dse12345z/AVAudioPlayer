DSKPlayer
=============
DSKPlayer 簡單的播放器結合 FinishPlaying Block

使用方法
=============

[DSKPlayer playMP3Name:@"Westlife - My Love" completion: ^{  
　　　// play finish do something ...  
}];  
  
  
  
設置播放時間  
[DSKPlayer setCurrentTime:(int)];

播放  
[DSKPlayer play];

暫停  
[DSKPlayer pause];

判斷是否播放中  
[DSKPlayer isPlaying];

當前播放時間  
[DSKPlayer currentTime];

音樂總長時間  
[DSKPlayer duration];
