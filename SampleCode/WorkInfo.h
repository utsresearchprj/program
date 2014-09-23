//
//  WorkInfo.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 18/09/2014.
//
//

#import <Foundation/Foundation.h>
#import "Property.h"

@interface WorkInfo : NSObject

@property (strong,nonatomic) NSMutableArray *keyList;
@property (strong,nonatomic) NSMutableArray *inputTypeList;
@property (strong,nonatomic) NSMutableArray *privacySettingList;
@property (strong,nonatomic) NSMutableArray *propertyList;

- (void) addProperty: (Property *) property_;

@end
