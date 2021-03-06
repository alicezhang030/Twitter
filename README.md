# Project 2 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **26** hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at least the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [x] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [x] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [ ] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [ ] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [x] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [x] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [ ] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [x] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Indicate that a post is a retweet on a user's profile page
2. Convert the numbers (ex. 1045630 followers) to a more readable format (ex. 1M followers)

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Login, app icon, launch screeen:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/login.gif)
Compose tweet:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/compose.gif)
All other required features:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/all%20but%20compose.gif)
Unlike and unretweet:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/unlike_unretweet.gif)
Character count + warning:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/char_count.gif)
Infinite scroll:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/infin_scroll.gif)
Profile page + pull down:
![](https://github.com/alicezhang030/Twitter/blob/main/Showcase/profile_pull_down.gif)


## Notes

Describe any challenges encountered while building the app.

Autolayout was very challenging to work with. The concept sounds simple, but it became really hard to make sure everything is aligned on all devices.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - date formatting library

## License

    Copyright 2022 Jinyang Zhang

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
