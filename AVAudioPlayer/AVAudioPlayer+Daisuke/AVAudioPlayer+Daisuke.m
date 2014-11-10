//
//  AVAudioPlayer+Daisuke.m
//
//  Created by daisuke on 2014/10/24.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import "AVAudioPlayer+Daisuke.h"

#import <objc/runtime.h>

@interface AVAudioPlayer (Private)

+ (void)setPlayFinishCallBackBlock:(PlayFinishCallBackBlock)finishCallBack;
+ (PlayFinishCallBackBlock)getPlayFinishCallBackBlock;

@end

static char PLAYFINISHCALLBACKBLOCK;
static char audioPlayerKey;

@implementation AVAudioPlayer (AVAudioPlayer_Daisuke)

+ (void)playMP3Name:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion {
	[self setPlayFinishCallBackBlock:completion];

    // document path
	NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *mp3Path = [documentPath[0] stringByAppendingString:[NSString stringWithFormat:@"/%@.mp3", mp3Name]];
    
    // resource path
    NSString *path = [[NSBundle mainBundle] pathForResource:mp3Name ofType:@".mp3"];
    
    
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:mp3Path] error:NULL];
	audioPlayer.delegate = (id <AVAudioPlayerDelegate> )self;
	[audioPlayer prepareToPlay];
	[audioPlayer play];

	objc_setAssociatedObject(self, &audioPlayerKey, audioPlayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)setCurrentTime:(int)time {
	[self audioPlayer].currentTime = time;
}

+ (void)play {
	[[self audioPlayer] play];
}

+ (void)pause {
	[[self audioPlayer] pause];
}

+ (BOOL)isPlaying {
	if ([self audioPlayer].isPlaying) {
		return YES;
	}

	return NO;
}

+ (int)currentTime {
	return [self audioPlayer].currentTime;
}

+ (int)duration {
	return [self audioPlayer].duration;
}

#pragma mark - access object

+ (AVAudioPlayer *)audioPlayer {
	return objc_getAssociatedObject(self, &audioPlayerKey);
}

+ (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	self.getPlayFinishCallBackBlock();
}

+ (void)setPlayFinishCallBackBlock:(PlayFinishCallBackBlock)finishCallBack {
	objc_setAssociatedObject(self, &PLAYFINISHCALLBACKBLOCK, finishCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (PlayFinishCallBackBlock)getPlayFinishCallBackBlock {
	return objc_getAssociatedObject(self, &PLAYFINISHCALLBACKBLOCK);
}

@end
