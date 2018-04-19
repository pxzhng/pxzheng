//
//  CTJsonKit.h
//  Line
//
//  Created by pxzheng on 2018/4/4.
//  Copyright © 2018年 zpx. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface CTJsonKit : NSObject
//
//@end
@interface NSData(CTJSON)
/**
 *  Data(UTF8编码)转换成Dictionary
 *
 *  @return Data(UTF8编码)对应的Dictionary
 */
- (NSDictionary *)objectFromJSONDataForCtrip;

@end

@interface NSString(CTJSON)

/**
 *  JSON格式的字符串转换成Dictionary
 *
 *  @return JSON字符串对应的Dictionary
 */
- (NSDictionary *)objectFromJSONStringForCtrip;

/**
 *  NSString转换为JSON格式的NSData
 *
 *  @return 返回String对应的JSON NSData
 */
- (NSData *)JSONDataForCtrip;
@end


@interface NSDictionary(CTJSON)

/**
 *  Dictionary转换为JSON字符串
 *
 *  @return 返回Dict对应的JSON字符串
 */
- (NSString *)JSONStringForCtrip;

/**
 *  NSDictionary转换为JSON格式的NSData
 *
 *  @return 返回Dict对应的JSON NSData
 */
- (NSData *)JSONDataForCtrip;
@end

@interface NSArray(CTJSON)

/**
 *  Dictionary转换为JSON字符串
 *
 *  @return 返回Dict对应的JSON字符串
 */
- (NSString *)JSONStringForCtrip;

/**
 *  NSArray转换为JSON格式的NSData
 *
 *  @return 返回Array对应的JSON NSData
 */
- (NSData *)JSONDataForCtrip;
@end
