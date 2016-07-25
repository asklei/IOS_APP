//
//  ViewController.m
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Note.h"
#import "Model.h"

@interface ViewController ()
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UITextField *titleText;
@property(nonatomic, weak) UITextView *contentText;
@property(nonatomic, weak) Note *note;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Edit note";
    
    UILabel *titleLabel = [UILabel new];
    UITextField *titleText = [UITextField new];
    UITextView *contentText = [UITextView new];
    
    self.titleLabel = titleLabel;
    self.titleText = titleText;
    self.contentText = contentText;
    
    titleLabel.text = @"Title:";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    titleText.layer.borderWidth = 1.0f;
    titleText.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    contentText.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    contentText.layer.cornerRadius = 5.0f;
    contentText.layer.borderWidth = 0.5f;
    self.titleText.delegate = self;
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:titleText];
    [self.view addSubview:contentText];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tappedSave:)];
    
    int spaceH = 10;
    int spaceV = 30;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(spaceV);
        make.leading.equalTo(self.view.mas_leading).offset(spaceH);
    }];
    [titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.leading.equalTo(titleLabel.mas_trailing).offset(spaceH);
        make.trailing.equalTo(contentText.mas_trailing).offset(-spaceH);
        make.width.greaterThanOrEqualTo(@10);
    }];
    [contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleText.mas_bottom).offset(spaceV);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing).offset(-spaceH);
        make.bottom.equalTo(self.view.mas_bottom).offset(-spaceV);
    }];
    
    [titleLabel sizeToFit];
    [titleText sizeToFit];
    [contentText sizeToFit];
    
    if (self.note) {
        self.titleText.text = self.note.title;
        self.contentText.text = self.note.detail;
    }
    
}

- (id) initWithNote:(Note *)note {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.note = note;
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) tappedSave:(UIButton *) sender {
    if (self.titleText.text.length > 0 && self.contentText.text.length > 0) {
        [self saveNote];
    } else {
        [self noDataToSave];
    }
}

-(void)noDataToSave {
    NSString *wheresTheProblem;
    
    if (self.titleText.text.length == 0 && self.contentText.text.length == 0) {
        wheresTheProblem = @"title and note text fields";
    } else if (self.titleText.text.length == 0) {
        wheresTheProblem = @"title text field";
    } else {
        wheresTheProblem = @"note text field";
    }
    NSString *theProblem = [NSString stringWithFormat:@"There needs to be text in the %@ to be able to save.",wheresTheProblem];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save problem"
                                                                   message:theProblem
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.titleText.text.length == 0) {
            [self.titleText becomeFirstResponder];
        } else {
            [self.contentText becomeFirstResponder];
        }
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return [self.contentText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: NSNotifications
-(void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardWasShown:(NSNotification*)notification {
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self.contentText mas_updateConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(self.view.mas_bottom).offset(-30 - keyboardHeight);
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    [self.contentText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
}

-(void)saveNote {
    self.note.title = self.titleText.text;
    self.note.detail = self.contentText.text;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
