//
//  ProfileViewController.m
//  TwitterApp
//
//  Created by Kent Tam on 11/6/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "TweetCell.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) TweetCell *prototypeTweetCell;
@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self render];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithUser:(User *)user{
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

- (void)render {
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = self.user.screenname;
    NSString *profileImageURL = self.user.profileImageUrl;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:profileImageURL]];
    self.numFollowersLabel.text = [self.user.numFollowers stringValue];
    self.numFollowingLabel.text = [self.user.numFollowing stringValue];
    self.numTweetsLabel.text = [self.user.numTweets stringValue];
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
