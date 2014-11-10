//
//  AVAudioPlayer+Daisuke.h
//
//  Created by daisuke on 2014/10/24.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

typedef void (^PlayFinishCallBackBlock)();

@interface AVAudioPlayer (AVAudioPlayer_Daisuke)

// from Document MP3 file
+ (void)playMP3Name:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion;
+ (void)setCurrentTime:(int)time;
+ (void)play;
+ (void)pause;

+ (BOOL)isPlaying;

+ (int)currentTime;
+ (int)duration;

@end
