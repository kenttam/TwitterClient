//
//  ProfileViewController.h
//  TwitterApp
//
//  Created by Kent Tam on 11/6/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) User *user;
- (id) initWithUser:(User *)user;
@end
