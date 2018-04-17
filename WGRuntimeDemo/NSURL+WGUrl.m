//
//  NSURL+WGUrl.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//
//方法交换

#import "NSURL+WGUrl.h"
#import <objc/message.h>

@implementation NSURL (WGUrl)

+(void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getClassMethod([self class], @selector(URLWithString:));
        Method newMethod = class_getClassMethod([self class], @selector(WG_URLWithString:));
        if (oldMethod && newMethod) {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

+(instancetype)WG_URLWithString:(NSString *)urlStr{
    if ([urlStr hasPrefix:@"http"]) {
        NSURL *url = [self WG_URLWithString:urlStr];
        if (!url) {
            return nil;
        }else{
            return url;
        }
    }else{
        return nil;
    }
}

@end
