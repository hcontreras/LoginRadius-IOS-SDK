//
//  DataViewController.h
//  BasicDemo2.0
//
//  Created by Lucius Yu on 2014-12-08.
//  Copyright (c) 2014 LoginRadius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicProfileViewController : UIViewController {
    NSString *token;
    NSUserDefaults *loginradiusUserData;
    UIActivityIndicatorView *spinner;
}


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *providerLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

- (IBAction)postStatus:(id)sender;

/**
 * Calling LoginRadius API to load Basic User Profile
 */
- (void)loadBasicProfile;
/**
 * Update UI from returned data
 */
- (void)updateUI;
/**
 * Logout from the ID_providers, clear the cookies
 */
- (IBAction)logoutClick:(id)sender;
@end
