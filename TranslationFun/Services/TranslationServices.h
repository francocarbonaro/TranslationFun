//
//  TranslationServices.h
//  TranslationFun
//
//  Created by Franco Carbonaro on 2/3/14.
//  Copyright (c) 2014 Franco Carbonaro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TranslationServicescompletionBlock)(NSString *translation);

@interface TranslationServices : NSObject


- (void)translate:(NSString *)text
             from:(NSString *)inputLanguage
               to:(NSString *)outputLanguage
     completionBlock:(TranslationServicescompletionBlock)completionBlock;

@end
