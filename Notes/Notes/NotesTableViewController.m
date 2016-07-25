//
//  NotesTableViewController.m
//  Notes
//
//  Created by Lei Xu on 7/24/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "NotesTableViewController.h"
#import "Notes.h"
#import "Model.h"
#import "Note.h"
#import "NoteTableViewCell.h"
#import "ViewController.h"

@interface NotesTableViewController ()
@property (strong, nonatomic) Note *noteToAdd;
@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[NoteTableViewCell class] forCellReuseIdentifier:@"note"];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
    self.title = @"Notes";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    if (self.noteToAdd && ![self.noteToAdd isBlank]) {
        [[Model sharedModel].notes addNote:self.noteToAdd];
    }
    self.noteToAdd = nil;
    [[Model sharedModel] saveNotes];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Model sharedModel] notes].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note" forIndexPath:indexPath];
    
    // Configure the cell...
    Note *note = [[[Model sharedModel] notes] getNoteAtIndex:indexPath.row];
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.detail;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note *note = [[[Model sharedModel] notes] getNoteAtIndex:indexPath.row];
    ViewController *detailViewController = [[ViewController alloc] initWithNote:note];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)addNote:(id)sender {
    self.noteToAdd = [[Note alloc] initWithTitle:@"" detail:@""];
    ViewController *detailViewController = [[ViewController alloc] initWithNote:self.noteToAdd];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[[Model sharedModel] notes] deleteNoteAtIndex:indexPath.row];
        [[Model sharedModel] saveNotes];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[[Model sharedModel] notes] moveFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
    [[Model sharedModel] saveNotes];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
