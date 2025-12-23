import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'dart:io'; // For File operations
import 'package:path_provider/path_provider.dart'; // To get standard directory paths
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_cache/just_audio_cache.dart';
import 'xsxspile.dart' as forEducation;
import 'extralesson.dart' as extra;
import 'package:kangarule/firebase_options.dart';



bool _active = false;
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
var uuid = Uuid();
List<T> flatten<T>(List<dynamic> list) => [for (var sublist in list) ...sublist];

// Define the filename for your JSON data
const String _jsonFileName = 'findmyNotebook.json';
Map<String, dynamic> NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};
// 1. Helper to get the correct file based on WHO is logged in
Future<File> _getLocalFile(String userId) async {
  final directory = await getApplicationDocumentsDirectory();
  
  // Creates a unique file per user: "user123_findmyNotebook.json"
  // OR for guests: "guest_findmyNotebook.json"
  return File('${directory.path}/${userId}_$_jsonFileName');
}

// 2. Updated Save: Now accepts a userId
Future<void> saveNestedJsonToFile(Map<String, dynamic> data, String userId) async {
  try {
    // Pass the userId to get the correct file
    final file = await _getLocalFile(userId);

    String jsonString = jsonEncode(data);
    await file.writeAsString(jsonString);

    print('Saved notebook for user ($userId) to ${file.path}');
  } catch (e) {
    print('Error saving data for user ($userId): $e');
  }
}

// 3. Updated Load: Now accepts a userId
Future<Map<String, dynamic>?> loadNestedJsonFromFile(String userId) async {
  try {
    // Pass the userId to get the correct file
    final file = await _getLocalFile(userId);

    if (await file.exists()) {
      String jsonString = await file.readAsString();

      if (jsonString.isEmpty) return null;

      Map<String, dynamic> data = jsonDecode(jsonString);
      print('Loaded notebook for user ($userId)');
      return data;
    } else {
      print('No notebook found for user ($userId). Creating new one...');
      return null;
    }
  } catch (e) {
    print('Error loading data for user ($userId): $e');
    return null;
  }
}


ThemeData GreenLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
ThemeData GreenDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green[700],
  visualDensity: VisualDensity.adaptivePlatformDensity,
);


class ThemeProvider with ChangeNotifier {
  ThemeData currentTheme = GreenLight;


  ThemeData get _currentTheme => currentTheme;


  void switchTheme() {
    currentTheme == GreenLight
        ? currentTheme = GreenDark
        : currentTheme = GreenLight;
    notifyListeners();
  }
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
class StateMgmt extends StatefulWidget { // Standard class naming convention
  // Fields that are passed to the constructor belong here
  const StateMgmt({ // Make the constructor for the Widget class
    Key? key,
    required this.isLoading,
    this.Child = const SizedBox(), // Make Child optional with a default value (e.g., an empty SizedBox)
  }) : super(key: key);

  final bool isLoading;
  final Widget Child; // Define Child as a property of the Widget class

  @override
  // Correct createState method signature
  State<StateMgmt> createState() => _StateMgmtState();
}

class _StateMgmtState extends State<StateMgmt> {
  // State variables that change over time belong here
 // InterstitialAd? _interstitialAd; // Nullable InterstitialAd instance (Assuming this is state)
  bool startedAd  = false;
  // TODO: Replace this with your own interstitial ad unit ID for production
  // Use test IDs during development!
//  String get _adUnitId {
  //    return 'ca-app-pub-3940256099942544/4411468910'; // Test Android Interstitial}

  @override
  void initState() {
    super.initState();
    // Load the interstitial ad when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the Referencer model instance and call its load method
      // listen: false because we only want to call a method, not rebuild this State object
      try {
        Provider.of<Referencer>(context, listen: false)._loadInterstitialAd();
      }
      catch (e) {
        print("THIS IS THE PROBLEM");
      }
   });
  }
  @override
  void dispose() {
    // No ad disposal needed directly in this State anymore
    super.dispose();
  }
  // Loads the interstitial ad

 // const LoadingWithStateMgmt({
  //  Key? key,
  //  required this.isLoading,
 //   required this.Child,
 // }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // --- This is where you "Get the model instance (provided higher up)" ---
    // Providerof<MyDataModel>(context) looks UP the tree from this widget's context
    // to find the nearest MyDataModel instance provided by a Provider.
    // The 'listen: false' is important here because we only want to CALL a method (loadData)
    context.read<Referencer>().set_Notebook();

    return Scaffold(
        appBar: AppBar(title: Text('Kangarule')),
        body: Center(
          // Use a Consumer or another Provider.of (with listen: true or context.watch)
          // if the widget *itself* needs to rebuild when the state changes.
          // In this case, we'll use a Consumer to react to isLoading changes.

          child: Consumer<Referencer>(
            builder: (context, model, child) {
              return
                // If showContinueButton is true (ad is done/failed), show the Image and the Continue button
                Column(
                  children: [
                    // Other widgets...
                    Expanded( // Or Flexible()
                      child: Image(
                          image: AssetImage('assets/pics/movetopics.jpg')),
                    ),
                    SizedBox(
                      width: double.infinity,
                      // Make the SizedBox take the full available width
                      child: ElevatedButton(
                        onPressed: () {
                         if (startedAd == false) { //model.showContinueButton
                         //     ?
                          model._showInterstitialAd(
                            onAdDismissed: () {
   Navigator.of(context).push(
                             MaterialPageRoute(
                                 builder: (context) => widget.Child
                              )
                         );
    }
                          );
                           startedAd = true;
                          //    :
                         }
                        //  Navigator.of(context).push(
                         //     MaterialPageRoute(
                         //         builder: (context) => widget.Child
                         //     )
                       //   );
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                    // Other widgets...
                  ],
                );
              }
          ),
        )
    );


  }
}

DatabaseReference ref = FirebaseDatabase.instance.ref('language');
class Referencer extends ChangeNotifier {
  InterstitialAd? _interstitialAd; // Private field for the ad object
  bool _isAdLoaded = false; // Private field for ad loaded state
  bool _showContinueButton = false; // Private field for showing continue button
  Map<String, dynamic>? loadedData;

  // TODO: Replace with your actual interstitial ad unit ID
  final String _adUnitId = 'ca-app-pub-3940256099942544/4411468910'; // Test ad unit ID

  // Public getters to access the state from widgets
  bool get isAdLoaded => _isAdLoaded;
  //I DON'T THINK THIS IS PROPERLY IMPLEMENTED CHECC HERE
  bool get showContinueButton => _showContinueButton;

  //just the userinfo
  Map info = {};
  bool _isLoading = false;
  bool get isLoading => _isLoading;
 // Map socialite = {};
  List photo = ["0", "ER"];
  List whenReady = List.empty(growable: true);

  //this ^^^ is for the list of status ids per user
  //late int saveUser;
  //this
  //is
  //harcdoed
  //dont leave this
  String saveUser = "1";
  // late final String saveUser;

//change this
  int exp = 0;
  bool anonTag = false;

  //before
  //production

  late Map Notebook;
  Map Lemx = {};

  // late int exp;


  Map get _info => info;
  Map get _Lemx => Lemx;

 // Map get _socialite => socialite;

  List get _whenReady => whenReady;

  BannerAd? _bannerAd;
  bool _isBAdLoaded = false;

  BannerAd? get bannerAd => _bannerAd;
  bool get isBAdLoaded => _isAdLoaded;
  String uid = "";
  //CAUSE FOR CONCERN

  // 2. This is the function you requested.
  void setUser(String newUid) {
    uid = newUid;
    
    // Optional: Call this only if the UI needs to rebuild 
    // immediately after setting the ID. If you are just setting 
    // it to use inside 'changi' right after, you don't need this.
   // notifyListeners(); 
  }

  // Method to load the banner ad
// Method to load the banner ad
  // Accepts callbacks to communicate loading status back to the widget.
  void loadBannerAd({
    required BuildContext context,
    required Function(BannerAd) onAdLoadedCallback,
    required Function(LoadAdError) onAdFailedToLoadCallback,
  }) {
    debugPrint('Referencer: loadBannerAd called.');
    // Dispose of any existing ad before loading a new one
    _bannerAd?.dispose();
    _bannerAd = null; // Clear the old ad instance
    // No notifyListeners() here

    // Get the appropriate ad unit ID based on the platform
    String adUnitId;
    try {
      adUnitId = 'ca-app-pub-3940256099942544/4411468910'; // Assuming AdHelper can get platform or you pass it
    } catch (e) {
      debugPrint('Referencer: Failed to get ad unit ID: $e');
      // Call the failure callback directly if ad unit ID can't be determined
      // Pass a dummy error or handle appropriately
      //onAdFailedToLoadCallback(LoadAdError(0, 'Failed to get ad unit ID', 'domain'));
      return; // Stop loading
    }


    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: AdRequest(),
      size: AdSize.banner, // Choose an appropriate size
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Referencer: Ad loaded.');
          // Call the provided callback instead of notifyListeners()
          onAdLoadedCallback(ad as BannerAd); // Cast is safe here
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Referencer: Ad failed to load: $error');
          ad.dispose();
          _bannerAd = null; // Clear the ad instance on failure
          // Call the provided callback instead of notifyListeners()
          onAdFailedToLoadCallback(error);
        },
        onAdOpened: (ad) => debugPrint('Referencer: Ad opened.'),
        onAdClosed: (ad) => debugPrint('Referencer: Ad closed.'),
      ),
    )..load(); // Start loading
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(), // Standard ad request
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when the ad is successfully received.
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('InterstitialAd loaded.');
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
          notifyListeners();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Referencer() {
    debugPrint('Referencer initialized, loading ad...');
    _loadInterstitialAd(); // Initiate ad loading when the model is created
  }

  // Shows the loaded interstitial ad
  void _showInterstitialAd({required VoidCallback onAdDismissed}) {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      // Optionally load another ad here if it's null
      _loadInterstitialAd();
      onAdDismissed();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      // Called when the ad showed the full screen content.
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdShowedFullScreenContent.');
      },
      // Called when an impression occurs on the ad.
      onAdImpression: (InterstitialAd ad) {
        debugPrint('$ad onAdImpression.');
      },
      // Called when the ad failed to show full screen content.
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        // Dispose the ad here to free resources.
        ad.dispose();
        // Optionally load another ad here
        _loadInterstitialAd();
        onAdDismissed();
      },
      // Called when the ad dismissed full screen content.
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        // Dispose the ad here to free resources.
        ad.dispose();
        // Optionally load another ad here for the next time
        _loadInterstitialAd();
        onAdDismissed();
      },
      // Called when a click is recorded for an ad.
      onAdClicked: (InterstitialAd ad) {
        debugPrint('$ad onAdClicked.');
      },
    );

    // Show the ad
    _interstitialAd!.show();

    // Nullify the ad instance after showing as it can only be shown once
    _interstitialAd = null;
  }

  @override
  void dispose() {
    // Dispose the ad when the widget is removed
    _interstitialAd?.dispose();
    _bannerAd?.dispose(); // Dispose the banner ad
    super.dispose();
  }

  void changeInfo(String x, Map filler) {
    info[x] = filler;
    notifyListeners();
  }

  void changeSocial(String x, Map filler) {
    //this won't work because it as the error
    //annot assign parameter to string
    //remember when i uploaded it and it would make indexes
    //for all the status ids
    //so i think at some point i need to enumerate
    //whenReady and += x so it will fit properly
    whenReady.add(x);
    print(whenReady);
   // socialite[x] = filler;
    notifyListeners();
    ref.child('ru/users/$saveUser/Statuses').set(whenReady);
    ref.child('ru/Statuses').update({x: filler});
  }

  void setPic(List thisthis) {
    photo = thisthis;
  }

  List returnPic() {
    return photo;
  }


  void takeout(x) {
    whenReady.remove(x);
   // socialite.remove(x);
    notifyListeners();

    ref.child('ru/users/$saveUser/Statuses').set(whenReady);
    ref.child('ru/Statuses/$x').remove();

  }
  void deleteMe() {
    ref.child('ru/users/$saveUser').remove();
  }


//this is importNT
  //and it needs to be added to production app
  //because it will mess up new users
  //CAUSE 4 CONCERN
  void openNotebook() {
    if (info["Notebook"] != null) {
      Notebook = info["Notebook"];
    }
    else {
       Notebook = {
        "Welcome":
  {
    "saved"
    : [
    [
    0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
    ],
    [
      0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
    ],
    [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
    ]
    ]
  }
  };
  info["Notebook"] = Notebook;
    }
  }

  
  void wayClear(String seekthis) {
    print(NB[seekthis]);
    if (NB[seekthis] ==
        null) {
      NB[seekthis] =
      {"saved": []};
    }


    exp = exp + 100;
    ref.child('ru/users/$saveUser/info/exp').set(exp);
  }

  void to_Notebook(seekthis, content) {
    List hold = [...NB[seekthis]["saved"]];
    print([NB]);
    hold.add([0, "$content"]);
    NB[seekthis]["saved"] = hold;
   // set_Notebook();
  }

  void changeColor(int colorkeeper, int x, String seekthis) {
    NB[seekthis]["saved"][x][0] = colorkeeper;
  }

  void clean_Notebook(String titleKey, int x) {
    NB[titleKey]["saved"].removeAt(x);
  }

  Map getallNotes() {
    return Notebook;
  }

  Map getallStati() {
    return {}; // socialite;
  }

  int getExp() {
    return exp;
  }

  String getUser() {
    return uid ?? "";
  }

  //void setUser(String uuid ) {
  //   saveUser = uuid;
  // }


  Future<void> changi() async {
    _isLoading = true;
    notifyListeners();

    ref.child('ru/users/$uid').get().then((snapshot) async {
    final data = Map.from(snapshot.value as Map);
    //THIS NEEDS A TRY ... CATCH AND THE FINALLY { SHOULD BE HERE
    info = data; //['info'];
    anonTag = false;
    try {
        info["lessons"];
      //if this works and user doesn't have lessons it will be empty
    } catch (e) {
       info["lessons"] = flatten(tierkeeper);
    }
    //alessons
    try {
      Lemx = data['lemmas'];
    }
    catch (e) {
      //THIS NEEDS TO UPDATE FIREBASE
      data['lemmas'] = {0:0};
      Lemx =data['lemmas'];
    };
      //CAUSE FOR CONCERN
   // setPic(info["info"]["photo"]);
    info["info"]["photo"] = ["4", "UP"];
    //openNotebook();
    //await NB = loadNestedJsonFromFile();
    loadedData = await loadNestedJsonFromFile(uid);
      //CAUSE 4 CONCERN anontag
    if (loadedData != null) {
        NB = loadedData!;
    } else {
      NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};
    }
    _isLoading = false;
    notifyListeners(); // Notify UI that loading has finished
  }
    );
        }

  Future<void> anonSet(bool myValue) async {
  _isLoading = true;
  notifyListeners();

  try {
    // 1. Prepare the raw data structure
    final data = {
      "info": {
        "exp": 0,
        "handle": "Guest",
        "lang": "ru",
        "photo": ["4", "UP"],
      },
      // SAFETY CHECK 1: Wrap external functions like flatten()
      "lessons": [], 
      "lemmas": {1: 100},
    };

    // Try to flatten tierkeeper safely
    try {
       data["lessons"] = flatten(tierkeeper);
    } catch (e) {
       print("⚠️ Error flattening tierkeeper: $e");
       data["lessons"] = []; // Fallback to empty list
    }

    anonTag = myValue;
    info = data;

    // 2. SAFETY CHECK 2: jsonDecode is the most common crasher
    try {
      List aLessons = jsonDecode(forEducation.all);
      info["lessons"] = aLessons;
    } catch (e) {
      print("⚠️ Error decoding lessons JSON: $e");
      // Fallback: don't crash, just leave lessons as is
    }

    // 3. Handle Lemmas
    try {
      Lemx = data['lemmas'] as Map;
    } catch (e) {
      data['lemmas'] = {0: 0};
      Lemx = data['lemmas'] as Map;
    }

    // 4. Set the Notebook (This is the important part for you!)
    NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};
  } catch (e) {
    // CATCH-ALL: If anything else above explodes, print it but don't stop the app
    print(" CRITICAL ERROR in anonSet: $e");
  } finally {
    // 5. ALWAYS FINISH
    // This 'finally' block runs no matter what.
    _isLoading = false;
    notifyListeners();
  }
}

  void sendtoLessons(List lessons) {
    ref.child('ru/users/$saveUser/lessons').set(lessons);
    info["lessons"] = lessons;
    //notifyListeners();
  }

  void set_Notebook() {
    print(NB);
    if (anonTag == false) {
    saveNestedJsonToFile(NB, uid);
    }

    //check to make asure colors are updating
  }

  void addComment(String text, List pic, String postid) {
    Map socialite = {};
    try {
      if (socialite[postid]["comments"][0] == 'empty') {
        socialite[postid]["comments"][0] = text;
        //this needs to be a variable
        socialite[postid]["commentUsers"][0] = pic;
      }
      else {
        List bullshit = [...socialite[postid]["comments"]];
        bullshit.add(text);
        socialite[postid]["comments"] = bullshit;
        List extra = [...socialite[postid]["commentUsers"]];
        extra.add(pic);
        socialite[postid]["commentUsers"] = extra;

      }
      ref.child('ru/Statuses/$postid/comments').set(
          socialite[postid]["comments"]);
      ref.child('ru/Statuses/$postid/commentUsers').set(
          socialite[postid]["commentUsers"]);
    }

    catch

    (

    e

    ) {}
  }

  void novarlemmaSet(Map lemmas) {
   // ref.child('ru/users/$saveUser/lemmas').set(lemmas);
    Lemx = lemmas;
  }

  Map getLemma() {
    return Lemx;
  }

  void firstTime(List pic, String handle) {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {
        Map grabit=
        //{
        // user.uid:
        {
          "info"
              : {
            "exp": 0, "handle": handle, "lang": "ru", "photo": pic, "Statuses": [0]
          },
          "lessons": flatten(tierkeeper),
          //"Notebook": {"None":0},
          //   }
        };
        ref.child('ru/users').update({user.uid: grabit});
      };
    }

    );

  }



}
class LoadingWithStateMgmt extends StatelessWidget {
  final bool isLoading;
  final Widget Child; //MAKE A DEFAULT FOR THIS SO WHEN THE HOME OPENS...

   const LoadingWithStateMgmt({
     Key? key,
     required this.isLoading,
     required this.Child,
   }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // --- This is where you "Get the model instance (provided higher up)" ---
    // Providerof<MyDataModel>(context) looks UP the tree from this widget's context
    // to find the nearest MyDataModel instance provided by a Provider.
    // The 'listen: false' is important here because we only want to CALL a method (loadData)
    // and NOT rebuild this specific widget when the model changes.


    // If you wanted the widget to rebuild when _isLoading or _data changes,
    // you would either omit 'listen: false' (as listen defaults to true)
    // or use context.watch<MyDataModel>() which is the newer syntax for listening.
    // final dataModelForWatching = context.watch<MyDataModel>();

    debugPrint('StateMgmt being triggered'); // Add this log
    return Scaffold(
      appBar: AppBar(title: Text('Kangarule')),
      body: Center(
        // Use a Consumer or another Provider.of (with listen: true or context.watch)
        // if the widget *itself* needs to rebuild when the state changes.
        // In this case, we'll use a Consumer to react to isLoading changes.
        child: Consumer<Referencer>(
          builder: (context, model, child) {
            return //model.isLoading // Check the loading state from the mode ?
              Column(
                children: [
                  // Other widgets...
                  Expanded( // Or Flexible()
                    child: Image(image: AssetImage('assets/pics/movetopics.jpg')),
                  ),
                  SizedBox(
                    width: double.infinity, // Make the SizedBox take the full available width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Child
                            )
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                  // Other widgets...
                ],
              );
          },
        ),
      )
    );
  }
}


class myIndicator extends StatelessWidget {
  myIndicator({super.key,
    required this.progress,
    required this.size
  });
  late double progress;
  late double size;
  List fake = ["You're doing it!", "Great work.", "Are you speaking yet?", "I love you.", "Keep trying!", "You can make it!", "Good job!", "Practice makes perfect!", "A lesson a day..."];
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80.0,
      //60.0,
      lineWidth: 5.0,
      percent: progress,
      center: Text((fake..shuffle()).first),
      progressColor: Colors.green,
    );
  }
}



class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

}








const List texttileTheme = [Colors.black, Colors.blue, Colors.red, Colors.green, Colors.purple, Colors.yellow, Colors.pink, Colors.white];
const List boxTheme = [Colors.white, Colors.orange, Colors.green, Colors.red, Colors.yellow, Colors.purple, Colors.green, Colors.black ];







Iterable<List<T>> zip<T>(Iterable<Iterable<T>> iterables) sync* {
  if (iterables.isEmpty) return;
  final iterators = iterables.map((e) => e.iterator).toList(growable: false);
  while (iterators.every((e) => e.moveNext())) {
    yield iterators.map((e) => e.current).toList(growable: false);
  }
}




class ProgressIndicatorApp extends StatelessWidget {
  const ProgressIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProgressIndicatorExample(),
    );
  }
}

class ProgressIndicatorExample extends StatefulWidget {
  const ProgressIndicatorExample({super.key});

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const CircularProgressIndicator(
              value: .5,
              semanticsLabel: '',
            ),
          ],
        ),
      ),
    );
  }
}





class MyCard extends StatelessWidget {
  const MyCard({super.key,
   // required this.handle,
    required this.exp,
   // required this.useasImage,
  });
  //final String handle;
  final String exp;
  //final List useasImage;

  @override
  Widget build(BuildContext context) {
    return
      Container(
          color: Colors.red.withOpacity(.3),
          alignment: Alignment.center,
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child:
                ListTile(
                 // leading:  _UserImage(picture: context.read<Referencer>().returnPic()),
                  title: Text(exp,
                    style:TextStyle(fontSize:
                    AdaptiveTextSize().getadaptiveTextSize(context, 16)), ),
                )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Exercises'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Sentences(sentencestart: {} )
                        )
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Test'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  //  )
                )
              ]
          )
      );
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //CAUSE 4 CONCERN IM  STILL SEEING ADS
//unawaited(MobileAds.instance.initialize());
await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
);


//try{
//final auth = FirebaseAuth.instance;
//} catch (e) {
// ignore: avoid_print
//  await Firebase.initializeApp();
//}




SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    .then((_) {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider<User?>( // Ensure type is correct, User? if authStateChanges emits null
          initialData: null,
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) {
            final referencer = Referencer();
            // Call your initialization method on the Referencer instance here.
            //referencer.initializeAds(); // Assuming Referencer has this method now
            return referencer;
          },
        ),
      ],
      child: const HelloFlutterApp(), // HelloFlutterApp is now a StatelessWidget or StatefulWidget without MultiProvider in build()
    ),
  );
});
}

// HelloFlutterApp can now be a StatelessWidget since MultiProvider is gone from its build method
class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({super.key}); // Add const constructor

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, Referencer>( // You can keep the Consumer here
        builder: (context, ThemeProvider themeprovider, Referencer reffy, child) {
          return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context, listen: true).currentTheme,
          //CHANGERU
          home: myForm() //MyHomePage()
          )
            // Your app's main content and routing starts here
            // Example:
            // return MaterialApp(
            //   title: 'My App',
            //   theme: themeprovider.currentTheme,
            //   home: AuthWrapper(), // Or your initial screen
            // );
          );
        }
    );
  }
}

class myForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return MyHomePage();
    }
    return SignIn();
  }
}
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}


class SignInState extends State<SignIn> {
  late final auth = FirebaseAuth.instance;
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.red);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool Dunn = false;
  String? _errorMessage;

  void _clearError() {
    setState(() {
      _errorMessage = null;
    });
  }


  void gateKeep(Map foo) {
    try {
      if (foo["info"]["handle"] != null) {
        Dunn = true;
      }
    }
    catch (e) {print("caught");}
  }

  //bool fool = false;


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("login being built");
    final localHeight =  MediaQuery.of(context).size.height;
    return  Scaffold(
        body: //StreamBuilder<User?>(
        //stream: auth.authStateChanges(),
        //builder: (context, snapshot) {
        //return
        SafeArea(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                  child: TextField(
                        controller: emailController,
                        maxLength: 45,
                        maxLines: 1,
                        onSubmitted: (String value) {if(value.isNotEmpty && value != null){
                          TextInputAction.next;

                        }
                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                  )
                      ),
                      Expanded(
                          child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                          )
                      ),
                      Expanded(
                          child: Visibility(
                        visible : _active,
                        child: TextField(
                          maxLength: 30,
                          controller: confirmController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                          ),
                        ),
                          )
                      ),
                      Expanded(
                          child: Visibility(
                        visible : _active,
                        child: TextField(
                          maxLength: 45,
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: "Choose username",
                          ),
                        ),
                          )
                      ),


                      Expanded(
                          child: ElevatedButton(
                          style: style,
                          child: Padding(
                              padding: //EdgeInsets.all(32.0),
                              EdgeInsets.all(localHeight * .007),
                              child: const Text("Create user", textScaleFactor: 1.8)
                          ),
                         onPressed: () async {
                            if (_active == false) {
                              setState(() => _active = true);
                            }
                            else {
                              if (passwordController.text.trim() ==
                                  confirmController.text.trim() &&
                                  usernameController.text.length != 0) {
                                try {
                                  UserCredential userCredential = await FirebaseAuth
                                      .instance.createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  if (FirebaseAuth.instance.currentUser != null) {
                                      context.read<Referencer>().setUser(FirebaseAuth
                                         .instance.currentUser!.uid);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuizPage(
                                                  handle: usernameController.text)
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('The password provided is too weak.')));

                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("The account already exists for that email.")));

                                  }
                                }
                              }
                              else if (passwordController.text.trim() !=
                                  confirmController.text.trim() &&
                                  usernameController.text.length != 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Passwords do not match.")));
                              }
                              else if (passwordController.text.trim() ==
                                  confirmController.text.trim() &&
                                  usernameController.text.length == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please enter a username.")));

                              }
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //  const SnackBar(content: Text("TODO: Create user with email/password")));
                            }
                          }
                          )
                      ),

                      Expanded(
                          child: ElevatedButton(
                          style: style,
                          child: Padding(
                              padding:  EdgeInsets.all(localHeight * .007),
                              //I NEEDI CHANGI HERE
                              child: const Text("Google Sign-in", textScaleFactor: 2.2)),
                          onPressed: () async {
                            GoogleAuthProvider googleProvider = GoogleAuthProvider();

                            googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
                            //googleProvider.setCustomParameters({ 'login_hint': 'user@example.com' });
                            await FirebaseAuth.instance.signInWithPopup(googleProvider);
                            try {
                              if (FirebaseAuth.instance.currentUser != null) {
                                   context.read<Referencer>().setUser(FirebaseAuth
                                       .instance.currentUser!.uid);

                                //context.read<Referencer>().changs();

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()
                                  ),
                                );
                              }
                            }
                            catch(e) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => QuizPage(handle: "Google")
                                ),
                              );
                            }
                          }
                          )
                      ),

                      Expanded(
                          child: ElevatedButton(
                        style: style,
                        child:Padding(
                            padding:   EdgeInsets.all(localHeight * .007),
                            child: Text("Submit", textScaleFactor: 1.8)),
                        onPressed: () async {
                           // 1. Anonymous / Empty Check
  if (emailController.text.isEmpty && passwordController.text.isEmpty) {
    await context.read<Referencer>().anonSet(true);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MyHomePage())
    );
    return; // STOP here
  }

  // 2. Real Login
  try {
    // A. Wait for Sign In (No .then, No .listen)
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
    );

    // B. Check if it worked
    if (userCredential.user != null) {
      if (!mounted) return;

      final ref = context.read<Referencer>();
      ref.setUser(userCredential.user!.uid);

      // C. NOW we can safely await because we are in the main 'async' block
      await ref.changi(); 

      // D. Navigate only after changi finishes
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyHomePage())
        );
      }
    }
  } catch (e) {
    print(e);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid login!"))
      );
    }
  }
},
                            ),
                        ),
                    ]
                )
            )
        )
        )
    );

  }
}
final Map lessonmaker = jsonDecode(forEducation.all);
List tierkeeper = [['nouns', 'tohave', 'canI', 'verbintro', 'pronounintro'], ['accusative', 'dative', 'instrumental', 'genitive', 'prepositional'], ['impersonalconstructions', 'posessivepronouns', 'interrogativepronouns', 'sayingand', 'demonstrativepronouns', 'relativepronouns'], ['positional', 'aspect', 'irregularaspect', 'imperatives', 'howtosayIlike'], ['dativeforobligations', 'askingquestions', 'howtosayshopping', 'reflexiveverbs', 'reflexivepronouns'], ['verbsofmotion', 'futuretense', 'pasttense', 'timephrases', 'past&futureobligations', 'sayingbeforeandafter'], ['adjectives', 'shortformadjectives', 'howtosayif', 'adverbs', 'adverbsII'], ['HaII', 'Dativeadvanced', 'wordswithnuances', 'irregularverbs', 'makingcomparisons']];

List tier = tierkeeper[0];

String assigner(grade) {
  if (grade < 500) {tier = tierkeeper[0]; return "young buck";}

  else if (grade >= 500 && grade < 1000) {tier = tierkeeper[1]; return "diamond digger";}

  else if (grade >= 1000 && grade < 1600) {tier = tierkeeper[2];  return "viber thriver";}
//this is wrong
  else if (grade >= 1600 && grade < 2100) {tier = tierkeeper[3];  return "star jar opener";}

  else if (grade >= 2100 && grade < 2700) {tier = tierkeeper[4];  return "rickshaw runner";}

  else if (grade >= 3200 && grade < 3700) {tier = tierkeeper[5];  return "teacher reacher";}

  else if (grade >= 3700 && grade < 4300) {tier = tierkeeper[6];  return "student master";}

  else if (grade >= 4300) {tier = tierkeeper[7]; return "owl slayer";}

  else {return "not found";}


}
String tierday(grade) {
  if (grade <= 5) {return "tier1";}

  else if (grade > 5 && grade <= 10) {return "tier2";}

  else if (grade > 10 && grade <= 16) {return "tier3";}

  else if (grade > 16 && grade <= 21) {return "tier4";}

  else if (grade > 21 && grade <= 26) {return "tier5";}

  else if (grade > 26 && grade <= 32) {return "tier6";}

  else if (grade > 32 && grade <= 37) {return "tier7";}

  else if (grade > 37) {return "tier8";}

  else {return "not found";}


}


class MyHomePage extends StatefulWidget {
  const MyHomePage ({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  Future<String> startUp() async {
  final referencer = Provider.of<Referencer>(context, listen: false);
  final user = FirebaseAuth.instance.currentUser;

  // 1. SYNC: If a real user is logged in, force Referencer to use THEIR ID.
  // (Without this, Referencer uses the default 'anontag' and loads blank data)
  if (user != null && !user.isAnonymous) {
     // Assuming 'anontag' is the variable you use for the DB path
     referencer.saveUser = user.uid; 
  }

  // 2. FETCH: Now that the tag is correct, load the data into 'info'
  if (referencer.info.isEmpty) {
    //CAUSE FOR CONCERN
    await referencer.anonSet(true);
  }

  return "Done";
  }


  void _moveState(context, where) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => where
      ),

    );
  }


  late TextEditingController dontroller;
  late double fanalexp;
//late
  Map _dump = {};
  String saveuserName = "";
  List privet = [];
  Map allStati = {};
 late List icon;
 late List aLessons;
  //CAUSE FOR CONCERN
// final List aLessons = flatten([['nouns', 'tohave', 'canI', 'verbintro', 'pronounintro'], ['accusative', 'dative', 'instrumental', 'genitive', 'prepositional'], ['impersonalconstructions', 'posessivepronouns', 'interrogativepronouns', 'sayingand', 'demonstrativepronouns', 'relativepronouns'], ['positional', 'aspect', 'irregularaspect', 'imperatives', 'howtosayIlike'], ['dativeforobligations', 'askingquestions', 'howtosayshopping', 'reflexiveverbs', 'reflexivepronouns'], ['verbsofmotion', 'futuretense', 'pasttense', 'timephrases', 'past&futureobligations', 'sayingbeforeandafter'], ['adjectives', 'shortformadjectives', 'howtosayif', 'adverbs', 'adverbsII'], ['HaII', 'Dativeadvanced', 'wordswithnuances', 'irregularverbs', 'makingcomparisons']]);
  


//List icon = context.read<Referencer>().returnPic();


  void clearText() {
    String postbount = uuid.v4() as String;
    Map grabit = {
      "comments": ["empty"],
      "commentUsers": [["empty", "empty"]],
      "info": {
        "date": DateFormat.yMMMd().format(DateTime.now()),
        "handle": "dontmatter",
        "photo": "WD" //context.read<Referencer>().returnPic()
      },
      "post": dontroller.text,
    };
    //context.read<Referencer>().changeSocial(postbount, grabit);
    dontroller.clear();
  }


  @override
  void initState() {
    super.initState();
    //context.read<Referencer>().getReady();
    //fanalexp = assigner(context.read<Referencer>().getExp());
    quiccfunk();
    dontroller = TextEditingController();
  }

  @override
  void dispose() {
    //I think I want to make a stream for comments
    //I ned to dispose of stream too
    dontroller.dispose();
    super.dispose();
  }


  List Routes = [];


  void quiccfunk() {
    for (var i in tier) {
      Routes.add(HiFlutterApp(
          seeker: i, fun: lessonmaker[i]));
    }
  }

  Future<void> onLaunch() async {
    await Future(() {}); // <-- Dummy await
    // This code runs after build ...
    //use this instead of futurebuilder
  }


  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        appBar: AppBar(
          actions: [

            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyHomePage())
                    ),
                  );
                },
                icon: Text(
                    '🏠', // Home emoji
                    style: TextStyle(
                      fontSize: 24, // Adjust size to look like an icon
                      color: Colors.white, // Adjust color
                    )
                )
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                  ),
                );
              },
              icon: const Icon(Icons.auto_stories),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                )
                );
              },
              icon: const Icon(Icons.local_laundry_service),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MySettings())
                  ),
                );
              },
              icon: const Icon(Icons.miscellaneous_services),
            ),
            IconButton(
              onPressed: () {
                context.read<ThemeProvider>().switchTheme();
              },
              icon: Icon(Icons.sunny_snowing),
              //I want to make an icon animation  on click
              //so when going to different mode
              //switches to sunny for light
            ),
          ],
        ),
        body:
        FutureBuilder(
            future: startUp(), //onLaunch(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               // final _dump = Provider.of<Referencer>(context, listen: false).info;
                //CAUSE FOR CONCERN ADD THIS BACCIN
                //final Map<String, dynamic> _dump = (context.read<Referencer>().info as Map<String, dynamic>?) ?? {};
                //final Map<String, dynamic> _dump = context.read<Referencer>().info ?? {};
               //final fanalexp = assigner(context.read<Referencer>().getExp());
                final Map<String, dynamic> _dump = 
    (Provider.of<Referencer>(context, listen: false).info as Map<String, dynamic>?) ?? {};
               // final rawValue = context.read<Referencer>().getExp();
                final rawValue = Provider.of<Referencer>(context, listen: false).getExp();
                if (rawValue == null || rawValue is! num) {
                  //CAUSE 4 CONCERN rawValue shud be String
                fanalexp = 10.0;
                } else {
                fanalexp = (rawValue ?? 10.0).toDouble();
                }
                //final fanalexp = assigner(_dump["info"]["exp"]);
                //final icon = context.read<Referencer>().returnPic();
               // List icon = (_dump['info'] as Map<String, dynamic>?)?['photo'] as List? ?? []; 
               // String saveuserName = (_dump['info'] as Map<String, dynamic>?)?['handle'] as String? ?? "N/A";
                String saveuserName = _dump["info"]?["handle"] ?? "N/A"; //_dump["info"]["handle"];
                //int saveuserexp = _dump["info"]["exp"];
                // List privet = _dump["Statuses"];
                #ANONBLACK
               List icon = _dump["info"]?["photo"] ??  ["4", "UP"]; //_dump["info"]["photo"];
                //context.read<Referencer>().setPic(icon);
                //final icon = context.read<Referencer>().returnPic();
                //but comments need to be streamed in realtime
                //CAUSE FOR CONCERN GET THIS WORKING
               List aLessons = _dump["lessons"] ?? [];
                return
                  Scrollbar(
                      trackVisibility: true,
                      thumbVisibility: true,
                      thickness: 12.0,
                      child: SingleChildScrollView(
                          child: Column(
                              children: [Row(
                                //mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      //  mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(
                                                        12.0),
                                                    child: myIndicator(
                                                        progress: fanalexp / 4200.0, //(context.read<Referencer>().getExp() / 4200),
                                                        size: double.infinity)
                                                  //progress:_dump["language"][saveuserLang]["users"][saveUser]["info"]["exp"] / 4400 , size: double.infinity)
                                                  ),
                                                Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child:

                                                  Container(
                                                    height: screenHeight / 6,
                                                    width: screenWidth / 2.1,
                                                    color: Colors.white,
                                                    child:
                                                   Center(
            child: MyCard(exp: assigner(fanalexp) )                         
        ),
                                                  ),

                                                  //   ]
                                                ),
                                              ],
                                            )
                                        ),
                                        //   Center() child:
                                        Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              alessons: aLessons)),
                                                );
                                              },
                                              child: const Text('All Lessons'),
                                            )
                                        ),
                                    
                                    Container(
                                      // alignment: Alignment.topRight,
                                      height: screenHeight / 3,
                                      width: screenWidth / 2.2,
                                      child: MyApp( //active: _active,
                                        //onChanged: _handleTapboxChanged,
                                        onSelected: (Routes) {
                                          _moveState(context, Sentences);
                                        },
                                        //(customer) { _moveState(context);

                                        //   },
                                        items: List<ListTile>.generate(
                                            tier.length,
                                                (i) =>
                                            tier[i] != null
                                                ? ListTile(title:
                                            Text('${tier[i]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),),
                                                minVerticalPadding: 12,
                                                onTap: () {
                                                  _moveState(
                                                      context, Routes[i]);
                                                }
                                            )
                                                : ListTile(
                                                title:
                                                Text('Sender')
                                            )
                                        ),

                                      ),
                                    ),
  ]
                                  ),


                                  ]
                              ),
                                //  Column(children:
                                // [
                                TextField(
                                  //add gesturedetector because the only way to get rid of keyboard
                                  // is posting
                                    enabled: false,
                                    keyboardType: TextInputType.name,
                                    //expands: true,
                                    controller: dontroller,
                                    onSubmitted: (String value) {
                                      if (value.isNotEmpty && value != null) {
                                        //I need to update with json data where this leads
                                        clearText();
                                      }
                                    },

                                    //make this box lookj different thab comment box
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.red),
                                      hintText: "Put your wiki-style edits here! <Lesson> : suggestion",
                                      filled: true,
                                      fillColor: Colors.blueAccent,
                                      contentPadding: EdgeInsets.all(25),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: double.infinity),

                                      ),
                                    )


                                )
                              ]
                          )
                      )
                  );
              }
              else {
                return Center(
                    child: Container(
                        decoration: BoxDecoration
                          (
                          color: Colors.black,
                          border: Border.all(),),
                        height:MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/pics/movetopics.jpg',
                            fit: BoxFit.contain)
                    )
                );
              };
            }

        )
    );
  }
}












class MyApp extends StatelessWidget {
  final List<ListTile> items;
  final Function(ListTile) onSelected;

  MyApp({super.key,
    // this.active = false,
    required this.onSelected,
    //  required this.onChanged,
    required this.items
  });




  // final bool active;
//  final ValueChanged<bool> onChanged;


  // @override
  // void initState() {
  //   super.initState();
//  }







  @override
  Widget build(BuildContext context) {
    const title = 'Agenda';

    return MaterialApp(
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.amber[100]
      ),
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: const Text(title),
        ),
        body:
        ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
                title: item.build(context),
                //trailing: Icon(Icons.check_circle_outline_sharp),
                onTap: () {
                  final customer = this.items[index];
                  this.onSelected(customer);
                }

            );
          },

          //paranthese here
        ),
      ),
    );
  }
}



/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);


}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context)
  {//was .shrink
    return SizedBox.shrink();
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => GestureDetector(
      child: Text(sender)
  );

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}



class HomePage extends StatefulWidget {
  late List alessons;


  HomePage({super.key,
    // this.active = false,
    required this.alessons,
    //  required this.onChanged,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate dummy data for the list view
  //final List<String> _products =
  //List.generate(100, (index) => "Product ${index.toString()}");
  late List allLessons;
  bool used = false;
  @override
  void initState() {
    super.initState();
    // fanalexp = assigner(_dump["info"]["exp"]);
    //this needs to be fixed
    allLessons = [...widget.alessons];

  }


  @override
  Widget build(BuildContext context) {
    //List alessons = _dump["language"]["ru"]["users"][saveUser]["info"]["lessons"];
    return
      MaterialApp(
          theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.black
          ),
          debugShowCheckedModeBanner: false,
          home:
          Scaffold(
            // drawer: NavDrawer(),
            //change this out
            //ScaffoldMessenger.of(context).hideCurrentSnackBar();
              appBar: AppBar(
                title: const Text('All Lessons'),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {if (used == true) {
                      context.read<Referencer>().sendtoLessons(allLessons);
                    }
                    setState(() {used = false;});
                    Navigator.of(context).pop();
                    }
                ),
              ),
              body:
              ReorderableListView.builder(
                  itemCount: allLessons.length,
                  itemBuilder: (context, index) {
                    final String productName = allLessons[index];
                    return
                      Card(
                          key:  //UniqueKey(),
                          ValueKey(productName),
                          color: Colors.amberAccent,
                          elevation: 1,
                          margin: const EdgeInsets.all(10),
                          child:
                          ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Text(
                                productName,
                                style: const TextStyle(fontSize: 15),
                              ),
                              trailing: const Icon(Icons.drag_handle),
                              onTap: () {try {Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>  StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: HiFlutterApp(
                                          seeker: allLessons[index], fun: lessonmaker[allLessons[index]]))
                                  ),
                                          );
                              } catch(e) {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                          HiFlutterApp(seeker: "nouns", fun: lessonmaker["nouns"])
                                    ));
                              };
                              }
                          )
                      );
                  },
                  // The reorder function
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final element = allLessons.removeAt(oldIndex);
                      allLessons.insert(newIndex, element);
                      used = true;
                    }
                    );
                  }
              )
          )
      );
  }
}
















class HiFlutterApp extends StatefulWidget {
  HiFlutterApp({Key? key,
    // this.active = false,
    required this.seeker,
    required this.fun
  }) : super(key: key);
  late String seeker;
  late List fun;
  @override
  _HiFlutterAppState createState() => _HiFlutterAppState();
}

class _HiFlutterAppState extends State<HiFlutterApp> {
  late String seeker;
  late List fun;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Memo',
      theme:  context.watch<ThemeProvider>().currentTheme,
      //context.read<SwitchThemeCubit>().state,
      home: MyRomePage(seeker: widget.seeker, fun: widget.fun),
      //selfid: widget.seeker),
    );
  }
}


//class MyRomePage extends StatelessWidget {
// MyRomePage({super.key,
// this.active = false,
//  required this.selfid
// });



class MyRomePage extends StatefulWidget {
  MyRomePage({Key? key,
    // this.active = false,
    required this.seeker,
    required this.fun
  }) : super(key: key);
  late String seeker;
  late List fun;
  @override
  _MyRome createState() => _MyRome();
}

class _MyRome extends State<MyRomePage> {
  late String saveUser;
  late Future<String> dum;
  late String _seeker;
  late List _fun;
  Map _dump = {};
 // final anonMine = Provider.of<Referencer>(context, listen: false).anonTag;










  Map mmaker(String title) {
    Map placeholder = {"id": "", "saved": []};
    placeholder["id"] = title;
    placeholder["saved"] = [];
    //placeholder["color"] = [0];
    return placeholder;
  }



  void local_Notebook(context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.thumb_up),
              const SizedBox(width: 20),
              const Expanded(child: Text('Sent to notebook!'),
              ),
            ],
          ),
        )

    );
  }

  @override
  void initState() {
    super.initState();
    //context.read<Referencer>().openNotebook();
    String saveUser = context.read<Referencer>().getUser();
    context.read<Referencer>().wayClear(widget.seeker);
    _fun = widget.fun;
    _seeker = widget.seeker;
  }



  @override
  //Widget build(BuildContext context) => DefaultTabController (
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future((){}),
        //Future.wait([catchtheFeeling(selfid)]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //Map tryme = snapshot.data;
            final fun = widget.fun;
            //final List<int> savethis = snapshot.data.toList();
            // String trythis = utf8.decode(savethis);



            return DefaultTabController(
                length: fun.length,
                child: Scaffold(
                  //  key: scaffoldKey,
                   // drawer: NavDrawer(),
                    appBar: AppBar(
                     // centerTitle: true,
                    //  title: Text('Kangarule'),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyHomePage())
                                ),
                              );
                            },
                            icon: Text(
                                '🏠', // Home emoji
                                style: TextStyle(
                                  fontSize: 24, // Adjust size to look like an icon
                                  color: Colors.white, // Adjust color
                                )
                            )
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                              ),
                            );
                          },
                          icon: const Icon(Icons.auto_stories),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                            )
                            );
                          },
                          icon: const Icon(Icons.local_laundry_service),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MySettings())
                              ),
                            );
                          },
                          icon: const Icon(Icons.miscellaneous_services),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ThemeProvider>().switchTheme();
                          },
                          icon: Icon(Icons.sunny_snowing),
                          //I want to make an icon animation  on click
                          //so when going to different mode
                          //switches to sunny for light
                        ),
                      ],
                      bottom: TabBar(
                        tabs: [
                          ...List<Widget>.generate(
                              fun.length,
                                  (i) => Icon(Icons.album)
                          )
                        ], //tabs
                      ), //TabBar
                    ), // Appbar

                    body: Center(
                      //on every last page I need a route to the Exercises
                      child: TabBarView(
                        //controller: _tabController,
                        children: [...List<Widget>.generate(
                          fun.length,
                              (i) =>
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [Expanded(
                                      child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: SelectableText.rich(TextSpan(
                                                text: '${fun[i]} ',
                                                style:TextStyle(fontSize:
                                                AdaptiveTextSize().getadaptiveTextSize(context, 20)),
                                              )
                                              )
                                          )
                                      )
                                  ),
                                    TextButton(
                                      onPressed: () =>

                                      {
                                       // NB[_seeker]['saved'].add([0, fun[i]]),
                                        context.read<Referencer>().to_Notebook(_seeker, fun[i]),

                                        local_Notebook(context)
                                        //context)
                                      }, //  style: ButtonStyle(
                                      //backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      //   ),
                                      child: const Text(
                                        'Send to Notebook',
                                        // style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    //  MyMessage(),
                                  ]
                              ),
                        )
                        ], // children
                      ), //TabBarView
                    ) //Center
                )
            );
          }


          else {

            return Center(
                child: Container(
                    decoration: BoxDecoration
                      (
                      color: Colors.black,
                      border: Border.all(),),
                    height:MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/pics/movetopics.jpg',
                        fit: BoxFit.contain)
                )
            );
          }
        }
    );

  }
}


//final assetsAudioPlayer = AssetsAudioPlayer();
//is having tis extra statelesswidget class unecessary?
class Sentences extends StatelessWidget {
  Sentences({
    Key? key, required this.sentencestart,
  }) : super(key: key);

  late Map sentencestart;

  @override
  Widget build(BuildContext context) {
    // return Consumer<ThemeProvider>(
    //     builder: (context, ThemeProvider themeprovider, child)
    //    {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().currentTheme,
      //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      // context.read<SwitchThemeCubit>().state,
      home: Exercises(fender: sentencestart),
    );
    //     }
    //  );
  }
}


class Exercises extends StatefulWidget {

  Exercises({
    Key? key, required this.fender,
  }) : super(key: key);

  late Map fender;

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  int _counter = 0;
  bool justonce = false;
  bool _active = false;
  //I will need to write sender to database
  Map sender = {};

  //once I get exp levels and assign exp points to all lessons
  //a switch statement should determine which pool is picked
  //then it should extra.rightpool
 List poolList = extra.phew.keys.toList();
  //late List backupPool;
  late TextEditingController _controller;
  late FocusNode myFocusNode;
  late List setTrip;
  late final AudioPlayer justaplayer;
  //late Future<bool> anonMine;
 // late bool anonMine;
  @override
  void initState() {
    super.initState();
    justaplayer = AudioPlayer();
    _controller = TextEditingController();
    myFocusNode = FocusNode();
    _counter = 0;
    final sender = widget.fender;
    //final anonMine = _loadData();
    if (sender.isNotEmpty) {
      setTrip = pool_cull(fast_sent_sort_for_callback());
    }
    //this is short for testing
    else if (sender.isEmpty) {setTrip = poolList.sublist(0,6);}
    //print(anonMine);
    //backupPool = [...poolList].shuffle();
    //extra.phew.keys.toList().sublist(0,6);}
    // linklink = islandreffy();
    //init should make sure it only runs once

  }

  Reference ref = FirebaseStorage.instance.ref("sounds");

//List quiccint = [16, 17, 18, 19, 20];
  void envelope(String question, String answer, List lemmas, String name ) {
    //i set the lemmas to answer so length should match
    //  String? name = stdin.readLineSync();
    answer = answer.trim().toLowerCase();
    name = name.trim().toLowerCase();
    if (name != null && name.isEmpty) {
      for (var z in lemmas) {
        sender.update(
          z,
              (value) => ++value,
          ifAbsent: () => 1,
        );
      }
    }
    //else if (name != null && name != lamp[k]) {
    // var user = name.split(" ");
    // var answer = lamp[k].split(" ");
    if (answer.length == 1) {
      if (name != answer) {
        sender.update(
          lemmas[0],
          //answer.toString().replaceAll(new RegExp(r"\p{P}", unicode: true), ""),
              (value) => ++value,
          ifAbsent: () => 1,
        );
      }
      else if (name == answer) {
        if (sender.containsKey(answer)) {
          sender.update(
            lemmas[0],
                (value) => --value,
            ifAbsent: () => 0,
          );
        }
      }
    }
    else if (name != null && answer.length > 1) {
      //answer means the correct answer
      //user answer is name
      final findlemma = answer.split(" ");
      final checkanswer = name.split(" ");
      Map<int, String> lap = findlemma.asMap();
      final useasIndex = lap.keys.toList();
      //what does this for loop do exactl?
      for (int i = 0; i < findlemma.length; i++) {
        //watch for if it will work on the last word
        try { if (checkanswer[i] !=  findlemma[i]) {
          sender.update(
            lemmas[i],
                (value) => ++value,
            ifAbsent: () => 1,
          );
        }
        if (checkanswer[i] == findlemma[i]) {
          //print(findlemma[i]);
          sender.update(
            lemmas[i],
                (value) => --value,
            ifAbsent: () => 0,
          );

        }

        }
        catch (e) { if (lemmas.length == findlemma.length) {
          sender.update(
            lemmas[i],
                (value) => ++value,
            ifAbsent: () => 1,
          );
        }

        }
      }
      //return sender;
    }
  }

  List pool_cull(Map sorted) {
    poolList.shuffle();
    List lilSetTrip = [];
    if (sorted.isNotEmpty) {
      context.read<Referencer>().novarlemmaSet(sorted);
      for (var x in sorted.keys.toList()) {
        if (sorted[x] < 0) {
          continue;
        }
        else {
          for (var j in poolList) {
            //this will eventually lead to a bottleneck
            //but dont worry about it now
            for (var z in extra.phew[j]['code']) {
              //if with the pool it makes it too likely
              //to pull the same sentence over and over
              //implement last= if then continue
              if (x == z) {
                lilSetTrip.add(j);
              }
            }
          }
        }
      }
    }
    else {
      lilSetTrip = poolList.sublist(0,10);
    }
    return lilSetTrip;
  }
  Map fast_sent_sort_for_callback() {
    if (sender.isNotEmpty) {
      var sorted = Map.fromEntries(
          sender.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value)));
      return sorted;
    }
    else {return {};}

  }


  //making future a singleobj just to get started

  Future<List> islandreffy(i) async {
    List dothis = [];
    //  final sender = (await ref.child("yulnazunit1-$i.mp3").getDownloadURL())
    //     .toString();
    //  dothis.add(sender);
    return dothis; //dothis;
  }


  void openKeyboard() {
    FocusScope.of(context).requestFocus(myFocusNode);
  }


  void clearText() {
    _controller.clear();
  }


  @override
  void dispose() {
    _controller.dispose();
    myFocusNode.dispose();
    //assetsAudioPlayer.dispose();
    super.dispose();
  }



  void _handleTap() {
    //widget.onChanged(!widget.active);
    clearText();
    myFocusNode.requestFocus();
  }

  void rewind() {
    setState(() {
      setTrip = pool_cull(fast_sent_sort_for_callback());
      _counter = 0;
    });
  }
  void _handleTapboxChanged(bool newValue) {
    envelope(setTrip[_counter], extra.phew[setTrip[_counter]]["translation"],extra.phew[setTrip[_counter]]['code'], _controller.text );
    // envelope(extra.phew[setTrip[_counter]],extra.phew[setTrip[_counter]]["translation"],  extra.phew[setTrip[_counter]]['code'], _controller.text);
    setState(() {
      //submits value
      _active = newValue;
    });
  }

  void _handleRap() {
    clearText();
    //changes page
    setState(() {
      _active = false;
      _counter < setTrip.length-1 ?
      //I hope that the return from rewind
      //is included in the setstate
      //if the sentences returned get stuck thats what it is
      _counter++ : rewind();
    }

    );
    justonce = false;
    myFocusNode.requestFocus();
  }



  Future<void> onLaunch(i) async {
   // await Future(() {}); // <-- Dummy await
  final edAnonMine = Provider.of<Referencer>(context, listen: false).anonTag;
   print(edAnonMine);
   if (edAnonMine == false) {
      final mender = (await ref.child("$i.mp3").getDownloadURL()).toString();
      await justaplayer.dynamicSet(url: mender);
      justaplayer.play();
    }
  }

  //late Future linklink;



  @override
  Widget build(BuildContext context) {
    if (justonce == false) {
      onLaunch(extra.phew[setTrip[_counter]]["location"]);
      justonce = true;
    }
    //openKeyboard();
    try {
      return
        GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
             // drawer: NavDrawer(),
              appBar: AppBar(
              //  centerTitle: true,
              //  title: const Text('Kangarule'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyHomePage())
                          ),
                        );
                      },
                      icon: Text(
                          '🏠', // Home emoji
                          style: TextStyle(
                            fontSize: 24, // Adjust size to look like an icon
                            color: Colors.white, // Adjust color
                          )
                      )
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                        ),
                      );
                    },
                    icon: const Icon(Icons.auto_stories),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                      )
                      );
                    },
                    icon: const Icon(Icons.local_laundry_service),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MySettings())
                        ),
                      );
                    },
                    icon: const Icon(Icons.miscellaneous_services),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ThemeProvider>().switchTheme();
                    },
                    icon: Icon(Icons.sunny_snowing),
                    //I want to make an icon animation  on click
                    //so when going to different mode
                    //switches to sunny for light
                  ),
                ],
              ),
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              decoration: BoxDecoration
                                (
                                color: Colors.black,
                                border: Border.all(),),
                              height: 100,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GestureDetector(
                                onDoubleTap: _handleRap,
                                child: Image.asset('assets/pics/movetopics.jpg',
                                    fit: BoxFit.contain),

                              ),
                            )
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [Row(
                                  children: <Widget>[FloatingActionButton(
                                    onPressed: () {

                                         onLaunch(extra.phew[setTrip[_counter]]["location"]);

                                    },
                                    child: const Icon(Icons.arrow_forward_sharp),
                                  ),
                                    Expanded(
                                        child: Text(
                                          setTrip[_counter],
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium,
                                          softWrap: true,
                                          maxLines: 3,
                                        )
                                    ),
                                  ]
                              ),

                                Visibility(
                                    visible: _active,
                                    child: Text(extra.phew[setTrip[_counter]]["translation"])
                                  //'${eng[_counter]}')
                                ),
                                Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                            keyboardType: TextInputType.name,
                                            autofocus: true,
                                            focusNode: myFocusNode,

                                            controller: _controller,
                                            onSubmitted: (String value) {
                                              if (value.isNotEmpty &&
                                                  value != null) {
                                                _handleTapboxChanged(true);
                                              }
                                            },
//tis
                                            //needs a safe area
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Colors.red),
                                              hintText: "Enter your answer",
                                              filled: true,
                                              fillColor: Colors.blueAccent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(50),

                                              ),
                                            )
                                        )
                                    )
                                )


                              ],
                            )
                        ),

                      ]
                  )
              ), //gesturedetector
            )
        );
    }

    catch(e) {
      print(e);
      return Center(
          child: Container(
              decoration: BoxDecoration
                (
                color: Colors.black,
                border: Border.all(),
              ),
              height:MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/pics/movetopics.png',
                  fit: BoxFit.contain)
          )
      );
    }
  }

}
class BannerAdPage extends StatefulWidget {
  // Main content widget to display above the ad

  const BannerAdPage({
    Key? key
  }) : super(key: key);

  @override
  _BannerAdPageState createState() => _BannerAdPageState();
}

class _BannerAdPageState extends State<BannerAdPage> {
  // --- Future to track banner ad loading ---
  // This Future will be initialized in initState and watched by the FutureBuilder.
  late Future<BannerAd?> _bannerAdFuture;

  // Define the height of the banner ad area.
  // Using a fixed height based on the AdSize.banner size (50 logical pixels)
  // helps prevent layout shifts while the ad loads.
  static const double _bannerAdHeight = 50.0; // Standard AdSize.banner height


  @override
  void initState() {
    super.initState();
    debugPrint('_BannerAdPageState: initState called.');

    // --- Initialize the ad loading Future ---
    // Call the ad loading method and store the returned Future.
    _bannerAdFuture = _loadBannerAd();
  }

  // --- Method to load the banner ad and return a Future ---
  Future<BannerAd?> _loadBannerAd() async {
    debugPrint('_BannerAdPageState: _loadBannerAd called.');

    // Use a Completer to create a Future that will complete
    // when the ad loads successfully or fails.
    final Completer<BannerAd?> completer = Completer<BannerAd?>();

    // Get the appropriate ad unit ID based on the platform
    String adUnitId;

      adUnitId = 'ca-app-pub-3940256099942544/2435281174';



    // Create and load the BannerAd
    final bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(), // Standard ad request
      size: AdSize.banner, // Choose an appropriate size
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('_BannerAdPageState: Ad loaded.');
          // Complete the Future with the loaded ad when successful.
          completer.complete(ad as BannerAd); // Cast is safe here
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('_BannerAdPageState: Ad failed to load: $error');
          ad.dispose(); // Dispose the ad instance on failure
          // Complete the Future with null on failure.
          completer.complete(null);
          // Or completer.completeError(error); if you want FutureBuilder to show error state.
        },
        onAdOpened: (ad) => debugPrint('_BannerAdPageState: Ad opened.'),
        onAdClosed: (ad) => debugPrint('_BannerAdPageState: Ad closed.'),
        // onAdImpression: (ad) => debugPrint('_BannerAdPageState: Ad impression.'), // Optional
        // onAdClicked: (ad) => debugPrint('_BannerAdPageState: Ad clicked.'), // Optional
      ),
    );

    // Start loading the ad
    bannerAd.load();

    // Return the Future immediately. The FutureBuilder will watch this.
    return completer.future;
  }

  @override
  void dispose() {
    debugPrint('_BannerAdPageState: dispose called.');
    // Dispose of the ad instance when the widget is removed.
    // We need to access the ad instance from the completed Future's data.
    // This requires checking the Future's state or storing the ad instance
    // after the Future completes. A simpler way is to store it locally
    // or rely on the Completer's behavior if the ad is only disposed
    // on widget dispose. Let's store it locally after completion for disposal.

    // It's safer to dispose the ad instance directly here if it was stored.
    // However, since the FutureBuilder manages the AdWidget and the ad
    // instance is passed to it, and the ad instance is created and managed
    // within the _loadBannerAd method, disposing it here can be tricky
    // without storing it in a state variable.
    // A common pattern is to store the loaded ad in a state variable
    // and dispose that variable here. Let's adjust _loadBannerAd slightly
    // to return the loaded ad and store it in a state variable for disposal.

    // Re-implementing _loadBannerAd to store the ad instance for disposal:
    // (Or, simplify and just dispose the ad returned by the Future if it's available)

    // Let's stick to the FutureBuilder pattern and dispose the ad in dispose
    // if the Future has completed with data.
    _bannerAdFuture.then((ad) {
      if (ad != null) {
        debugPrint('_BannerAdPageState: Disposing loaded ad in dispose().');
        ad.dispose();
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_BannerAdPageState: build called.');

    return FutureBuilder<BannerAd?>(
              future: _bannerAdFuture, // Watch the ad loading Future initialized in initState
              builder: (context, snapshot) {
                // --- Build UI based on the ad loading snapshot's state ---
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the ad is loading, show a small loading indicator or empty space.
                  return const SizedBox.shrink(); // Show nothing while waiting
                  // return const CircularProgressIndicator(); // Or a loading indicator
                } else if (snapshot.hasError) {
                  // If the ad failed to load with an error.
                  debugPrint('FutureBuilder (Ad): Error loading ad: ${snapshot.error}');
                  return const SizedBox.shrink(); // Show nothing on error
                  // return const Icon(Icons.error); // Or an error icon
                } else if (snapshot.hasData && snapshot.data != null) {
                  // If the Future completed successfully and has ad data, display the AdWidget.
                  final BannerAd loadedAd = snapshot.data!;
                  // Use SizedBox to ensure the AdWidget fits within the reserved height.
                  return SizedBox(
                    width: loadedAd.size.width.toDouble(),
                    height: loadedAd.size.height.toDouble(),
                    child: AdWidget(ad: loadedAd), // Display the loaded ad
                  );
                } else {
                  // If the Future completed but no ad was loaded (e.g., onAdFailedToLoad completed with null).
                  return const SizedBox.shrink(); // Show nothing if no ad data
                }
              },
    );
  }
}


//Map wholenote = _dump["language"][saveuserLang]["users"][saveUser]["Notebook"];
class MyNotebook extends StatelessWidget {
  const MyNotebook({super.key});


  @override
  Widget build(BuildContext context) {
    //return Consumer<ThemeProvider>(
    //   builder: (context, ThemeProvider themeprovider, child)
    //   {
    return MaterialApp(
      title: "Notebook",
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [routeObserver],
      // routes: {
      //   'pageone': (context) => RouteAware('pageone', child: MyHomePage()),
      //   'pagetwo': (context) =>  RouteAware('pagetwo', child: Sentences()),
      //   'pagethree': (context) => RouteAware('pagethree', child: MyStatus()),

      //   },
      theme: context.watch<ThemeProvider>().currentTheme,
      //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      //context.read<SwitchThemeCubit>().state,
      home: MyNotebookState(),
    );
  }
//  }
}

class MyNotebookState extends StatefulWidget {
  const MyNotebookState({super.key});

  @override
  State<MyNotebookState> createState() => _MyNotebookState();
}

class _MyNotebookState extends State<MyNotebookState> {
  bool _customTileExpanded = false;
  Map exposee = {};
  List quiccfix = [];
  Map _dump = {};
  //Map wholenote = {};
  bool _isAdLoaded = false;
  // We might not even need to store the ad instance locally if Referencer holds it,
  // but keeping it local allows setState to rebuild just this part.
  BannerAd? _localBannerAd;



  void getDat(Map wholenote) {
    quiccfix.clear(); // Empties the list []
    exposee.clear();  // Empties the map {}
    for (var i in wholenote.keys) {
      //this makes the num 0 and the title 1
      if (wholenote[i]["saved"].isEmpty) {
        continue;
      }
      quiccfix.add(i);
      //output: [1, "intro"]
      exposee[i] = wholenote[i]["saved"];
      //output: {"intro": [[ck, note]]}
    }
  }

  @override
  void initState() {
    super.initState();
   // _initData();

  }
  Future<void> _initData() async {
    //BIG QUESTION DO i NEED A DOUBLE CHECK ANYMORE?
    // 1. Load the data
    final anonMine = Provider.of<Referencer>(context, listen: false).anonTag;
    if (anonMine == false) {
    NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};
    }
  
  }
  // List bender = sender.keys.toList();
  // List lender = sender.values.toList();
  //List<ExpansionTile> fiddle =
  //  List<Widget>.generate(bender.length, (i) => ExpansionTile)
//static List<String> fender =
  //   List.generate(lender.length, (index) => "${lender[index].toString()}");


  @override
  Widget build(BuildContext context) {
    getDat(NB);
    final referencer = Provider.of<Referencer>(context);
    //getDat(context.read<Referencer>().getallNotes());
    //wholenote = _dump["Notebook"];
    return Scaffold(
        //drawer: NavDrawer(),
        appBar: AppBar(
         // centerTitle: true,
       //   title: const Text('Kangarule'),


          actions: [
            IconButton(
            onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyHomePage())
      ),
    );
    },
        icon: Text(
            '🏠', // Home emoji
            style: TextStyle(
              fontSize: 24, // Adjust size to look like an icon
              color: Colors.white, // Adjust color
            )
        )
    ),
    IconButton(
    onPressed: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
    ),
    );
    },
    icon: const Icon(Icons.auto_stories),
    ),
    IconButton(
    onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
    )
    );
    },
    icon: const Icon(Icons.local_laundry_service),
    ),
    IconButton(
    onPressed: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MySettings())
    ),
    );
    },
    icon: const Icon(Icons.miscellaneous_services),
    ),
    IconButton(
    onPressed: () {
    context.read<ThemeProvider>().switchTheme();
    },
    icon: Icon(Icons.sunny_snowing),
    //I want to make an icon animation  on click
    //so when going to different mode
    //switches to sunny for light
    ),
    ],
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [...List<Widget>.generate(
                    quiccfix.length,
                    //exposee.length,
                        (i) =>
                        ExpansionTile(
                            title: Text(quiccfix[i]),
                            children: [Column(
                                children: [ ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: exposee[quiccfix[i]].length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return
                                        Dismissible(
                                            key: Key(exposee[quiccfix[i]][index][1]),
                                            onDismissed: (direction) {
                                              // Remove the item from the data source.
                                              context.read<Referencer>().clean_Notebook(quiccfix[i], index);

                                            },
                                            //background: Container(color: Colors.red),
                                            // allStati[x]["date"]
                                            //have you made the datemake function yet
                                            //and sorted all statuses based on date?
                                            //and added newest status to top of post?
                                            child:
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: _SingleNote(
                                                  //int.parse
                                                  colorKeeper: exposee[quiccfix[i]][index][0],
                                                  saying: exposee[quiccfix[i]][index][1],
                                                  counter: [index, quiccfix[i]],
                                                )


                                            )
                                        );
                                    }

                                  //text: '${sender[bender[i]]} ',

                                ),



                                ]
                            )
                            ]
                        )
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                          child: BannerAdPage()

                  ),
                ]
            )
        ),



    );

  }
}


class _SingleNote extends StatefulWidget {
  late String saying;
  late int colorKeeper;
  late List counter;


  _SingleNote({Key? key, required this.colorKeeper, required this.saying, required this.counter}) : super(key: key);


  @override
  EveryNoteState createState() => EveryNoteState();
}

class EveryNoteState extends State<_SingleNote> {
  // static List texttileTheme = [Colors.black, Colors.blue, Colors.red, Colors.green, Colors.purple, Colors.yellow, Colors.pink, Colors.white];
  // static List boxTheme = [Colors.white, Colors.orange, Colors.green, Colors.red, Colors.yellow, Colors.purple, Colors.green, Colors.black ];
  late String _saying;
  late int _colorKeeper;
  late int counter;
  late String title;
  @override
  void initState() {
    super.initState();
    _saying = widget.saying;
    _colorKeeper = widget.colorKeeper;
    counter = widget.counter[0];
    title = widget.counter[1];
  }
  void SwitchThisTheme() {if (_colorKeeper != 6) {
    setState(() {
      _colorKeeper++;
    }
    );
    context.read<Referencer>().changeColor(_colorKeeper, counter, title);
    //wholenote[counter[1]]["saved"][counter[0]][0] = _colorKeeper.toString();
    //write to db
  }
  else if (_colorKeeper == 6) {
    setState(() {
      _colorKeeper = 0;
      //write to db
    }
    );
    context.read<Referencer>().changeColor(_colorKeeper, counter, title );
    // wholenote[counter[1]]["saved"][counter[0]][0] = _colorKeeper.toString();
    //wholenote[counter[1]]["saved"][counter[0]][0];
  }
  }
  @override
  Widget build(BuildContext context) {
    //final CommentModel commentData =
    // InheritedPostModel.of(context).postData.comments[index];
//can I change this to a listtile instead of a container?
    return
      //Expanded(
      // flex: 3,
      //width: double.infinity,
      // height: 110,
      // margin: const EdgeInsets.symmetric(vertical: 8.0),
      // child:
      Row(children: [FloatingActionButton.small(
        onPressed: () {SwitchThisTheme();},
        //child: Icon(Icons.add,),
        //foregroundColor: texttileTheme[colorKeeper+1],
        backgroundColor: texttileTheme[_colorKeeper+1],
        //mini: true,

      ),

        Expanded(child: ColoredBox(color: boxTheme[_colorKeeper],
            child: RichText(textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                    _saying,
                    style: TextStyle(color: texttileTheme[_colorKeeper], fontSize: 18)
                )
            )
        )
        ),
      ]

        //  commentData.comment,
        // key: ValueKey("${CommentsListKeyPrefix.commentText} $index"),
        // textAlign: TextAlign.left,

        //  Divider(
        //   key: ValueKey("${CommentsListKeyPrefix.commentDivider} $index"),
        //   color: Colors.black45,
        //   ),



      );
  }
}



class PostCard extends StatelessWidget {
  late Map status;
  //comments will be dissected from status
  //date and icon will be dissected from status here too
  //sould I do the parsing here and send a map to Postcard?
  //late List useasAssetImage;
  late String postid;
  // late String date;
  PostCard({Key? key, required this.status, required this.postid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      //AspectRatio(
      //aspectRatio: 2.0,
      //6 / 3,
      //  child: Card(
      // elevation: 4,
      // child:
      Container(
        width: double.infinity,
        height: 300,
        //  margin: const EdgeInsets.all(4.0),
        // padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            //_PostDetails(useasAssetImage: ["1", "WD"],date: "30 April 2019"),
            _PostDetails(useasAssetImage: status["info"]["photo"], date: status["info"]["date"]),
            Divider(color: Colors.grey),
            _PostTitleAndSummary(summary: status["post"]),
            //_Post(input: status),
            Divider(color: Colors.grey),
            Expanded(child: Comments(bomments: status["comments"], commentUsers: status["commentUsers"], postid: postid)) ,
          ],
        ),
        //   ),
        //   ),
      );
  }
}



class _PostTitleAndSummary extends StatelessWidget {
  late String summary;
  _PostTitleAndSummary({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? summaryTheme = Theme.of(context).textTheme.headlineSmall;



    return
      // Expanded(
      // flex: 2,
      // child:
      Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Text(title, style: titleTheme),
            //SizedBox(height: 2.0),
            Expanded(child: Text(summary, style: summaryTheme)),
          ],

        ),
      );
  }
}


class _PostDetails extends StatelessWidget {
  late List useasAssetImage;
  late String date;
  //const _PostDetails({Key? key}) : super(key: key);
  _PostDetails({Key? key, required this.useasAssetImage, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _UserImage(picture: useasAssetImage),
        //_UserNameAndEmail(),
        Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: Text(date, style: Theme.of(context).textTheme.labelMedium),
        )
      ],
    );
  }
}
class Comments extends StatefulWidget {
  // late List tagz;
  //del;ete thois
  //don't verlook
  //this is fake
  //delete
  late List bomments;
  late List commentUsers;
  late String postid;
  Comments({Key? key, required this.commentUsers, required this.bomments, required this.postid}) : super(key: key);


  @override
  State<Comments> createState() => _CommentsState();
//useasAssetImage: useasAssetImage);
}

class _CommentsState extends State<Comments> {
  // late String useasAssetImage;
  late String _postid;
  late List userPic;
  // _CommentsState({Key? key, required this.useasAssetImage}) : super(key: key);
  late TextEditingController bontroller;
  late List _commentUsers;
  late List localStati;
  late final ValueNotifier<int> _counter =  ValueNotifier<int>(localStati.length);
  //ValueNotifier<int>(_tagz.length);

  void clearText() {
    String text = bontroller.text;
    setState(() {

      if (localStati[0] == 'empty')
      {localStati[0] = text;
      //this needs to be a variable
      _commentUsers[0] = userPic;
      }
      else {
        localStati.add(text);
        //don't parse colorFinder here add it as a string
        //this needs to be a user based variable
        _commentUsers.add(userPic);
      }

      bontroller.clear();
    }
    );
    context.read<Referencer>().addComment(text, userPic, widget.postid );

    //needs text, userpic, and postid

  }
  @override
  void initState() {
    super.initState();
    bontroller = TextEditingController();
    userPic = context.read<Referencer>().returnPic();
    _postid = widget.postid;
    localStati = [...widget.bomments];
    _commentUsers = [...widget.commentUsers];
  }


  @override
  void dispose() {
    super.dispose();
    bontroller.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _counter,
        builder: (BuildContext context, int _counter, Widget? child)
        {
          return
            ListView(
                children: <Widget>[TextField(
                    keyboardType: TextInputType.name,

                    controller: bontroller,
                    onSubmitted: (String value) {
                      if (value.isNotEmpty && value != null) {
                        clearText();
                      }
                    },


                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.red),
                      hintText: "Comment here",
                      filled: true,
                      fillColor: Colors.blueAccent,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: double.infinity),

                      ),
                    )
                ),
                  ...List<Widget>.generate(
                      1,
                          (i) =>
                          ExpansionTile(
                              title: const Text("See comments"),
                              initiallyExpanded: true,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: localStati.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    //dont parse here
                                    //cause the num will be a string from rtdb
                                    //ill parse in the imagewidget
                                    //[boxTheme[int.parse(_commentUsers[index][0])], _commentUsers[index][1]]
                                    if (localStati[0] == 'empty') {
                                      return const ListTile();
                                    }
                                    else {
                                      return _SingleComment(
                                          saying: localStati[index],
                                          useasAssetImage: [
                                            _commentUsers[index][0],
                                            _commentUsers[index][1]
                                          ]);
                                    }
                                  },

                                )

                              ]
                          )
                  )

                ]
            );
        }
    );


  }
}

class _SingleComment extends StatelessWidget {
  final String saying;
  late List useasAssetImage;


  _SingleComment({Key? key, required this.saying, required this.useasAssetImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return
      ListTile(
        leading: _UserImage(picture: useasAssetImage,
        ),
        title: RichText(textAlign: TextAlign.center,
            text: TextSpan(
                text:
                saying,
                style: const TextStyle(color: Colors.black, fontSize: 18))
          //  commentData.comment,
          // key: ValueKey("${CommentsListKeyPrefix.commentText} $index"),
          // textAlign: TextAlign.left,
        ),
        //  Divider(
        //   key: ValueKey("${CommentsListKeyPrefix.commentDivider} $index"),
        //   color: Colors.black45,
        //   ),



      );
  }
}




class _UserImage extends StatelessWidget {
  late List picture;
  _UserImage({Key? key, required this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      CircleAvatar(
        radius: 18,

        backgroundColor: boxTheme[int.parse(picture[0])],
        //picture as ImageProvider
        child: Text(
            picture[1]
        ),
      );
    //  );

  }
}

class MySettings extends StatefulWidget {

  const MySettings({
    Key? key,
  }) : super(key: key);

  @override
  State<MySettings> createState() => _MySettings();
}

class _MySettings extends State<MySettings> {
  bool isOnlyWelcome = NB.length == 1 && NB.containsKey("Welcome");
  @override
  void initState() {
    super.initState();
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         // title: const Text("Kangarule"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyHomePage())
                    ),
                  );
                },
                icon: Text(
                    '🏠', // Home emoji
                    style: TextStyle(
                      fontSize: 24, // Adjust size to look like an icon
                      color: Colors.white, // Adjust color
                    )
                )
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                  ),
                );
              },
              icon: const Icon(Icons.auto_stories),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                )
                );
              },
              icon: const Icon(Icons.local_laundry_service),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MySettings())
                  ),
                );
              },
              icon: const Icon(Icons.miscellaneous_services),
            ),
            IconButton(
              onPressed: () {
                //setanon
                context.read<ThemeProvider>().switchTheme();
              },
              icon: Icon(Icons.sunny_snowing),
              //I want to make an icon animation  on click
              //so when going to different mode
              //switches to sunny for light
            ),
          ],
        ),

        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
    OutlinedButton(
            child: const Text('Sign Out'),
    onPressed:   ()
            async {


        context.read<Referencer>().set_Notebook();// lemmas?
    //NB
            
              final anonMine = Provider.of<Referencer>(context, listen: false).anonTag;
            //  if (anonMine == false) {
              //  await FirebaseAuth.instance.signOut();
            //  }
            //  else {
                Provider.of<Referencer>(context, listen: false).anonSet(true);
                await FirebaseAuth.instance.signOut();

            //  }
        {Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignIn())
        );
        }
        // context.read<AuthenticationService>().signOut();
        }
          // await _firebaseAuth.signOut();

    // Elevation (shadow)
    ),
                  

                  OutlinedButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      child: const Text('Report a problem.')
                  ),
                  OutlinedButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
    final user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      try {
        // --- Call your Referencer method first if needed ---
        // If deleteMe() needs to run BEFORE Firebase deletion
        context.read<Referencer>().deleteMe(); // Call your method

        // --- Then delete the Firebase user ---
        await user.delete(); // Await the asynchronous deletion

        // Account successfully deleted
        debugPrint('User account deleted.');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignIn())
        );

        // You might navigate the user back to a sign-up/sign-in page here
        // Navigator.of(context).pushReplacementNamed('/signup');

      } on FirebaseAuthException catch (e) {
        // --- Handle Firebase Authentication errors and show alert ---
        debugPrint('Error deleting user: ${e.code}');
        String errorMessage = 'An error occurred while deleting your account. Please try again.';
      };
    }
    },
                    child: const Text('Delete account.'),
                  ),

                ]
            )
        )
    );
  }
}

class Answers extends StatelessWidget {
  final String yourAnswer; //Answer text
  //Function that is call upon when this
  //specific answer object is tapped upon.
  final Function answerQuestion;
  Answers(this.yourAnswer, this.answerQuestion);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        //Answer will be displayed as a button rather than
        //simple text, to allow for interactivity.
        child: ListTile(leading: const Icon(Icons.circle_outlined),
          title: Text(yourAnswer,
            style: const TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20),),
          minVerticalPadding: 12,
          onTap: () => answerQuestion(yourAnswer),
        )
    );

  }
}

class Questions extends StatelessWidget {
  final String handler; //Question text
  Questions(this.handler);  //Class constructor
  @override
  Widget build(BuildContext context) {
    return Text(
      handler,
      style: const TextStyle( //Question text styling
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class QuizPage extends StatelessWidget {
  late String handle;
  QuizPage({super.key, required this.handle});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(handle: handle),
    );
  }
}

class FirstPage extends StatefulWidget {
  late String handle;
  FirstPage({super.key, required this.handle});
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _questionIndex = 0;
  //Declaring variables to store previous answers
  //String prevAns = "", prevCorrectAns = "";

  //Boolean variable to check of this was the user's
  List traits = [];
  //first attempt at the question.
  // bool firstAttempt = true;
  //Boolean variable to check if the user's answer was correct.
  //bool check = true;

  //Defining the function for tapping on a any specific answer.
  void _answerQuestion(String myAns) {
    //Made to false as the user made the first attempt on tapping
    //an answer and calling this function.
    setState(() {
      // The following boolean statement checks if answer was true.
      traits.add(myAns);
      if (_questionIndex == _questions.length - 1) {
        //If the index of the last question is displayed here then it is set back
        //to 0 (the index of the first question), essentially resetting the quiz.
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Start(handle: widget.handle)
          )
          );
        }
      } else {
        _questionIndex = _questionIndex + 1;
      }
    });
  }



  var _questions = [
    //A list of dictionaries which represent the question, possible answers
    //and the correct answer.
    {
      'questionText': 'What language are you learning?',
      'answers': ['russian'],
    },
    {
      'questionText': 'Why do you want to learn a language?',
      'answers': ['to visit', 'to move', 'for someone', 'for fun'],
    },
    {
      'questionText': 'What\'s the best part of speaking a different language?',
      'answers': ['to have conversations', 'to read', 'it\'s a necessity for me'],
    },
    {
      'questionText': 'What is hardest about learning a new language?',
      'answers': ['pronounciation', 'learning new phrases', 'putting sentences together', 'grammar'],

    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          20.0,
        ),
        margin: const EdgeInsets.all(
          10.0,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Questions(
                  //This displays the current question tracked by
                  //the _questionIndex variable.
                  _questions[_questionIndex]['questionText'].toString(),
                ),
                //This displays the current questionanswers set tracked by
                //the _questionIndex variable. The spread operator helps in
                //extracting all answers without the need to write this
                //code 4 times.
                ...(_questions[_questionIndex]['answers'] as List<String>).map((answer) {
                  return Answers(answer, _answerQuestion);
                }).toList(),
                const SizedBox(
                  height: 10.0,
                ),
                //If this was the user's first attempt then any
                //empty container is displayed.


              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Start extends StatelessWidget {
  late String handle;
  late final user;
  Start({super.key, required this.handle});

  void Purpose() async {
    await Future(() {});
    await user?.sendEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    Purpose;
    //oh i get handle from the start page
    //how do I get it over here?
    //still need to make a lsut to fill in pic
    context.read<Referencer>().firstTime(["4", handle.substring(2)], handle);
    return
      MaterialApp(
          theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.black
          ),
          debugShowCheckedModeBanner: false,
          home:
          Scaffold(
            // drawer: NavDrawer(),
            //change this out
            //ScaffoldMessenger.of(context).hideCurrentSnackBar();
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    {Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignIn())
                    );
                    }
                  },
                ),
              ),
              body:
              const Center (
                  child: Text(
                    "Email confirmation has been sent! Check your email, and sign in.",
                    style: TextStyle( //Question text styling
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
              )
          )
      );
  }
}
