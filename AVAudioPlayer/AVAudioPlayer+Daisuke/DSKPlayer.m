//
//  DSKPlayer.m
//
//  Created by daisuke on 2014/10/24.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import "DSKPlayer.h"

#import <objc/runtime.h>

#define AVAudioPlayerIsNull(obj) if (!obj) { NSLog((@"%s [Line %d] AVAudioPlayer%@"), __PRETTY_FUNCTION__, __LINE__, obj); }

@interface DSKPlayer (Private)

+ (void)setPlayFinishCallBackBlock:(PlayFinishCallBackBlock)finishCallBack;
+ (PlayFinishCallBackBlock)getPlayFinishCallBackBlock;

@end

static DSKPlayer *shared = nil;

@implementation DSKPlayer

+ (void)playMP3Name:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion {
	[[DSKPlayer shared] playMP3Name:mp3Name fromDocument:PathFromBoth completion:completion];
}

+ (void)playMP3NameFromDocument:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion {
	[[DSKPlayer shared] playMP3Name:mp3Name fromDocument:PathFromDocument completion:completion];
}

+ (void)playMP3NameFromResource:(NSString *)mp3Name completion:(PlayFinishCallBackBlock)completion {
	[[DSKPlayer shared] playMP3Name:mp3Name fromDocument:PathFromResource completion:completion];
}

+ (void)setCurrentTime:(int)time {
	[[DSKPlayer shared] setCurrentTime:time];
}

+ (void)play {
	[[DSKPlayer shared] play];
}

+ (void)pause {
	[[DSKPlayer shared] pause];
}

+ (int)currentTime {
	return [[DSKPlayer shared] currentTime];
}

+ (int)duration {
	return [[DSKPlayer shared] duration];
}

+ (BOOL)isPlaying {
    return [[DSKPlayer shared] isPlaying];
}

#pragma mark - private function

+ (DSKPlayer *)shared {
	@synchronized(self)
	{
		if (shared == nil) {
			shared = [[self alloc] init];
		}
	}
	return shared;
}

- (void)playMP3Name:(NSString *)mp3Name fromDocument:(PathFrom)pathFromIndex completion:(PlayFinishCallBackBlock)completion {
	[self setPlayFinishCallBackBlock:completion];
    
	NSString *path = [self pathMp3Name:mp3Name fromDocument:pathFromIndex];

	if (path) {
		self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
		self.audioPlayer.delegate = (id <AVAudioPlayerDelegate> )self;
		[self.audioPlayer prepareToPlay];
		[self.audioPlayer play];
	}
	else {
		self.getPlayFinishCallBackBlock();
	}
}

- (BOOL)isPlaying {
	AVAudioPlayerIsNull(self.audioPlayer);
	return self.audioPlayer.isPlaying;
}

- (void)setCurrentTime:(int)time {
	AVAudioPlayerIsNull(self.audioPlayer);
	self.audioPlayer.currentTime = time;
}

- (void)play {
	AVAudioPlayerIsNull(self.audioPlayer);
	[self.audioPlayer play];
}

- (void)pause {
	AVAudioPlayerIsNull(self.audioPlayer);
	[self.audioPlayer pause];
}

- (int)currentTime {
	AVAudioPlayerIsNull(self.audioPlayer);
	return self.audioPlayer.currentTime;
}

- (int)duration {
	AVAudioPlayerIsNull(self.audioPlayer);
	return self.audioPlayer.duration;
}

- (NSString *)pathMp3Name:(NSString *)mp3Name fromDocument:(PathFrom)pathFromIndex {
	NSString *path;
	switch (pathFromIndex) {
		case PathFromBoth:
		case PathFromDocument:
		{
			NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			path = [[documentPath objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@.mp3", mp3Name]];

			NSFileManager *fileManager = [NSFileManager defaultManager];
			if ([fileManager fileExistsAtPath:path]) {
				return path;
			}

			// PathFromBoth: 先從 Document 找檔案，沒有再從 Resource
			if (pathFromIndex != PathFromBoth) {
				return nil;
			}
		}

		case PathFromResource:
		{
			path = [[NSBundle mainBundle] pathForResource:mp3Name ofType:@".mp3"];
			return path;
		}
	}
}

#pragma mark - AVAudioPlayer delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	self.getPlayFinishCallBackBlock();
}

#pragma mark - access object

- (void)setPlayFinishCallBackBlock:(PlayFinishCallBackBlock)finishCallBack {
	objc_setAssociatedObject(self, @selector(getPlayFinishCallBackBlock), finishCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (PlayFinishCallBackBlock)getPlayFinishCallBackBlock {
	return objc_getAssociatedObject(self, _cmd);
}

@end
