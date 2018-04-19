//
//  CTJsonKit.m
//  Line
//
//  Created by pxzheng on 2018/4/4.
//  Copyright © 2018年 zpx. All rights reserved.
//

#import "CTJsonKit.h"

//@implementation CTJsonKit
//
//@end

@implementation NSData(CTJSON)

- (NSDictionary *)objectFromJSONDataForCtrip {
    NSError *error = nil;
    NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error == nil) {
        //        resultJSON = [self transformDoubleToFloatIfNeed:resultJSON];
        return resultJSON;
    }
    
    return nil;
}

-(id)transformDoubleToFloatIfNeed:(id)originObj{
    id result = originObj;
    if ([originObj isKindOfClass:[NSDictionary class]]) {
        result = [NSMutableDictionary dictionary];
        NSArray *allkeys = [originObj allKeys];
        for (id key in allkeys) {
            id obj = [originObj valueForKey:key];
            id resultObj = obj;
            if ([obj isKindOfClass:[NSNumber class]]) {
                if (strcmp([obj objCType], [[NSNumber numberWithDouble:22.22] objCType]) == 0){
                    resultObj = [NSNumber numberWithFloat:[obj floatValue]];
                }
            }
            else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
                resultObj = [self transformDoubleToFloatIfNeed:obj];
            }
            [result setValue:resultObj forKey:key];
        }
    }else if ([originObj isKindOfClass:[NSArray class]]){
        result = [NSMutableArray array];
        for (id obj in originObj) {
            id resultObj = obj;
            if ([obj isKindOfClass:[NSNumber class]]) {
                if (strcmp([obj objCType], [[NSNumber numberWithDouble:22.22] objCType]) == 0){
                    resultObj = [NSNumber numberWithFloat:[obj floatValue]];
                }
            }
            else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
                resultObj = [self transformDoubleToFloatIfNeed:obj];
            }
            if (resultObj) {
                [result addObject:resultObj];
            }
        }
    }
    
    return result;
}

@end

#pragma mark ----- NSString(CTJSON)

@implementation NSString(CTJSON)

- (NSDictionary *)objectFromJSONStringForCtrip {
    if ([self length] == 0 || [self isEqualToString:@" "]) {
        return nil;
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data objectFromJSONDataForCtrip];
}

- (NSData *)JSONDataForCtrip {
    if ([self length] == 0 || [self isEqualToString:@" "]) {
        return nil;
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end

#pragma mark ----- NSDictionary(CTJSON)
@implementation NSDictionary(CTJSON)

- (NSString *)JSONStringForCtrip {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error == nil && jsonData != nil) {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    return nil;
}

- (NSData *)JSONDataForCtrip {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error == nil) {
            return jsonData;
        }
    }
    
    return nil;
}

@end

#pragma mark ----- NSArray(CTJSON)
@implementation NSArray(CTJSON)

- (NSString *)JSONStringForCtrip {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error == nil && jsonData != nil) {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    return nil;
}

- (NSData *)JSONDataForCtrip {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error == nil) {
            return jsonData;
        }
    }
    
    return nil;
}

@end





