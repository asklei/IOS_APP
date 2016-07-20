//
//  ViewController.m
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

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
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    saveButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    titleText.layer.borderWidth = 1.0f;
    contentText.layer.borderWidth = 0.5f;
    
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
        make.width.equalTo(titleLabel.mas_width);
    }];
    [titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.leading.equalTo(titleLabel.mas_trailing).offset(spaceH);
        make.trailing.equalTo(saveButton.mas_leading).offset(-spaceH);
        make.width.greaterThanOrEqualTo(titleLabel.mas_width).offset(1);
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
    
    NSLog(@"title of buttion is %@", saveButton.titleLabel.text);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
