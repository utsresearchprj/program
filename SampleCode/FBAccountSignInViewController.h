//
//  FBAccountSignInViewController.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 17/09/2014.
//
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <MessageUI/MessageUI.h>

@interface FBAccountSignInViewController : UIViewController<FBLoginViewDelegate, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@end
