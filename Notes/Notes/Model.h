//
//  Model.h
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Notes;

@interface Model : NSObject
@property(nonatomic, copy) Notes *notes;
+ (Model *)sharedModel;
-(void)saveNotes;
@end
