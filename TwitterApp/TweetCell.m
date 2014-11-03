//
//  TweetCell.m
//  TwitterApp
//
//  Created by Kent Tam on 11/2/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+TimeAgo.h"

@interface TweetCell()
-(void) setTweet:(Tweet *) tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@end
@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    NSString *imageURL = self.tweet.user.profileImageUrl;
    NSLog(@"%@", imageURL);
    [self.profileImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = self.tweet.user.screenname;
    self.tweetLabel.text = self.tweet.text;
    self.timeAgoLabel.text = [self.tweet.createdAt timeAgo];
}

@end
