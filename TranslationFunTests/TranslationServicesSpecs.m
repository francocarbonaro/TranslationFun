//
//  TranslationServicesSpecs.m
//  TranslationFun
//
//  Created by Franco Carbonaro on 2/3/14.
//  Copyright (c) 2014 Franco Carbonaro. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "OCMock.h"
#import "TranslationServices.h"
#import "LSNocilla.h"

SpecBegin(TranslationServicesSpecsSpecs)

	describe(@"TranslationServicesSpecs", ^{
        __block TranslationServices *_services;
        __block id _mockServices;
        
        context(@"when the text to translate is nil or empty string", ^{
            it(@"should return translation as nill if text to translate is nil or empty string", ^AsyncBlock {
                _services = [TranslationServices new];
                
                _mockServices = [OCMockObject partialMockForObject:_services];
                
                [_services translate:nil from:@"en" to:@"pt-br" completionBlock:^(NSString *translation) {
                    expect(translation).to.beNil();
                    done();
                }];
                
                [_mockServices expect];
            });
        });
        
        context(@"when the input language or the output language is nil or empty string", ^{
            beforeEach(^{
                _services = [TranslationServices new];
                
                _mockServices = [OCMockObject partialMockForObject:_services];
            });
            
            it(@"should return translation as nil if the input language is nil or empty string", ^AsyncBlock{
                [_services translate:@"house"
                                from:nil
                                  to:@"pt-br"
                   completionBlock:^(NSString *translation) {
                       expect(translation).to.beNil();
                       done();
                }];
                
                [_mockServices verify];
            });
            
            it(@"should return translation as nil if the output language is nil or empty string", ^AsyncBlock{
                [_services translate:@"house"
                                from:@"en"
                                  to:nil
                   completionBlock:^(NSString *translation) {
                       expect(translation).to.beNil();
                       done();
                   }];
                
                [_mockServices verify];
            });
        });
        
        context(@"when the input language is 'en' and the output language is 'pt-br'", ^{
            beforeAll(^{
                [[LSNocilla sharedInstance] start];
                
                _services = [TranslationServices new];
                
                _mockServices = [OCMockObject partialMockForObject:_services];
            });
            
            afterEach(^{
                [_mockServices verify];

                [[LSNocilla sharedInstance] clearStubs];
            });
            
            afterAll(^{
                [[LSNocilla sharedInstance] stop];
            });
            
            
            it(@"should translate 'house' as 'casa'", ^AsyncBlock{
                NSString *urlString = @"http://mymemory.translated.net/api/get?q=house&langpair=en%7Cpt-br";

                NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                
                NSString *pathForFile = [bundle pathForResource:@"house.json" ofType:nil];
                
                NSData *jsonFile = [NSData dataWithContentsOfFile:pathForFile];
                
                stubRequest(@"GET", urlString)
                .andReturnRawResponse(jsonFile)
                .withHeaders(@{@"Content-Type": @"application/json"});
                
                [_services translate:@"house" from:@"en" to:@"pt-br" completionBlock:^(NSString *translation) {
                    expect(translation).to.equal(@"casa");
                    done();
                }];
            });
            
            it(@"should translate 'house' as 'casa'", ^AsyncBlock{
                NSString *urlString = @"http://mymemory.translated.net/api/get?q=booked&langpair=en%7Cpt-br";
                
                NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                
                NSString *pathForFile = [bundle pathForResource:@"booked.json" ofType:nil];
                
                NSData *jsonFile = [NSData dataWithContentsOfFile:pathForFile];
                
                stubRequest(@"GET", urlString)
                .andReturnRawResponse(jsonFile)
                .withHeaders(@{@"Content-Type": @"application/json"});
                
                [_services translate:@"booked" from:@"en" to:@"pt-br" completionBlock:^(NSString *translation) {
                    expect(translation).to.equal(@"reservado");
                    done();
                }];
            });
        });
	});

SpecEnd