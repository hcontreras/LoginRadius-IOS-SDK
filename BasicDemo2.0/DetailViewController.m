//
//  DetailViewController.m
//  BasicDemo2.0
//
//  Created by Lucius Yu on 2014-12-05.
//  Copyright (c) 2014 LoginRadius. All rights reserved.
//

#import "DetailViewController.h"
#import "LoginRadiusConfiguration.h"
#import <LoginRadius/LoginRadiusLoginViewController.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [LoginRadiusLoginViewController class];
    LoginRadiusLoginViewController *loginViewController;
    loginViewController = segue.destinationViewController;
    loginViewController.siteName = CLIENT_SITENAME;
    loginViewController.apiKey = API_KEY;
    loginViewController.identifier = @"dataViewController";
    NSLog(@"Prepare for Segue: %@", segue.identifier);
    
    if( [segue.identifier isEqualToString:@"fbLoginSegue"] ) {
        loginViewController.provider = @"facebook";
    } else if( [segue.identifier isEqualToString:@"twitterLoginSegue"] ) {
        loginViewController.provider = @"twitter";
    } else if( [segue.identifier isEqualToString:@"linkedinLoginSegue"] ) {
        loginViewController.provider = @"linkedin";
    } else {
        // Only google left
        loginViewController.provider = @"google";
    }
    
    
}

@end
