//
//  MHLeadingView.h
//  MHLeadingView
//
//  Created by 徐茂怀 on 2018/3/2.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHLeadingView : UIView

/**
 

 @param imageNames 传入的图片名称数组
 */
- (instancetype)initWithImageNames:(NSArray *)imageNames;
-(void)show;
@end
