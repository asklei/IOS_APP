//
//  Note.m
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Note.h"

@implementation Note
-(id)initWithTitle:(NSString *)title detail:(NSString *)detail {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.title = title;
    self.detail = detail;
    return self;
}
@end