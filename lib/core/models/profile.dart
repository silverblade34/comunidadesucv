class Profile {
  String? firstname;
  String? lastname;
  dynamic title;
  String? gender;
  dynamic street;
  dynamic zip;
  dynamic city;
  dynamic country;
  dynamic state;
  int? birthdayHideYear;
  dynamic birthday;
  dynamic about;
  dynamic phonePrivate;
  dynamic phoneWork;
  dynamic mobile;
  dynamic fax;
  dynamic imXmpp;
  dynamic url;
  dynamic urlFacebook;
  dynamic urlLinkedin;
  dynamic urlInstagram;
  dynamic urlXing;
  dynamic urlYoutube;
  dynamic urlVimeo;
  dynamic urlTiktok;
  dynamic urlTwitter;
  dynamic urlMastodon;
  String? codigo;
  String? carrera;
  String? filial;
  String? preferredName;
  String imageUrl;
  String imageUrlOrg;
  String bannerUrl;
  String bannerUrlOrg;

  Profile({
    this.firstname,
    this.lastname,
    this.title,
    this.gender,
    this.street,
    this.zip,
    this.city,
    this.country,
    this.state,
    this.birthdayHideYear,
    this.birthday,
    this.about,
    this.phonePrivate,
    this.phoneWork,
    this.mobile,
    this.fax,
    this.imXmpp,
    this.url,
    this.urlFacebook,
    this.urlLinkedin,
    this.urlInstagram,
    this.urlXing,
    this.urlYoutube,
    this.urlVimeo,
    this.urlTiktok,
    this.urlTwitter,
    this.urlMastodon,
    this.codigo,
    this.carrera,
    this.filial,
    this.preferredName,
    required this.imageUrl,
    required this.imageUrlOrg,
    required this.bannerUrl,
    required this.bannerUrlOrg,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        firstname: json["firstname"],
        lastname: json["lastname"],
        title: json["title"],
        gender: json["gender"],
        street: json["street"],
        zip: json["zip"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        birthdayHideYear: json["birthday_hide_year"],
        birthday: json["birthday"],
        about: json["about"],
        phonePrivate: json["phone_private"],
        phoneWork: json["phone_work"],
        mobile: json["mobile"],
        fax: json["fax"],
        imXmpp: json["im_xmpp"],
        url: json["url"],
        urlFacebook: json["url_facebook"],
        urlLinkedin: json["url_linkedin"],
        urlInstagram: json["url_instagram"],
        urlXing: json["url_xing"],
        urlYoutube: json["url_youtube"],
        urlVimeo: json["url_vimeo"],
        urlTiktok: json["url_tiktok"],
        urlTwitter: json["url_twitter"],
        urlMastodon: json["url_mastodon"],
        codigo: json["codigo"],
        carrera: json["carrera"],
        filial: json["filial"],
        preferredName: json["preferred_name"],
        imageUrl: json["image_url"],
        imageUrlOrg: json["image_url_org"],
        bannerUrl: json["banner_url"],
        bannerUrlOrg: json["banner_url_org"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "title": title,
        "gender": gender,
        "street": street,
        "zip": zip,
        "city": city,
        "country": country,
        "state": state,
        "birthday_hide_year": birthdayHideYear,
        "birthday": birthday,
        "about": about,
        "phone_private": phonePrivate,
        "phone_work": phoneWork,
        "mobile": mobile,
        "fax": fax,
        "im_xmpp": imXmpp,
        "url": url,
        "url_facebook": urlFacebook,
        "url_linkedin": urlLinkedin,
        "url_instagram": urlInstagram,
        "url_xing": urlXing,
        "url_youtube": urlYoutube,
        "url_vimeo": urlVimeo,
        "url_tiktok": urlTiktok,
        "url_twitter": urlTwitter,
        "url_mastodon": urlMastodon,
        "codigo": codigo,
        "carrera": carrera,
        "filial": filial,
        "preferred_name": preferredName,
        "image_url": imageUrl,
        "image_url_org": imageUrlOrg,
        "banner_url": bannerUrl,
        "banner_url_org": bannerUrlOrg,
      };
}
