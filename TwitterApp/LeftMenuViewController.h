//
//  LeftMenuViewController.h
//  TwitterApp
//
//  Created by Kent Tam on 11/6/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "User.h"

@protocol LeftMenuViewControllerDelegate;

@interface LeftMenuViewController : UIViewController
@property (nonatomic, weak) id<LeftMenuViewControllerDelegate> delegate;

- (IBAction)onProfileButtonTap:(id)sender;
@end
@protocol LeftMenuViewControllerDelegate <NSObject>

- (void)leftMenuViewController:(LeftMenuViewController *)viewController didChooseView:(NSString *)view user:(User *)user;

@end