//
//  ViewController.h
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;

@interface ViewController : UIViewController<UITextFieldDelegate>
- (id) initWithNote:(Note *)note;

@end

