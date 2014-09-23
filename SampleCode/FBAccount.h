//
//  FBAccount.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 18/09/2014.
//
//

#import <Foundation/Foundation.h>
#import "WorkInfo.h"
#import "BasicInfo.h"
#import "EducationInfo.h"

@interface FBAccount : NSObject
{
    BOOL isNew;
}
@property (strong,nonatomic) BasicInfo * basicInfo;
@property (strong,nonatomic) WorkInfo * workInfo;
@property (strong,nonatomic) EducationInfo * educationInfo;

- (BOOL) isNeedReload;
- (void) needReload;

@end


