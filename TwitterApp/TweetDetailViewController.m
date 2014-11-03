//
//  TweetDetailViewController.m
//  TwitterApp
//
//  Created by Kent Tam on 11/2/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = self.tweet.user.screenname;
    self.tweetLabel.text = self.tweet.text;
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.tweet.createdAt
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    self.timestampLabel.text = dateString;
    NSString *imageURL = self.tweet.user.profileImageUrl;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onReply:(id)sender {
}
- (IBAction)onRetweet:(id)sender {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init ];
    
    dictionary[@"id"] = self.tweet.tweetID;
    
    NSLog(@"retweet");
    [[TwitterClient sharedInstance] retweetUpdateWithParams:dictionary completion:^(Tweet *tweet, NSError *error) {
        NSLog(@"retweeted");
    }];

}
- (IBAction)onFavorite:(id)sender {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init ];
    
    dictionary[@"id"] = self.tweet.tweetID;
    [[TwitterClient sharedInstance] favoriteUpdateWithParams:dictionary completion:^(Tweet *tweet, NSError *error) {
        NSLog(@"favorited");
    }];
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
