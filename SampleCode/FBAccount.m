//
//  FBAccount.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 18/09/2014.
//
//

#import "FBAccount.h"

@implementation FBAccount

@synthesize basicInfo;
@synthesize workInfo;
@synthesize educationInfo;

- (id) init
{
    if(self)
    {
        isNew = TRUE;
    }
    return self;
}

- (BOOL) isNeedReload
{
    return !isNew;
}

- (void) needReload
{
    isNew = FALSE;
}

@end
