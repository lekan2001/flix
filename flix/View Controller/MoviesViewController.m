//
//  MoviesViewController.m
//  flix
//
//  Created by Olalekan Abdurazaq Adisa on 6/24/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
 
@property (weak, nonatomic) IBOutlet
    UITableView *tableView;

@property(nonatomic, strong)UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [_refreshControl setTintColor:[UIColor redColor]];
    //[_refreshControl.backgroundColor.CGColor ]
    
    // Do any additional setup after loading the view.
    
  
}



-(void) fetchMovies{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
      NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
      NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
      NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             if (error != nil) {
                 NSLog(@"%@", [error localizedDescription]);
             }
             else {
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                 
                 NSLog(@"%@", dataDictionary);
                 // TODO: Get the array of movies
     
                 self.movies = dataDictionary[@"results"];
                 for (NSDictionary *movie in self.movies) {
                     
                     NSLog(@"%@", movie[@"title"]);
                 }
                 [self.tableView reloadData];
                 
                 
                 
                 // TODO: Store the movies in a property to use elsewhere
                 // TODO: Reload your table view data
             }
          [self.refreshControl endRefreshing];
         }];
      [task resume];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.movies.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
        
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    
//    NSLog(@"%@",[NSString stringWithFormat:@"row: %d, section %d", indexPath.row,indexPath.section]);
    
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLStrring = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL * posterURL = [NSURL URLWithString:fullPosterURLStrring];
    
    
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    
    
    
    
    
    //cell.pos
    
    //    cell.textLabel.text = movie[@"title"];
    //cell.textLabel.text = [NSString stringWithFormat:@"row: %d, section %d", indexPath.row,indexPath.section];
    return cell;
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
   DetailsViewController *detailsViewController =[segue destinationViewController];
    detailsViewController.movie = movie;
    
    
    NSLog(@"%@", tappedCell );
//     Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
}
//*/

@end
