import 'package:bloc/bloc.dart';
import 'package:spotify/common/helper/shared_operator.dart';
import 'package:spotify/features/intro/presentation/bloc/theme_state.dart';


class ThemeCubit extends Cubit<ThemeState>{
  SharedPrefOperator sharedPrefOperator;

  ThemeCubit(this.sharedPrefOperator):super(ThemeState(
    currentTheme: sharedPrefOperator.getThemeMode(),
  ));

  void updateThemeMode (bool theme,){
    emit(state.copyWith(newCurrentTheme: theme));
  }

}