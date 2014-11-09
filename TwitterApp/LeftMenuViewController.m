//
//  LeftMenuViewController.m
//  TwitterApp
//
//  Created by Kent Tam on 11/6/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "User.h"

@interface LeftMenuViewController ()
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onProfileButtonTap:(id)sender {
    id<LeftMenuViewControllerDelegate> strongDelegate = self.delegate;
    
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([strongDelegate respondsToSelector:@selector(leftMenuViewController:didChooseView:user:)]) {
        [strongDelegate leftMenuViewController:self didChooseView:@"profile" user:[User currentUser]];
    }
}
- (IBAction)onTimelineTap:(id)sender {
    id<LeftMenuViewControllerDelegate> strongDelegate = self.delegate;
    
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([strongDelegate respondsToSelector:@selector(leftMenuViewController:didChooseView:user:)]) {
        [strongDelegate leftMenuViewController:self didChooseView:@"timeline" user:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
