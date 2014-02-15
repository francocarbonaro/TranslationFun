//
//  ViewController.h
//  TranslationFun
//
//  Created by Franco Carbonaro on 2/3/14.
//  Copyright (c) 2014 Franco Carbonaro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TranslationServices;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textToTranslateTextField;
@property (weak, nonatomic) IBOutlet UILabel *translatedTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *translateButton;

- (IBAction)translateButtonTouched:(id)sender;

- (TranslationServices *)service;

@end
