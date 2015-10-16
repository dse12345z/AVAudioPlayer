//
//  ViewController.m
//  AVAudioPlayer
//
//  Created by daisuke on 2014/11/10.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)currentTimeAction:(id)sender {
    NSLog(@"%d", [DSKPlayer currentTime]);
}

- (IBAction)setTimeAction:(id)sender {
    [DSKPlayer setCurrentTime:[DSKPlayer duration] - 5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DSKPlayer playMP3:@"Westlife - My Love" pathType:PathTypeFromDefault completion: ^{
        // play finish do something ...
    }];
    
    /*
    [DSKPlayer playMP3:@"https://www.dropbox.com/s/xbww361mt0dpocs/Westlife%20-%20My%20Love.mp3?dl=1" pathType:PathTypeFromURL completion: ^{
        // play finish do something ...
    }];*/
}

@end
