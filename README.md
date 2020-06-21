# PopularMovies test application

**This test app was created for demonstration of design patterns implementation.


## The Creation Patterns

**BUILDER** pattern 
 
```swift
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
```
in the Realm+Extensions.swift file

**The Factory Method** pattern 

```swift
    func asEntity() -> PopularMovie {
        return PopularMovie(poster_path: poster_path,
                            adult: adult,
                            overview: overview,
                            release_date: release_date,
                            genre_ids: [],
                            id: id,
                            original_title: original_title,
                            original_language: original_language,
                            title: title,
                            backdrop_path: backdrop_path,
                            popularity: popularity,
                            vote_count: vote_count,
                            video: video,
                            vote_average: vote_average)
    }
    
    func asModel() -> RMPopularMovie {
        return RMPopularMovie.build { object in
            object.id = id ?? -1
            object.poster_path = poster_path ?? ""
            object.adult = adult ?? false
            object.overview = overview ?? ""
            object.release_date = release_date ?? ""
            object.original_title = original_title ?? ""
            object.original_language = original_language ?? ""
            object.title = title ?? ""
            object.backdrop_path = backdrop_path ?? ""
            object.popularity = popularity ?? .zero
            object.vote_count = vote_count ?? .zero
            object.video = video ?? false
            object.vote_average = vote_average ?? .zero
        }
    }
```
in the RMPopularMovie.swift file



## The Structural Patterns

**FACADE** pattern 

```swift
    public protocol MoviesUseCase: AutoUseCaseProvider {
        //Network
        func getPopularMoviesList(for page: Int, complition: @escaping ([PopularMovie]?) -> Void)
        func fullPathToImageFrom(path: String?) -> String?
        func fullPathToThumbnailFrom(path: String?) -> String?
        
        //Database
        func checkIsFavoriteMovie(id: Int) -> Bool
        func addToFavorites(movie: PopularMovie)
        func deleteFromFavorites(movie: PopularMovie)
        func getFavoriteMovies() -> [PopularMovie]
        func numberOfFavoriteMovies() -> Int
    }
    
    final class MoviesService: NSObject, MoviesUseCase
```

in the MoviesService.swift file


## The Behavioral Patterns

**Template Method** pattern 

```swift
    func getPopularMovies() { }
```

in the BaseViewModel.swift file



## License

Alex Shekunsky 2020 ©
