class ThemeState {
  bool? currentTheme;

  ThemeState({
    required this.currentTheme,
});
  ThemeState copyWith ({
    bool ? newCurrentTheme,
}){
    return ThemeState(
        currentTheme: newCurrentTheme ?? currentTheme
    );
  }

}