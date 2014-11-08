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
    self.profileImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(onTap:)];
    tgr.delegate = self;
    [self.profileImageView addGestureRecognizer:tgr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    NSString *imageURL = self.tweet.user.profileImageUrl;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = self.tweet.user.screenname;
    self.tweetLabel.text = self.tweet.text;
    self.timeAgoLabel.text = [self.tweet.createdAt timeAgo];
}

- (void)onTap:(UITapGestureRecognizer *)tgr
{
    NSLog(@"tapped");
    id<TweetCellDelegate> strongDelegate = self.delegate;
    
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([strongDelegate respondsToSelector:@selector(didChooseView:user:)]) {
    NSLog(@"inside block");
        [strongDelegate didChooseView:@"profile" user:self.tweet.user];
        
    }
    
}

@end
