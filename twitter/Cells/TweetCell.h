//
//  TweetCell.h
//  twitter
//
//  Created by Alice Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *timelineProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *timelineAuthor;
@property (weak, nonatomic) IBOutlet UILabel *timelineUsername;
@property (weak, nonatomic) IBOutlet UILabel *timelineDate;
@property (weak, nonatomic) IBOutlet UILabel *timelineTweetText;
@property (weak, nonatomic) IBOutlet UIButton *timelineLikeButton;
@property (weak, nonatomic) IBOutlet UIButton *timelineRetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *timelineReplyButton;
@property (weak, nonatomic) IBOutlet UILabel *timelineRetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *timelineLikeCount;

@property (nonatomic, strong) Tweet *tweet;

@property (nonatomic, weak) id<TweetCellDelegate> delegate;

@end

@protocol TweetCellDelegate
- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
@end

NS_ASSUME_NONNULL_END
