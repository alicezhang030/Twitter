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

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.timelineAuthor.text = self.tweet.user.name;
    self.timelineUsername.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.timelineDate.text = self.tweet.createdAtString;
    self.timelineTweetText.text = self.tweet.text;
    [self.timelineTweetText sizeToFit];
    //TODO: set reply count
    self.timelineRetweetButton.titleLabel.text = [@(self.tweet.retweetCount) stringValue];
    self.timelineLikeButton.titleLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    if (url != nil) {
        [self.timelineProfileImage setImageWithURL:url];
        self.timelineProfileImage.layer.cornerRadius = self.timelineProfileImage.frame.size.height /2;
        self.timelineProfileImage.layer.masksToBounds = YES;
        self.timelineProfileImage.layer.borderWidth = 0;
    }
    
}

@end
