//
//  DSKPlayer.h
//
//  Created by daisuke on 2014/10/24.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

typedef enum {
	PathFromDocument = 1,
	PathFromResource = 0,
	PathFromBoth     = -1
} PathFrom;

typedef void (^PlayFinishCallBackBlock)();

@interface DSKPlayer : NSObject

@property (nonatomic, readonly) BOOL isPlaying;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

+ (void)playMP3Name:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion;
+ (void)playMP3NameFromDocument:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion;
+ (void)playMP3NameFromResource:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion;

+ (void)setCurrentTime:(int)time;
+ (void)play;
+ (void)pause;

+ (int)currentTime;
+ (int)duration;

@end
