//
//  UICollectionViewCell+Ext.h
//  Lion
//
//  Created by Du on 2019/5/21.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (Ext)

+(instancetype)create:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier;

+(NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
