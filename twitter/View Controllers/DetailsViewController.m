//
//  DetailsViewController.m
//  twitter
//
//  Created by Alice Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *detailAuthor;
@property (weak, nonatomic) IBOutlet UILabel *detailUsername;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetText;
@property (weak, nonatomic) IBOutlet UIButton *detailRetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *detailLikeButton;
@property (weak, nonatomic) IBOutlet UILabel *detailRetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *detailLikeCount;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *URLString = self.detailTweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    if (url != nil) {
        [self.detailProfileImage setImageWithURL:url];
        self.detailProfileImage.layer.cornerRadius = self.detailProfileImage.frame.size.height /2;
        self.detailProfileImage.layer.masksToBounds = YES;
        self.detailProfileImage.layer.borderWidth = 0;
    }
    
    self.detailAuthor.text = self.detailTweet.user.name;
    self.detailUsername.text = [@"@" stringByAppendingString:self.detailTweet.user.screenName];
    self.detailDate.text = self.detailTweet.createdAtString;
    self.detailTweetText.text = self.detailTweet.text;
    [self.detailTweetText sizeToFit];
    
    if(self.detailTweet.retweeted == YES) {
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    } else {
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    
    if(self.detailTweet.favorited == YES) {
        [self.detailLikeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    } else {
        [self.detailLikeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    
    self.detailRetweetCount.text = [NSString stringWithFormat:@"%d", self.detailTweet.retweetCount];
    self.detailLikeCount.text = [NSString stringWithFormat:@"%d", self.detailTweet.favoriteCount];
}

- (IBAction)didTapDetailsRetweet:(id)sender {
    if(self.detailTweet.retweeted != YES) { //tweet
        self.detailTweet.retweeted = YES;
        self.detailTweet.retweetCount += 1;
        
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        [[APIManager shared] retweet:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    } else { //unretweet
        self.detailTweet.retweeted = NO;
        self.detailTweet.retweetCount -= 1;
        
        [self.detailRetweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        [[APIManager shared] unretweet:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (IBAction)didTapDetailsFavorite:(id)sender {
    if(self.detailTweet.favorited != YES) { //favorite
        self.detailTweet.favorited = YES;
        self.detailTweet.favoriteCount += 1;
        
        // Update cell UI
        [self.detailLikeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    } else { //unfavorite
        self.detailTweet.favorited = NO;
        self.detailTweet.favoriteCount -= 1;
        
        // Update cell UI
        [self.detailLikeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
        [self refreshData];
        
        //retweet-icon-green.png
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void) refreshData {
    self.detailRetweetCount.text = [NSString stringWithFormat:@"%d", self.detailTweet.retweetCount];
    self.detailLikeCount.text = [NSString stringWithFormat:@"%d", self.detailTweet.favoriteCount];
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
