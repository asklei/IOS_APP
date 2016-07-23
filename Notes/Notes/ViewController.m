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
@property(nonatomic, weak) UIButton *saveButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [UILabel new];
    UITextField *titleText = [UITextField new];
    UITextView *contentText = [UITextView new];
    UIButton *saveButton = [UIButton new];
    
    self.titleLabel = titleLabel;
    self.titleText = titleText;
    self.saveButton = saveButton;
    self.contentText = contentText;
    
    titleLabel.text = @"Title:";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:1.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:1.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:0.5] forState:UIControlStateHighlighted];
    [saveButton addTarget:self action:@selector(tappedSave:) forControlEvents:UIControlEventTouchUpInside];
    
    saveButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    titleText.layer.borderWidth = 1.0f;
    titleText.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    contentText.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    contentText.layer.cornerRadius = 5.0f;
    contentText.layer.borderWidth = 0.5f;
    self.titleText.delegate = self;
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:titleText];
    [self.view addSubview:saveButton];
    [self.view addSubview:contentText];
    
    int spaceH = 10;
    int spaceV = 30;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(spaceV);
        make.leading.equalTo(self.view.mas_leading).offset(spaceH);
    }];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_top);
        make.height.equalTo(titleLabel.mas_height);
        make.trailing.equalTo(self.view.mas_trailing).offset(-spaceH);
    }];
    [titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.leading.equalTo(titleLabel.mas_trailing).offset(spaceH);
        make.trailing.equalTo(saveButton.mas_leading).offset(-spaceH);
        make.width.greaterThanOrEqualTo(@10);
    }];
    [contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleText.mas_bottom).offset(spaceV);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.trailing.equalTo(self.saveButton.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom).offset(-spaceV);
    }];
    
    [titleLabel sizeToFit];
    [titleText sizeToFit];
    [saveButton sizeToFit];
    [contentText sizeToFit];
    
//    Note *note = [[Model sharedModel] loadNote];
//    self.titleText.text = note.title;
//    self.contentText.text = note.detail;
    
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
//    Note *note = [[Note alloc] initWithTitle:self.titleText.text detail:self.contentText.text];
//    [[Model sharedModel] saveNote:note];
//    
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save data"
//                                                                   message:@"Data correctly saved"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
}


@end
