//
//  TweetCell.m
//  twitter
//
//  Created by Alice Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.timelineProfileImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.timelineProfileImage setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.timelineAuthor.text = self.tweet.user.name;
    self.timelineUsername.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.timelineDate.text = self.tweet.createdAtString;
    [self.timelineTweetText setText:self.tweet.text];
    [self.timelineTweetText sizeToFit];
    
    self.timelineRetweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.timelineLikeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if(self.tweet.retweeted == YES) {
        [self.timelineRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    } else {
        [self.timelineRetweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    
    if(self.tweet.favorited == YES) {
        [self.timelineLikeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    } else {
        [self.timelineLikeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }

    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    if (url != nil) {
        [self.timelineProfileImage setImageWithURL:url];
        self.timelineProfileImage.layer.cornerRadius = self.timelineProfileImage.frame.size.height /2;
        self.timelineProfileImage.layer.masksToBounds = YES;
        self.timelineProfileImage.layer.borderWidth = 0;
    }
    
}

- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted != YES) { //tweet
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self.timelineRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    } else { //unretweet
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [self.timelineRetweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }

}

- (IBAction)didTapFavorite:(id)sender {
    if(self.tweet.favorited != YES) { //favorite
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        // Update cell UI
        [self.timelineLikeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    } else { //unfavorite
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        // Update cell UI
        [self.timelineLikeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        //retweet-icon-green.png
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void) refreshData {
    self.timelineRetweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.timelineLikeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

#pragma mark - Navigation

@end
