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

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *composeText;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)textViewDidChange:(UITextView *)textView {
    NSUInteger length = [textView.text length];
    self.characterCount.text = [NSString stringWithFormat:@"%u", length];
    if(length > 280) {
        textView.layer.borderColor = [[UIColor redColor] CGColor];
        textView.layer.borderWidth = 0.5;
    }
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
