//
//  DetailsViewController.m
//  flix
//
//  Created by Olalekan Abdurazaq Adisa on 6/25/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backDropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;




@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLStrring = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL * posterURL = [NSURL URLWithString:fullPosterURLStrring];
    [self.posterView setImageWithURL:posterURL];
   
    
    
    //NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullbackdropURLStrring = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL * backdropURL = [NSURL URLWithString:fullbackdropURLStrring];
    
    [self.backDropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    //[self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
