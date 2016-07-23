//
//  Notes.h
//  Notes
//
//  Created by Lei Xu on 7/21/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface Notes : NSObject
@property(nonatomic, strong) NSMutableArray *notes;
-(id)initWithNotes:(NSArray *)notes;
-(NSInteger)count;
-(Note *)getNoteAtIndex:(NSInteger)index;
-(void)addNote:(Note *)note;
-(Note *)deleteNoteAtIndex:(NSInteger)index;
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end
