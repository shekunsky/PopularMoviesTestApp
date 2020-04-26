// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


  public protocol HasMoviesUseCase {
      var movies: MoviesUseCase { get }
  }

public typealias UseCases =
    HasMoviesUseCase
public protocol UseCasesProvider: UseCases {}
