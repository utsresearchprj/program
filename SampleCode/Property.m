//
//  Property.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 19/09/2014.
//
//

#import "Property.h"

@implementation Property

@synthesize key;
@synthesize value;
@synthesize inputType;

- (id) initWithKey: (NSString *) key_ Value: (id)value_
{
    if (self) {
        key = key_;
        value = value_;
    }
    return self;
}

@end
