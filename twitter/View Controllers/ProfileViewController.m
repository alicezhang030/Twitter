//
//  ProfileViewController.m
//  twitter
//
//  Created by Alice Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UILabel *userRealName;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLine;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up TableView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Get timeline
    [self fetchTimeline];
    
    // Update fields
    self.userRealName.text = self.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    
    //TODO: fix cut off with tag line
    self.tagLine.text = self.user.tagline;
    
    self.followingCount.text = [self.user.followingCount stringByAppendingString:@" Following"];
    
    self.followersCount.text = [self.user.followersCount stringByAppendingString:@" Followers"];
    
    self.tweetCount.text = [self.user.tweetCount stringByAppendingString:@" Tweets"];
            
    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    if (url != nil) {
        [self.profileImage setImageWithURL:url];
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height /2;
        self.profileImage.layer.masksToBounds = YES;
        self.profileImage.layer.borderWidth = 0;
    }
    
    NSString *URLStringBackdrop = self.user.backdropPicture;
    NSURL *urlBackdrop = [NSURL URLWithString:URLStringBackdrop];
    if(url != nil) {
        [self.backdropImage setImageWithURL:urlBackdrop];
    }
}


- (void) fetchTimeline {
    [[APIManager shared] getUserTimelineWithCompletion:self.user.user_id completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded user timeline");
            self.arrayOfUserTweets = (NSMutableArray *)tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting user timeline: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TweetCell"];
    cell.tweet = self.arrayOfUserTweets[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfUserTweets.count;
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
