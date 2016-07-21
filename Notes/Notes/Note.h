//
//  Note.h
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
-(id)initWithTitle:(NSString *)title detail:(NSString *)detail;
@end
