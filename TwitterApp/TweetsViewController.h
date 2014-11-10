//
//  TweetsViewController.h
//  TwitterApp
//
//  Created by Kent Tam on 11/2/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface TweetsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MainViewController *mainVC;
@property (nonatomic, strong) NSString *mode;
-(void) fetchTweets;
@end
