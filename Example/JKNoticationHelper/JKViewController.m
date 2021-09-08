//
//  JKViewController.m
//  JKNoticationHelper
//
//  Created by xindizhiyin2014 on 09/11/2019.
//  Copyright (c) 2019 xindizhiyin2014. All rights reserved.
//

#import "JKViewController.h"
#import <JKNoticationHelper/JKNoticationHelper.h>

@interface JKViewController ()

@end

@implementation JKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self observeNotificationForName:@"aaaa" usingBlock:^(NSNotification *notification) {
        NSLog(@"jkjkjk");
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, 60, 60);
    [self.view addSubview:button];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"aaaa" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
