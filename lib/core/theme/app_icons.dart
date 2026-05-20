class AppIcons {
  const AppIcons._();

  static const svg = _SvgIcons();
  static const png = _PngIcons();
  static const jpg = _JpgImages();
  static const lottie = _LottieAnimations();
}

/// =============================
/// SVG ICONS
/// =============================
class _SvgIcons {
  const _SvgIcons();

  final appBar = const _SvgAppBarIcons();
  final actions = const _SvgActionsIcons();
  final tabs = const _SvgTabIcons();
  final drawer = const _SvgDrawerIcons();
  final social = const _SvgSocialIcons();
  final generic = const _SvgGenericIcons();
  final nudges = const _SvgNudgesIcons();
  final transitions = const _SvgTransitionIcons();
  final community = const _SvgCommunityIcons();
  final specialist = const _SvgSpecialistIcons();
  final documentIcons = const _SvgDocumentsIcons();
  final coupons = const _SvgCouponsIcons();
  final orders = const _SvgOrdersIcons();
  final commentIcons = const _SvgCommentIcons();
}

class _SvgDocumentsIcons {
  const _SvgDocumentsIcons();

  final String doc = 'assets/icons/svg/documents_icon/doc.svg';
  final String jpg = 'assets/icons/svg/documents_icon/jpg.svg';
  final String pdf = 'assets/icons/svg/documents_icon/pdf.svg';
}

class _SvgCouponsIcons {
  const _SvgCouponsIcons();
  final String scissor = 'assets/icons/svg/coupons/scissor.svg';
}

class _SvgOrdersIcons {
  const _SvgOrdersIcons();
  final String package = 'assets/icons/svg/orders/package.svg';
}

/// ---- AppBar
class _SvgAppBarIcons {
  const _SvgAppBarIcons();

  final String menu = 'assets/icons/svg/app_bar_icons/menu.svg';
  final String calendar = 'assets/icons/svg/app_bar_icons/calendar.svg';
  final String bell = 'assets/icons/svg/app_bar_icons/bell.svg';
}

/// ---- Actions
class _SvgActionsIcons {
  const _SvgActionsIcons();

  final String consultation =
      'assets/icons/svg/actions/action_consultation.svg';
  final String record = 'assets/icons/svg/actions/action_record.svg';
  final String vaccination = 'assets/icons/svg/actions/action_vaccination.svg';

  final String community = 'assets/icons/svg/actions/action_community.svg';
  final String tipsGuide = 'assets/icons/svg/actions/action_tips_guide.svg';
  final String events = 'assets/icons/svg/actions/action_events.svg';
  final String reportMissing =
      'assets/icons/svg/actions/action_report_missing.svg';
  final String reportFound = 'assets/icons/svg/actions/action_report_found.svg';
  final String chat = 'assets/icons/svg/actions/action_chat.svg';
  final String petDog = 'assets/icons/svg/actions/pet_dog.svg';
}

/// ---- Bottom Tabs
class _SvgTabIcons {
  const _SvgTabIcons();

  final String clipboard = 'assets/icons/svg/tabs/clipboard.svg';
  final String group = 'assets/icons/svg/tabs/group.svg';
  final String paw = 'assets/icons/svg/tabs/paw.svg';
  final String pentagon = 'assets/icons/svg/tabs/pentagon.svg';
  final String verify = 'assets/icons/svg/tabs/verify.svg';

  final String gut = 'assets/icons/svg/tabs/tab_gut.svg';
  final String pain = 'assets/icons/svg/tabs/tab_pain.svg';
  final String symptom = 'assets/icons/svg/tabs/tab_symptom.svg';
  final String vet = 'assets/icons/svg/tabs/tab_vet.svg';
}

/// ---- Drawer
class _SvgDrawerIcons {
  const _SvgDrawerIcons();

  final String house = 'assets/icons/svg/drawer/house.svg';
  final String about = 'assets/icons/svg/drawer/about.svg';
  final String accessories = 'assets/icons/svg/drawer/accessories.svg';
  final String accounts = 'assets/icons/svg/drawer/accounts.svg';
  final String changeLang = 'assets/icons/svg/drawer/change_lang.svg';
  final String coupons = 'assets/icons/svg/drawer/coupons.svg';
  final String delete = 'assets/icons/svg/drawer/delete.svg';
  final String folder = 'assets/icons/svg/drawer/folder.svg';
  final String helpSupport = 'assets/icons/svg/drawer/help_support.svg';
  final String invites = 'assets/icons/svg/drawer/invites.svg';
  final String notification = 'assets/icons/svg/drawer/notification.svg';
  final String orders = 'assets/icons/svg/drawer/orders.svg';
  final String paymentMethod = 'assets/icons/svg/drawer/payment_method.svg';
  final String settings = 'assets/icons/svg/drawer/settings.svg';
  final String subscription = 'assets/icons/svg/drawer/subscription.svg';

  final String userSound = 'assets/icons/svg/drawer/user_sound.svg';
  final String notePencil = 'assets/icons/svg/drawer/note_pencil.svg';
  final String minus = 'assets/icons/svg/drawer/minus.svg';
}

/// ---- Social
class _SvgSocialIcons {
  const _SvgSocialIcons();

  final String facebook = 'assets/icons/svg/social/facebook.svg';
  final String instagram = 'assets/icons/svg/social/instagram.svg';
  final String linkedin = 'assets/icons/svg/social/linkedin.svg';
  final String youtube = 'assets/icons/svg/social/youtube.svg';
  final String loginApple = 'assets/icons/svg/social/login_apple.svg';
  final String loginGoogle = 'assets/icons/svg/social/login_google.svg';
  final String loginFacebook = 'assets/icons/svg/social/login_facebook.svg';
}

/// ---- Generic
class _SvgGenericIcons {
  const _SvgGenericIcons();

  final String poochTail = 'assets/icons/svg/generic/pooch_tail.svg';
  final String poochLogo = 'assets/icons/svg/generic/pooch_logo.svg';
  final String poochTitle = 'assets/icons/svg/generic/pooch_title.svg';
  final String female = 'assets/icons/svg/generic/female.svg';
  final String male = 'assets/icons/svg/generic/male.svg';
  final String other = 'assets/icons/svg/generic/other.svg';
  final String femaleThreeD = 'assets/icons/svg/generic/female_three_d.svg';
  final String maleThreeD = 'assets/icons/svg/generic/male_three_d.svg';
  final String chevronDown = 'assets/icons/svg/generic/chevron_down.svg';
  final String chevronRight = 'assets/icons/svg/generic/chevron_right.svg';
  final String chevronUp = 'assets/icons/svg/generic/chevron_up.svg';
  final String chevronLeft = 'assets/icons/svg/generic/chevron_left.svg';
  final String search = 'assets/icons/svg/generic/search.svg';
  final String close = 'assets/icons/svg/generic/close.svg';
  final String camera = 'assets/icons/svg/generic/camera.svg';
  final String delete = 'assets/icons/svg/generic/delete.svg';
  final String edit = 'assets/icons/svg/generic/edit.svg';
  final String upload = 'assets/icons/svg/generic/upload.svg';
  final String send = 'assets/icons/svg/generic/send.svg';
  final String info = 'assets/icons/svg/generic/info.svg';
  final String filter = 'assets/icons/svg/generic/filter.svg';
  final String download = 'assets/icons/svg/generic/download.svg';
  final String flag = 'assets/icons/svg/generic/flag.svg';
  final String share = 'assets/icons/svg/generic/share.svg';
  final String copy = 'assets/icons/svg/generic/copy.svg';
  final String playButton = 'assets/icons/svg/generic/play_button.svg';
  final String pinAttachment = 'assets/icons/svg/generic/pin_attachment.svg';

  final String birthdayCap = 'assets/icons/svg/generic/birthday_cap.svg';
  final String dogCatGroup = 'assets/icons/svg/generic/dog-cat-group.svg';
  final String paper = 'assets/icons/svg/generic/paper.svg';

  final String dawn = 'assets/icons/svg/generic/dawn.svg';
  final String sun = 'assets/icons/svg/generic/sun.svg';
  final String sunrise = 'assets/icons/svg/generic/sunrise.svg';

  final String arrowRight = 'assets/icons/svg/generic/arrow_right.svg';
  final String barcodeScanner = 'assets/icons/svg/generic/barcode_scanner.svg';
  final String grooming = 'assets/icons/svg/generic/grooming.svg';
  final String injection = 'assets/icons/svg/generic/injection.svg';
  final String wallet = 'assets/icons/svg/generic/wallet.svg';
  final String location = 'assets/icons/svg/generic/location.svg';
  final String money = 'assets/icons/svg/generic/money.svg';

  final String plusSign = 'assets/icons/svg/generic/plus_sign.svg';
  final String rightIcon = 'assets/icons/svg/generic/right_icon.svg';
  final String mic = 'assets/icons/svg/generic/mic.svg';

  final String callPhone = 'assets/icons/svg/generic/call_phone.svg';
  final String videoCamera = 'assets/icons/svg/generic/video_camera.svg';

  final String vaccination = 'assets/icons/svg/generic/vaccination.svg';
  final String arrowUpRight = 'assets/icons/svg/generic/arrow_up_right.svg';
  final String comments = 'assets/icons/svg/generic/comments.svg';
  final String mapPinLine = 'assets/icons/svg/generic/map_pin_line.svg';
  final String clock = 'assets/icons/svg/generic/clock.svg';
  final String clockFilled = 'assets/icons/svg/generic/clock_filled.svg';
  final String calendar = 'assets/icons/svg/generic/calendar.svg';
  final String moreVert = 'assets/icons/svg/generic/more_vert.svg';
  final String arrowClockwise = 'assets/icons/svg/generic/arrow_clockwise.svg';
  final String bell = 'assets/icons/svg/generic/bell.svg';
  final String check = 'assets/icons/svg/generic/check.svg';
  final String barbell = 'assets/icons/svg/generic/barbell.svg';
  final String heart = 'assets/icons/svg/generic/heart.svg';
  final String heartOutlined = 'assets/icons/svg/generic/heart_outlined.svg';
  final String heartFilledGradient =
      'assets/icons/svg/generic/heart_filled_gradient.svg';
  final String scale = 'assets/icons/svg/generic/scale.svg';
  final String rightSkip = 'assets/icons/svg/generic/right_skip.svg';
  final String sortDescending = 'assets/icons/svg/generic/sort_descending.svg';
  final String funnleFilter = 'assets/icons/svg/generic/funnle-filter.svg';
  final String luggage = 'assets/icons/svg/generic/luggage.svg';
  final String building = 'assets/icons/svg/generic/building.svg';
  final String gear = 'assets/icons/svg/generic/gear.svg';
  final String poochAssistant = 'assets/icons/svg/generic/pooch_assistant.svg';
  final String paperPlaneTilt = 'assets/icons/svg/generic/paper_plane_tilt.svg';
  final String shareFat = 'assets/icons/svg/generic/share_fat.svg';
  final String gender = 'assets/icons/svg/generic/gender.svg';
  final String checkCircle = 'assets/icons/svg/generic/check_circle.svg';
  final String caretRight = 'assets/icons/svg/generic/caret_right.svg';
  final String poochLogoWhite = 'assets/icons/svg/generic/pooch_logo_white.svg';
  final String sealPercent = 'assets/icons/svg/generic/seal_percent.svg';
}

// --- Transition Icons
class _SvgTransitionIcons {
  const _SvgTransitionIcons();

  final String insightVet = 'assets/icons/svg/transitions/insight_vet.svg';
  final String kittens = 'assets/icons/svg/transitions/kittens.svg';
}

class _SvgCommentIcons {
  const _SvgCommentIcons();

  final String paperPlane = 'assets/icons/svg/comment_icons/paper_plane.svg';
  final String smile = 'assets/icons/svg/comment_icons/smile.svg';
}

// --- Community Icons
class _SvgCommunityIcons {
  const _SvgCommunityIcons();

  final String reward = 'assets/icons/svg/community/reward.svg';
  final String viewMyCommunityVector =
      'assets/icons/svg/community/view-my-community-vector.svg';
}

// --- Specialist Icons
class _SvgSpecialistIcons {
  const _SvgSpecialistIcons();
  final String bone = 'assets/icons/svg/specialist/bone.svg';
  final String eye = 'assets/icons/svg/specialist/eye.svg';
  final String petCare = 'assets/icons/svg/specialist/pet_care.svg';
  final String skin = 'assets/icons/svg/specialist/skin.svg';
  final String stethoscope = 'assets/icons/svg/specialist/stethoscope.svg';
  final String tooth = 'assets/icons/svg/specialist/tooth.svg';
}

/// ---- Nudges Icons
class _SvgNudgesIcons {
  const _SvgNudgesIcons();
  final String helpPooch = 'assets/icons/svg/nudges/help_pooch.svg';
  final String joinPoochCommunity =
      'assets/icons/svg/nudges/join_pooch_community.svg';
  final String poochSuper = 'assets/icons/svg/nudges/pooch_super.svg';
  final String dogCatChip = 'assets/icons/svg/nudges/dog_cat_chip.svg';
  final String dogCatCommunityChip =
      'assets/icons/svg/nudges/dog_cat_community_chip.svg';
  final String buyOrAdoptShape =
      'assets/icons/svg/nudges/buy_or_adopt_shape.svg';
  final String buyOrAdoptShapeTwo =
      'assets/icons/svg/nudges/buy_or_adopt_shape_2.svg';
  final String reportLostPetShape =
      'assets/icons/svg/nudges/report_lost_pet_shape.svg';
}

/// =============================
/// PNG ICONS
/// =============================
class _PngIcons {
  const _PngIcons();

  final generic = const _PngGenericIcons();
  final symptoms = const _PngSymptomsIcons();
  final explore = const _PngExploreIcons();
  final nudges = const _PngNudgesIcons();
  final transitions = const _PngTransitionIcons();
  final screens = const _PngScreenBackgroundImage();
  final verifyBiometrics = const _PngVerifyBiometricsIcons();
  final register = const _PngRegisterImages();
  final profile = const _PngProfileImages();
  final orders = const _PngOrdersIcons();
  final leaderboard = const _PngLeaderboard();
}

class _PngLeaderboard {
  const _PngLeaderboard();

  final leaderboardBg = 'assets/images/png/leaderboard/leaderboard.png';
}

class _PngProfileImages {
  const _PngProfileImages();
  final userProfileBg = 'assets/images/png/profile/user_profile_bg.png';
}

class _PngOrdersIcons {
  const _PngOrdersIcons();
  final poochSuper = 'assets/images/png/orders/pooch_super.png';
}

/// ---- Generic PNG
class _PngGenericIcons {
  const _PngGenericIcons();

  final String female3D = 'assets/icons/png/generic/female_three_d.png';
  final String male3D = 'assets/icons/png/generic/male_three_d.png';
  final String placeholder = 'assets/icons/png/generic/placeholder.png';
  final String poochPet = 'assets/icons/png/generic/pooch_pet.png';
  final String poochPetFeet = 'assets/icons/png/generic/pooch_pet_feet.png';
  final String hospital = 'assets/icons/png/generic/hospital.png';
}

class _PngVerifyBiometricsIcons {
  const _PngVerifyBiometricsIcons();

  final String verifyBiometricsPet =
      'assets/images/png/verify_biometrics/verify_biometric_pet.png';
}

// --- Symptoms PNG
class _PngSymptomsIcons {
  const _PngSymptomsIcons();
  final String lowAppetite = 'assets/images/png/symptoms/low_appetite.png';
  final String lowEnergy = 'assets/images/png/symptoms/low_energy.png';
  final String fever = 'assets/images/png/symptoms/fever.png';
  final String dentalIssue = 'assets/images/png/symptoms/dental_issue.png';
  final String drinkingChanges =
      'assets/images/png/symptoms/drinking_changes.png';
  final String shivering = 'assets/images/png/symptoms/shivering.png';
  final String stomachIssue = 'assets/images/png/symptoms/stomach_issue.png';
}

// --- Explore PNG
class _PngExploreIcons {
  const _PngExploreIcons();
  final String labTest = 'assets/images/png/explore/explore_lab_test.png';
  final String vaccination =
      'assets/images/png/explore/explore_vaccination.png';
  final String dogCat = 'assets/images/png/explore/dog-cat-explore-feature.png';
  final String nurse = 'assets/images/png/explore/nurse-explore-feature.png';
  final String helpHand =
      'assets/images/png/explore/help-support-hand-feature-explore.png';
}

/// ---- Nudges PNG
class _PngNudgesIcons {
  const _PngNudgesIcons();

  final String vetNudgeGroup = 'assets/icons/png/nudges/vet_nudge_group.png';
  final String findVetClinic = 'assets/icons/png/nudges/find_vet_clinic.png';
  final String joinPoochCommunity =
      'assets/icons/png/nudges/join_pooch_community.png';
  final String poochHolder = 'assets/icons/png/nudges/pooch_holder.png';
  final String dogCat = 'assets/icons/png/nudges/dog_cat.png';
  final String dogPeeking = 'assets/icons/png/nudges/dog_peeking.png';
  final String accessoriesPoochBanner =
      'assets/icons/png/nudges/accessories_coupon_banner.png';
}

class _PngTransitionIcons {
  const _PngTransitionIcons();

  final String poochConfigure =
      'assets/icons/png/transitions/pooch_configure.png';
  final String poochDeliveredBoth =
      'assets/icons/png/transitions/pooch_delivered_both.png';
  final String poochDeliveredCat =
      'assets/icons/png/transitions/pooch_delivered_cat.png';
  final String poochDeliveredDog =
      'assets/icons/png/transitions/pooch_delivered_dog.png';
  final String poochFunCat = 'assets/icons/png/transitions/pooch_fun_cat.png';
  final String poochFunDog = 'assets/icons/png/transitions/pooch_fun_dog.png';
  final String poochInsights =
      'assets/icons/png/transitions/pooch_insights.png';
  final String poochOnboarding =
      'assets/icons/png/transitions/pooch_onboarding.png';
  final String poochOrderSuccess =
      'assets/icons/png/transitions/pooch_order_success.png';
  final String poochSecure = 'assets/icons/png/transitions/pooch_secure.png';
  final String poochServe = 'assets/icons/png/transitions/pooch_serve.png';
  final String poochFun = 'assets/icons/png/transitions/pooch_fun.png';
  final String poochServeCat =
      'assets/icons/png/transitions/pooch_serve_cat.png';
  final String poochServeDog =
      'assets/icons/png/transitions/pooch_serve_dog.png';
  final String puppy = 'assets/icons/png/transitions/puppy.png';
  final String berneseDog = 'assets/icons/png/transitions/bernese_dog.png';
  final String gingerCat = 'assets/icons/png/transitions/ginger_cat.png';
  final String huskyDog = 'assets/icons/png/transitions/husky_dog.png';
  final String orangeCat = 'assets/icons/png/transitions/orange_cat.png';
  final String pubDog = 'assets/icons/png/transitions/pub_dog.png';
  final String funPuppy = 'assets/icons/png/transitions/fun_puppy.png';
  final String heart = 'assets/icons/png/transitions/heart.png';
  final String funPuppyWithCap =
      'assets/icons/png/transitions/fun_puppy_with_cap.png';
}

class _PngScreenBackgroundImage {
  const _PngScreenBackgroundImage();
}

class _PngRegisterImages {
  const _PngRegisterImages();

  final String registerDogCat =
      'assets/images/png/register/register_dog_cat.png';
}

class _LottieAnimations {
  const _LottieAnimations();

  final String cat = 'assets/lottie/cat.json';
  final String delete = 'assets/lottie/delete.json';
  final String dog = 'assets/lottie/dog.json';
  final String dog2 = 'assets/lottie/dog2.json';
  final String question = 'assets/lottie/question.json';
  final String successful = 'assets/lottie/successful.json';
  final String truckDeliveryService =
      'assets/lottie/truck-delivery-service.json';
  final String sadDog = 'assets/lottie/sad_dog.json';
  final String poochTail = 'assets/lottie/pooch_tail.json';
  final String returnOrder = 'assets/lottie/return-order.json';
  final String dogMovingTail = 'assets/lottie/dog_moving_tail.json';
  final String handingBag = 'assets/lottie/hanging-bag.json';
  final String orderCancel = 'assets/lottie/cancel-order.json';
  final String scan = 'assets/lottie/scan.json';
  final String coin = 'assets/lottie/coin.json';
  final String giveOrder = 'assets/lottie/give_order.json';
  final String poochHug = 'assets/lottie/pooch_hug.json';
  final String shinyHeart = 'assets/lottie/shiny_heart.json';
  final String findPooches = 'assets/lottie/find_pooches.json';
  final String reportFlag = 'assets/lottie/report_flag.json';
  final String animalFriendly = 'assets/lottie/animal_friendly.json';
  final String completeSuccessful = 'assets/lottie/complete_successful.json';
}

/// =============================
class _JpgImages {
  const _JpgImages();

  final onboarding = const _JpgOnboardingIcons();
}

class _JpgOnboardingIcons {
  const _JpgOnboardingIcons();

  final String havePet = 'assets/images/jpg/onboarding/have_pet.jpg';
  final String dontHavePet = 'assets/images/jpg/onboarding/dont_have_pet.jpg';
  final String dogSpecies = 'assets/images/jpg/onboarding/dog_species.jpg';
  final String catSpecies = 'assets/images/jpg/onboarding/cat_species.jpg';
}
