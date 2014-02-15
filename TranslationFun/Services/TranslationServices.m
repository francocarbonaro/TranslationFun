//
//  TranslationServices.m
//  TranslationFun
//
//  Created by Franco Carbonaro on 2/3/14.
//  Copyright (c) 2014 Franco Carbonaro. All rights reserved.
//

#import "TranslationServices.h"
#import "AFHTTPRequestOperationManager.h"

@implementation TranslationServices

- (void)translate:(NSString *)text
             from:(NSString *)inputLanguage
               to:(NSString *)outputLanguage
     completionBlock:(TranslationServicescompletionBlock)completionBlock {
   
    if ((!text || [text isEqualToString:@""]) ||
        (!inputLanguage || [inputLanguage isEqualToString:@""]) ||
        (!outputLanguage || [outputLanguage isEqualToString:@""])) {
        completionBlock(nil);
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://mymemory.translated.net/api/get?q=%@&langpair=%@%%7C%@",
                           text,
                           inputLanguage,
                           outputLanguage];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *matches = [responseObject objectForKey:@"matches"];
        
        NSDictionary *firstMatch = [matches firstObject];
        
        NSString *translation = [[firstMatch objectForKey:@"translation"] lowercaseString];
        
        completionBlock(translation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
