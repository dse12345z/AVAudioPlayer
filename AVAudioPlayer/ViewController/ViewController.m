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
    
    [DSKPlayer playMP3:@"Westlife - My Love" pathType:PathTypeFromBoth completion: ^{
        // play finish do something ...
    }];
}

@end
