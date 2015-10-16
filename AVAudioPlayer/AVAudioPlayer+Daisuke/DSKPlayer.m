//
//  DSKPlayer.m
//
//  Created by daisuke on 2014/10/24.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import "DSKPlayer.h"

#define AVAudioPlayerIsNull(obj) if (!obj) { NSLog((@"%s [Line %d] AVAudioPlayer%@"), __PRETTY_FUNCTION__, __LINE__, obj); }

@interface DSKPlayer ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) PlayFinishCallBackBlock completion;

@end

@implementation DSKPlayer

#pragma mark - class method

+ (void)playMP3:(NSString *)mp3Name pathType:(PathType)pathType completion:(PlayFinishCallBackBlock)completion {
    [[DSKPlayer shared] playMP3:mp3Name pathType:pathType completion:completion];
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

#pragma mark - private method

+ (DSKPlayer *)shared {
    static DSKPlayer *shared = nil;
    if (!shared) {
        shared = [[self alloc] init];
    }
    return shared;
}

- (void)playMP3:(NSString *)mp3Name pathType:(PathType)pathType completion:(PlayFinishCallBackBlock)completion {
    self.completion = completion;
    NSString *path = [self pathMp3Name:mp3Name fromDocument:pathType];
    if (path) {
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        self.audioPlayer.delegate = (id <AVAudioPlayerDelegate> )self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    else {
        self.completion();
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

- (NSString *)pathMp3Name:(NSString *)mp3Name fromDocument:(PathType)pathType {
    NSString *path;
    switch (pathType) {
        case PathTypeFromDefault:
        {
            path = [self pathMp3Name:mp3Name fromDocument:PathTypeFromDocument];
            if (!path.length) {
                path = [self pathMp3Name:mp3Name fromDocument:PathTypeFromResource];
            }
            break;
        }
            
        case PathTypeFromDocument:
        {
            NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            path = [documentPath[0] stringByAppendingString:[NSString stringWithFormat:@"/%@.mp3", mp3Name]];
            break;
        }
            
        case PathTypeFromResource:
        {
            path = [[NSBundle mainBundle] pathForResource:mp3Name ofType:@".mp3"];
            break;
        }
    }
    
    if (![self isFindMP3:path]) {
        path = [NSString new];
    }
    return path;
}

- (BOOL)isFindMP3:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path] ? YES : NO;
}

#pragma mark - AVAudioPlayer delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.completion();
}

@end
