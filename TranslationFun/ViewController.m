//
//  ViewController.m
//  TranslationFun
//
//  Created by Franco Carbonaro on 2/3/14.
//  Copyright (c) 2014 Franco Carbonaro. All rights reserved.
//

#import "ViewController.h"
#import "TranslationServices.h"

@interface ViewController ()
@property (nonatomic, strong) TranslationServices *service;
@end

@implementation ViewController

#pragma mark - ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

- (IBAction)translateButtonTouched:(id)sender {
    if ([_textToTranslateTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ops"
                                                            message:@"Type a text to be translated"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }
    else {
        [[self service] translate:self.textToTranslateTextField.text
                             from:@"en"
                               to:@"pt-br"
                  completionBlock:^(NSString *translation) {
                      self.translatedTextLabel.text = translation;
          }];
    }
}

- (TranslationServices *)service {
    if (!_service) {
        _service = [TranslationServices new];
    }
    
    return _service;
}

@end
