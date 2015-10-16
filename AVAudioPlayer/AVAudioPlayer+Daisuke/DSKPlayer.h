//
//  DSKPlayer.h
//
//  Created by daisuke on 2014/10/24.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PathTypeFromDefault,
    PathTypeFromDocument,
    PathTypeFromResource,
    PathTypeFromURL
} PathType;

typedef void (^PlayFinishCallBackBlock)();

@interface DSKPlayer : NSObject

/**
 @abstract 設置音樂播放器
 @discussion 播放 Document, Resource 下的 MP3 音樂
 @param mp3Name MP3 檔案名字不用加 "."
 @param pathType 路徑類型, PathTypeFromBoth 先從 Document 找，沒有檔案在從 Resource 裡面找
 @param completion 一首 MP3 播放完成後的回調
 */
+ (void)playMP3:(NSString *)mp3Name pathType:(PathType)pathType completion:(PlayFinishCallBackBlock)completion;

/**
 @abstract 快轉音樂
 @discussion 手動設置音樂播放進度
 @param time 單位 sec
 */
+ (void)setCurrentTime:(int)time;

/**
 @abstract 播放音樂
 */
+ (void)play;

/**
 @abstract 暫停音樂
 */
+ (void)pause;

/**
 @abstract 取得音樂當前播放進度
 @returns 單位 sec
 */
+ (int)currentTime;

/**
 @abstract 取得音樂剩餘進度
 @returns 單位 sec
 */
+ (int)duration;

/**
 @abstract 取得音樂是否正在播放
 @returns YES 為正在播放中
 */
+ (BOOL)isPlaying;

@end
