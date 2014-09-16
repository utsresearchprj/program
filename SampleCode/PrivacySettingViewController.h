//
//  PrivacySettingViewController.h
//  Social Network Privacy Management
//
//  Created by Nga Nguyen on 8/30/14.
//
//

#import <UIKit/UIKit.h>
#import "GooglePlus/GooglePlus.h"

@class GTLServicePlus;

@interface PrivacySettingViewController : UITableViewController

@property(strong,nonatomic) GTLPlusPerson *Me;
@property(strong,nonatomic) NSMutableArray* arrayBasicInfo;
@property(strong,nonatomic) NSMutableArray* arrayWorkingInfo;
@property(strong,nonatomic) NSMutableArray* arrayEducationInfo;
@property(strong,nonatomic) NSMutableArray* arrayLocationInfo;

@end
