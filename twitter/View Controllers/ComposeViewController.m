//
//  ComposeViewController.m
//  twitter
//
//  Created by Alice Zhang on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//closes the compose screen
- (IBAction)closeCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetCompose:(id)sender {
     [[APIManager shared] postStatusWithText:self.composeText.text completion:^(Tweet *tweet, NSError *error) {
         if (tweet) {
             NSLog(@"😎😎😎 Successfully tweeted");
             [self.delegate didTweet:tweet];
             [self dismissViewControllerAnimated:true completion:nil];
         } else {
             NSLog(@"😫😫😫 Error tweeting: %@", error.localizedDescription);
         }
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
