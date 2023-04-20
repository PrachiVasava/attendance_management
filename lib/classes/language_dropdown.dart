class Language{
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  Language(this.id,this.flag,this.name,this.languageCode);

  static List<Language> languageList(){
    return[
      Language(1,"🇬🇧", "English", "en"),
      Language(2,"🇮🇳", "हिंदी", "hi"),
      //Language(3,"🇮🇳", "Gujarati", "hi"),
    ];
  }
}