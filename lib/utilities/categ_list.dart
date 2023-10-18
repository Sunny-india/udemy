class MyList {
  /*Yahan jo bhi list banegi, wo all_cat_pages pe her ek category ko
  define krte huye, same name ki banegi; aur in String Type ki list ko
  label banana hai; wahan pe.
  is list ki, aur image mein us folder mein images ki length same honi chahiye.

  String type list mein naam jyada bade nahi hone chahiye, overflow ka error aa jata hai;
  * */

  static List<String> mainCategory = [
    'select category',
    'kirana',
    'dairy',
    'medical',
    'hardware'
  ];

  static List<String> kirana = [
    'sub category',
    'k Heera',
    'k Best',
    'k JVR',
    'k Original',
    'k New Pack',
    'k Moti',
    'Pure',
  ];

  static List<String> dairy = [
    'sub category',
    'd Heera',
    'd Best',
    'd JVR',
    'd Original',
    'd New Pack',
  ];
  static List<String> medical = [
    'sub category',
    'm Heera',
    'm Best',
    'm JVR',
    'm Original',
    'm New Pack',
  ];
  static List<String> hardware = [
    'sub category',
    'h Heera',
    'h Best',
    'h JVR',
    'h Original',
    'h New Pack',
  ];
}
