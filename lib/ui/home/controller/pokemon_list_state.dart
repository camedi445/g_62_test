class PokemonListState {
  final bool isLoading;
  final List<dynamic> pokemonList;

  PokemonListState({this.isLoading = false, this.pokemonList = const []});

  PokemonListState copyWith({bool? isLoading, List<dynamic>? pokemonList}) {
    return PokemonListState(
      isLoading: isLoading ?? this.isLoading,
      pokemonList: pokemonList ?? this.pokemonList,
    );
  }
}
