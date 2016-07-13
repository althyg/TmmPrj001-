//
//  Artist.m
//  arthome
//
//  Created by 海修杰 on 16/3/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "Artist.h"

@implementation Artist

+ (NSArray *)artistHomepageGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        Artist * artist = [[Artist alloc]init];
        artist.artistId = dict[@"artistId"];
        artist.headImg = dict[@"headImg"];
        artist.artistName = dict[@"artistName"];
        artist.artistSign = dict[@"artistSign"];
        artist.artistFuns = dict[@"artistFuns"];
        artist.isFocused = dict[@"isFocused"];
        NSArray *array = dict[@"typicalArts"];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            ArtOfArtist * artOfArtist = [[ArtOfArtist alloc]init];
            artOfArtist.artId = dic[@"artId"];
            artOfArtist.artImgUrl = dic[@"artImgUrl"];
            [arrM addObject:artOfArtist];
        }
        artist.typicalArts = arrM;
        [arrayM addObject:artist];
    }
    return arrayM;

}

@end
