//
//  ArtistView.h
//  arthome
//
//  Created by 海修杰 on 16/5/23.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtistView;

@protocol ArtistViewDelegate <NSObject>

@optional

-(void)focusedBtnClick:(ArtistView *)artistView;

-(void)artWorkBtnClick:(ArtistView *)artistView WithArtId:(NSString *)artId;

@end

@interface ArtistView : UIView

@property (nonatomic,copy) NSString * headImg;

@property (nonatomic,copy) NSString * artistName;

@property (nonatomic,copy) NSString * artistSign;

@property (nonatomic,copy) NSString * artistFuns;

@property (nonatomic,copy) NSString * isFocused;

@property (nonatomic,strong) NSArray * typicalArts ;

@property (nonatomic,assign) id <ArtistViewDelegate> delegate  ;

@end
