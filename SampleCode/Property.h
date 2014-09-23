//
//  Property.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 19/09/2014.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TextFieldInputType) {
    KeyboardType = 0,
    DatePickerType,
    GenderPickerType,
    RelationshipPickerType,
    SchoolPickerType
};

@interface Property : NSObject

@property (strong,nonatomic) NSString *key;
@property (strong,nonatomic) id value;
@property (assign,nonatomic) NSInteger inputType;

- (id) initWithKey: (NSString *) key_ Value: (id)value_;

@end
