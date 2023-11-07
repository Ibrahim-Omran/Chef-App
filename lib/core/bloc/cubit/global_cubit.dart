import 'package:chef_app/core/bloc/cubit/global_state.dart';
import 'package:chef_app/core/database/cache/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/service_locator.dart';

class GlobalCubit extends Cubit<GlobalState>{
  GlobalCubit() : super(GlobalInitial());
  //bool isArabic = false ;
  String langCode = 'ar';
  void changeLang(String codeLang)async{
    emit(ChangeLangLoading());
    //isArabic = !isArabic;
    langCode = codeLang;
    await sl<CacheHelper>().cacheLanguage(codeLang);
    emit(ChangeLangSuccess());
  }

  void getCachedLang(){
    emit(ChangeLangLoading());

    final cachedLang = sl<CacheHelper>().getCachedLanguage();
    langCode = cachedLang;
    emit(ChangeLangSuccess());
  }

}