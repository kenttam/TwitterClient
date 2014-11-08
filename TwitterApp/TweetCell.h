//
//  TweetCell.h
//  TwitterApp
//
//  Created by Kent Tam on 11/2/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol TweetCellDelegate;


@interface TweetCell : UITableViewCell

@property (strong, nonatomic)Tweet *tweet;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@end

@protocol TweetCellDelegate <NSObject>

- (void)didChooseView:(NSString *)view user:(User *)user;

@end