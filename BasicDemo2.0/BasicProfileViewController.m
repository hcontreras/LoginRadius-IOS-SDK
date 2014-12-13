//
//  DataViewController.m
//  BasicDemo2.0
//
//  Created by Lucius Yu on 2014-12-08.
//  Copyright (c) 2014 LoginRadius. All rights reserved.
//

#import "BasicProfileViewController.h"
#import <LoginRadius/LoginRadiusService.h>
#import <LoginRadius/LoginRadiusComposeViewController.h>
#import <Social/Social.h>

@interface BasicProfileViewController ()

@end

@implementation BasicProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadBasicProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadBasicProfile {
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Retrieve the Access Token assigned by LoginRadius
        loginradiusUserData = [NSUserDefaults standardUserDefaults];
        token = [loginradiusUserData stringForKey:@"token"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Call UserProfile API through LoginRadiusService API
            LoginRadiusService *service = [[LoginRadiusService alloc] init];
            [service loginradiusUserProfile:token];
            [spinner stopAnimating];
            [self updateUI];
            
        });
    });
}

- (void)updateUI {
    
    // Retrieve data object from returned Dictionary
    NSDictionary *userProfile = [loginradiusUserData dictionaryForKey:@"userProfile"];
    NSLog(@" User Profile : %@", userProfile);
    // Update UI
    NSLog(@"This is the second step");
    // Get data for all the labels.
    self.nameLabel.text = [userProfile objectForKey: @"FirstName"];
    self.cityLabel.text = [userProfile objectForKey: @"LocalCity"];
    self.providerLabel.text = [userProfile objectForKey: @"Provider"];
    
    NSArray *emailDictionary = [userProfile valueForKeyPath: @"Email"];
    if ([emailDictionary isKindOfClass:[NSArray class]]) {
        NSString *userEmail = [[emailDictionary objectAtIndex:0] objectForKey:@"Value"];
        self.emailLabel.text = userEmail;
    }
    
    NSString *imageURL = [userProfile objectForKey:@"ImageUrl"];
    //NSLog(@" user image url: %@", imageURL);
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    self.profileImage.image = [UIImage imageWithData:imageData];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
        //NSLog(@"image Data: %@", imageData);
        if ( imageData == nil ){
            NSLog(@" returned profile image data is nil ");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profileImage.image = [UIImage imageWithData: imageData];
        });
    });
    
    NSLog(@"%@/%@/%@/%@", [userProfile objectForKey: @"FirstName"],[userProfile objectForKey: @"Age"],[userProfile objectForKey: @"LocalCity"],[userProfile objectForKey: @"Provider"]);
}

- (IBAction)logoutClick:(id)sender {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
    NSLog(@" Cookies has been successfully removed" );
}

- (IBAction)postStatus:(id)sender {
    NSDictionary *userProfile = [loginradiusUserData dictionaryForKey:@"userProfile"];
    NSString *provider = [userProfile objectForKey:@"Provider"];
    NSLog(@"post status for %@", provider);
    
    // Post a status
    if ([provider isEqualToString:@"facebook"]) {
        LoginRadiusComposeViewController *composeViewComposer = [[LoginRadiusComposeViewController alloc] init];
        [composeViewComposer postFacebookStatus: self];
    } else if ([provider isEqualToString:@"twitter"]) {
        LoginRadiusComposeViewController *composeViewComposer = [[LoginRadiusComposeViewController alloc] init];
        [composeViewComposer postTwitterStatus: self];
    }
    
}
@end
