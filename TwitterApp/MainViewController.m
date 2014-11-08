//
//  MainViewController.m
//  TwitterApp
//
//  Created by Kent Tam on 11/6/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "MainViewController.h"
#import "TweetsViewController.h"
#import "LeftMenuViewController.h"
#import "ProfileViewController.h"
#import "TweetCell.h"

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

@interface MainViewController () <UIGestureRecognizerDelegate, LeftMenuViewControllerDelegate, TweetCellDelegate >
@property (nonatomic, strong) TweetsViewController *tweetsVC;
@property (nonatomic, strong) LeftMenuViewController *menuVC;
@property (nonatomic, strong) ProfileViewController *profileVC;
@property (nonatomic, strong) UIViewController *currentVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect frame = self.view.bounds;
    self.tweetsVC = [[TweetsViewController alloc]init];
    self.tweetsVC.view.frame = frame;
    self.menuVC = [[LeftMenuViewController alloc]init];
    
    self.menuVC.view.frame = frame;
    self.menuVC.delegate = self;
    [self.view addSubview:self.menuVC.view];
    [self.view addSubview:self.tweetsVC.view];
    
    self.profileVC = [[ProfileViewController alloc]init];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.currentVC = self.tweetsVC;
    [self setUpGestures];
}

- (void)setUpGestures {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.currentVC.view addGestureRecognizer:panRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)movePanel:(id)sender
{
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        if (velocity.x > 0) {
            [self movePanelRight];
        }
        if (velocity.x < 0) {
            [self movePanelToOriginalPosition];
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        // Allow dragging only in x-coordinates by only updating the x-coordinate with translation position.
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
    }
}
- (void)movePanelRight // to show left panel
{
    UIView *childView = self.menuVC.view;
    //[self.view sendSubviewToBack:childView];
    [self.view insertSubview:childView belowSubview:self.currentVC.view];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
     animations:^{
         self.currentVC.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
     }
     completion:^(BOOL finished) {
     }];
}

- (void)movePanelToOriginalPosition
{
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
                     self.currentVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                 }
                 completion:^(BOOL finished) {
                     if (finished) {
                         
                     }
                 }];
}

- (void)leftMenuViewController:(LeftMenuViewController *)viewController didChooseView:(NSString *)view user:(User *)user{
    [self.currentVC.view removeFromSuperview];
    if ([view  isEqual: @"profile"]){
        self.profileVC.user = user;
        self.currentVC = self.profileVC;
    }
        [self.currentVC.view removeFromSuperview];
    if ([view  isEqual: @"timeline"]){
        self.currentVC = self.tweetsVC;
    }
    [self.view addSubview:self.currentVC.view];
    [self movePanelToOriginalPosition];
    [self setUpGestures];
}

- (void)didChooseView:(NSString *)view user:(User *)user{
    [self leftMenuViewController:self.menuVC didChooseView:@"profile" user:user];
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
