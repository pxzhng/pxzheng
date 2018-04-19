//
//  ViewController.m
//  Line
//
//  Created by pxzheng on 2018/3/27.
//  Copyright © 2018年 zpx. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CTJsonKit.h"

#define commonWidth [[UIScreen mainScreen] bounds].size.width
#define commonHeight [[UIScreen mainScreen] bounds].size.height;
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)initUI{
    
    self.containView = [[UIView alloc] init];
    self.containView.frame = CGRectMake(0, 20, commonWidth, 200);
    self.containView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.containView];
    
    NSInteger pages = 6;

    //init scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, commonWidth, 200)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
  
    
    // SET size
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    
    CGFloat scrollHeight = self.scrollView.frame.size.height;
    
    //轮番图片
    for (int i=0; i<pages; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:[ NSString stringWithFormat:@"0_%d.jpg",i+1]];
        imageView.frame = CGRectMake(scrollWidth*i, 0, scrollWidth, scrollHeight);
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    
    //设置滚动样式
    //竖直方向不能滚动
    self.scrollView.contentSize = CGSizeMake(scrollWidth*pages, 0);

    //开启分页功能
    self.scrollView.pagingEnabled = YES;

    //隐藏提示条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.containView addSubview:self.scrollView];

    //init pageControl
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(commonWidth-80, 180, 60, 10);
    self.pageControl.hidesForSinglePage = YES;
    
    self.pageControl.numberOfPages = pages;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    
//    [self.pageControl setBounds:CGRectMake(0, 0, 16*(pages-1)+16, 16)];
//    self.pageControl.layer.cornerRadius = 8;
//    self.pageControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
//    [self.pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_currentPageImage"];
//    [self.pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];
    [self.containView addSubview:self.pageControl];
    
    //添加定时器
    [self startTimer];
    //设置scrollview代理
    self.scrollView.delegate = self;
}

-(void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//下一页
-(void)nextPage:(NSTimer *)timer{
    NSInteger page = self.pageControl.currentPage+1;
    NSLog(@"-----------------------page-----%ld----------%ld",page,self.pageControl.currentPage);

    if (page==6) {
        page = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*page, 0) animated:YES];
//    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width*page, 0);
}

-(void)stopTimer:(NSTimer *)timer{
    [timer invalidate];
}

#pragma ------------delegate--------------
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"---scrollViewWillBeginDragging");
    [self.timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"--------------------scrollViewDidEndDragging");
    [self startTimer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width);
    NSLog(@"--------------scrollViewDidScroll------%d",page);

    self.pageControl.currentPage = page;
    NSLog(@"--------------scrollViewDidScroll------%d",page);

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self initUI];
    
    UIButton *jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 50, 30)];
    [jumpButton setTitle:@"jump" forState:UIControlStateNormal];
    jumpButton.backgroundColor = [UIColor blueColor];
//    jumpButton.layer.borderColor = [UIColor redColor].CGColor;
    jumpButton.layer.borderWidth = 1.0f;
    [jumpButton addTarget:self action:@selector(gotoSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testGCD];
//    [self testGCD2];
//    [self testGCD3];
//    [self testGCD5];
//    [self testRuntime];
}

-(void)testRuntime{
//    NSArray *arr = [NSArray array];
//    NSArray *arr2 = [[NSArray alloc] init];
    
}
-(void)testGCD{
    //主队列
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //
    dispatch_async(globalQueue, ^{
        for (NSInteger i=0; i<30;i++) {
            NSLog(@"--------------%ld",i);
        }
    });
}

-(void)testGCD2{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"3");
    });
    dispatch_barrier_async(globalQueue, ^{
        NSLog(@"-------middle------");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"4");
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"5");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"66666666");
    });
    
    //延迟执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-----------77777");
    });
}
-(void)testGCD3{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"---------------test");
//    });
//    dispatch_async(dispatch_get_global_queue(), ^{
//        NSLog(@"---------------test");
//    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"------------test");
    });
    for (int i=0; i<10; i++) {
        NSLog(@"--------%d",i);
    }
}

//并行循环
-(void)testGCD5{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_apply(20, queue, ^(size_t i) {
        NSLog(@"----------------%lu",i);
    });
}




-(void)testBlock{
    
}
-(void)gotoSecondView:(UIButton *)button{
    SecondViewController *svc = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:svc animated:YES];
    [self presentViewController:svc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
