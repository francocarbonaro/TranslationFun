//
//  ViewControllerSpecs.m
//  TranslationFun
//
//  Created by Franco Carbonaro on 2/3/14.
//  Copyright (c) 2014 Franco Carbonaro. All rights reserved.
//
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "OCMock.h"
#import "ViewController.h"
#import "TranslationServices.h"

SpecBegin(ViewControllerSpecsSpecs)

	describe(@"ViewControllerSpecs", ^{
        
        __block ViewController *_vc;
        
        beforeAll(^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            _vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            
            [_vc view];
        });
        
        it(@"shouldn't be nil when instanciated from the storyboard", ^{
            expect(_vc).toNot.beNil();
        });
        
        it(@"should has an outlet for the textfield", ^{
            expect(_vc.textToTranslateTextField).toNot.beNil();
        });
        
        it(@"should has an outlet for the translated label", ^{
            expect(_vc.translatedTextLabel).toNot.beNil();
        });

        
        it(@"should has an outlet for the translate button", ^{
            expect(_vc.translateButton).toNot.beNil();
        });
        
        it(@"should has an action for the translate button", ^{
            NSArray *actions = [_vc.translateButton actionsForTarget:_vc forControlEvent:UIControlEventTouchUpInside];
            
            expect([actions count]).to.beGreaterThan(0);
        });
        
        context(@"when the user touch the translation button", ^{
            
            it(@"should show an alert view if the textfield is empty", ^{
                id mockAlertView = [OCMockObject mockForClass:[UIAlertView class]];
                
                [[[mockAlertView stub] andReturn:mockAlertView] alloc];
                
                (void)[[[mockAlertView expect] andReturn:mockAlertView]
                 initWithTitle:[OCMArg any]
                 message:[OCMArg any]
                 delegate:[OCMArg any]
                 cancelButtonTitle:[OCMArg any]
                 otherButtonTitles:[OCMArg any], nil];
                
                [[mockAlertView expect] show];
                
                _vc.textToTranslateTextField.text = @"";
                
                [_vc translateButtonTouched:nil];
                
                [mockAlertView verify];
                
                [mockAlertView stopMocking];
            });
            
            context(@"when translating from en to pt-br", ^{
                it(@"should call the translation services if the textfield is not empty", ^{
                    _vc.textToTranslateTextField.text = @"house";
                    
                    id mockServices = [OCMockObject partialMockForObject:[_vc service]];
                    
                    [[[mockServices stub] andReturn:mockServices] alloc];
                    
                    [[mockServices expect] translate:[OCMArg any]
                                                from:[OCMArg any]
                                                  to:[OCMArg any]
                                   completionBlock:[OCMArg checkWithBlock:^BOOL(TranslationServicescompletionBlock block) {
                        block(@"casa");
                        return YES;
                    }]];
                    
                    [_vc translateButtonTouched:nil];
                    
                    expect(_vc.translatedTextLabel.text).to.equal(@"casa");
                    
                    [mockServices verify];
                    
                    [mockServices stopMocking];
                });
            });
        });
	});

SpecEnd