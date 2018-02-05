//
//  PlayerViewController.m
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2018/2/2.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "PlayerViewController.h"
#import "SJVideoPlayer.h"
#import <Masonry/Masonry.h>
#import <SJUIFactory/SJUIFactory.h>
#import "SJVideoPlayerControlView.h"

@interface PlayerViewController ()<SJVideoPlayerControlViewDelegate>

@property (nonatomic, strong) SJVideoPlayer *videoPlayer;
@property (nonatomic, strong) SJVideoPlayerControlView *controlView;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create video player
    _videoPlayer = [SJVideoPlayer new];
    [self.view addSubview:_videoPlayer.view];
    [_videoPlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SJ_is_iPhoneX() ? 44 : 20);
        make.leading.trailing.offset(0);
        make.height.equalTo(_videoPlayer.view.mas_width).multipliedBy(9/16.0f);
    }];
    
    // video asset
    _videoPlayer.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithAssetURL:[NSURL URLWithString:@"http://vod.lanwuzhe.com/b12ad5034df14bedbdf0e5654cbf7224/6fc3ba23d31743ea8b3c0192c1b83f86-5287d2089db37e62345123a1be272f8b.mp4?video="]];
//    _videoPlayer.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithAssetURL:[NSURL URLWithString:@"http://blurdancer-video.oss-cn-shanghai.aliyuncs.com/usertrend/120718-1515947072.mp4"]];
    
    
    // title
    _videoPlayer.URLAsset.title = @"DIY #平遥牛肉##精品#";
    _videoPlayer.URLAsset.alwaysShowTitle = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _videoPlayer.placeholder = [UIImage imageNamed:@"placeholder"];
    });


    // control layer
    _controlView = [SJVideoPlayerControlView new];
    _controlView.videoPlayer = _videoPlayer;
    _controlView.delegate = self;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)clickedBackBtnOnControlView:(SJVideoPlayerControlView *)controlView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end