//
//  XMGAnno.h
//  01-掌握-MapKit框架-基本使用
//
//  Created by xiaomage on 15/8/24.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGAnno : NSObject<MKAnnotation>


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;


/** 类型 */
@property (nonatomic, assign) NSInteger type;


@end
