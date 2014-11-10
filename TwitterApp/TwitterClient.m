//
//  TwitterClient.m
//  TwitterApp
//
//  Created by Kent Tam on 10/28/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"
#import "User.h"

NSString *const kTwitterConsumerKey = @"WLy1bTh3c3lsV8ATkRiguaJPM";
NSString *const kTwitterConsumerSecret = @"fmRKzN9hoTlihoiWmIlJWc61dhQzrTbZqmlT8eUHlhi6i4d4j6";
NSString *const kTwitterBaseUrl = @"https://api.twitter.com";
@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

- (void) loginWithCompletion:(void (^)(User *, NSError *))completion{
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
        NSLog(@"Got the request token");
    } failure:^(NSError *error) {
        NSLog(@"Failed request token");
        self.loginCompletion(nil, error);
    }];
}

-(void) openURL:(NSURL *)url{
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        NSLog(@"got the access token");
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            NSLog(@"current user: %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed getting current user");
            self.loginCompletion(nil, error);
        }];
    } failure:^(NSError *error) {
    }];
}

-(void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

-(void)mentionsTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/mentions_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

-(void)profileWithParam:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/users/look_up.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

-(void)tweet:(NSDictionary *)params completion:(void (^)(Tweet *tweet, NSError *error))completion{
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

-(void)retweetUpdateWithParams:(NSDictionary *)params completion:(void (^)(Tweet *, NSError *))completion {
    NSNumber *tweetId = params[@"id"];
    
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}

-(void)favoriteUpdateWithParams:(NSDictionary *)params completion:(void (^)(Tweet *, NSError *))completion {
    [self POST:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}

-(void)getBanner:(NSDictionary *)params completion:(void (^)(NSString *, NSError *))completion {
    [self GET:@"1.1/users/profile_banner.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *url = [responseObject valueForKeyPath:@"sizes.ipad_retina.url"];
        completion(url, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}
-(void)getTimeline:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
        NSLog(@"started request");
    [self GET:@"1.1/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response: %@", responseObject);
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error);
        completion(nil, error);
    }];
    
}
@end
