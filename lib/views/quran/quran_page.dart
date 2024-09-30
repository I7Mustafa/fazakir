import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../bloc/quran_cubit/quran_cubit.dart';
import '../../bloc/quran_cubit/quran_state.dart';
import '../../bloc/save_quran_page_cubit/save_quran_page_cubit.dart';
import '../../core/them_helper.dart';

class QuranPageScrean extends StatefulWidget {
  const QuranPageScrean({Key? key, this.index = 0}) : super(key: key);
  final int? index;
  static const routeName = '/quranPage';
  @override
  State<QuranPageScrean> createState() => _QuranPageScreanState();
}

class _QuranPageScreanState extends State<QuranPageScrean> {
  late int creindex;
  bool showAppBar = false;
  bool fullscrean = false;
  late double num;
  int? indexpa;

  String getVerseEndSymbol(int verseNumber) {
    String arabicNumeric = " ";

    for (int i = verseNumber.toString().length - 1; i >= 0; i--) {
      String digit = verseNumber.toString().split("")[i];
      if (digit == "0") {
        arabicNumeric += "٠";
      } else if (digit == "1") {
        arabicNumeric += "۱";
      } else if (digit == "2") {
        arabicNumeric += "۲";
      } else if (digit == "3") {
        arabicNumeric += "۳";
      } else if (digit == "4") {
        arabicNumeric += "٤";
      } else if (digit == "5") {
        arabicNumeric += "٥";
      } else if (digit == "6") {
        arabicNumeric += "٦";
      } else if (digit == "7") {
        arabicNumeric += "۷";
      } else if (digit == "8") {
        arabicNumeric += "۸";
      } else if (digit == "9") {
        arabicNumeric += "۹";
      }
    }

    return arabicNumeric.split("").reversed.join();
  }

  late PageController pageController;
  @override
  void initState() {
    creindex = widget.index!;
    num = creindex.toDouble();
    WakelockPlus.enable();
    BlocProvider.of<QuranCubit>(context).getpage();
    pageController = PageController(
      initialPage: creindex,
      keepPage: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  Widget savePage(
      {required String title,
      required Function()? ontap,
      required IconData icon}) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Icon(icon),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranPageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuranPageError) {
            return Center(child: Text(state.message));
          } else if (state is QuranPageScasses) {
            return SafeArea(
              child: InkWell(
                onTap: () {
                  setState(() {
                    showAppBar = !showAppBar;
                  });
                },
                child: Stack(
                  children: [
                    PageView.builder(
                        onPageChanged: (value) {
                          BlocProvider.of<SaveQuranPageCubit>(context)
                              .saveQuranPage(
                                  key: "quranPageNumber", value: value);
                          BlocProvider.of<SaveQuranPageCubit>(context)
                              .saveQuranPage(
                                  key: "nameSoura",
                                  value: state.quranPageModel.page[value].name);

                          BlocProvider.of<SaveQuranPageCubit>(context)
                              .getQuranPage();
                          setState(() {
                            num = value.toDouble();
                          });
                        },
                        controller: pageController,
                        itemCount: state.quranPageModel.page.length,
                        itemBuilder: (context, index) {
                          indexpa = index;
                          return Stack(
                            children: [
                              Container(
                                padding: fullscrean
                                    ? const EdgeInsets.symmetric(vertical: 5.0)
                                    : const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                margin: index % 2 == 0
                                    ? const EdgeInsets.only(
                                        right: 3,
                                      )
                                    : const EdgeInsets.only(
                                        left: 3,
                                      ),
                                decoration: BoxDecoration(
                                    color: !ThemeHandler().isDark(context)
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor
                                        : const Color(0xFFF5F5F5),
                                    borderRadius: index % 2 != 0
                                        ? const BorderRadius.only(
                                            topRight:
                                                Radius.elliptical(100, 20),
                                            bottomRight:
                                                Radius.elliptical(100, 20))
                                        : const BorderRadius.only(
                                            topLeft: Radius.elliptical(100, 20),
                                            bottomLeft:
                                                Radius.elliptical(100, 20),
                                          ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        blurRadius: 2,
                                        offset: index % 2 == 0
                                            ? const Offset(-1, 0)
                                            : const Offset(1, 0),
                                      ),
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        blurRadius: 1,
                                        offset: index % 2 == 0
                                            ? const Offset(0, 1)
                                            : const Offset(-0, 1),
                                      ),
                                    ]),
                                child: fullscrean
                                    ? Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            invertColors:
                                                !ThemeHandler().isDark(context),
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              "assets/images/quran-images/page${index + 1}.png",
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    state.quranPageModel
                                                        .page[index].name
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: "Arabic"),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    state.quranPageModel
                                                        .page[index].jza
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: "Arabic"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  invertColors: !ThemeHandler()
                                                      .isDark(context),
                                                  image: AssetImage(
                                                    "assets/images/quran-images/page${index + 1}.png",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            child: Center(
                                              child: FittedBox(
                                                child: Text(
                                                    getVerseEndSymbol(index + 1)
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: FittedBox(
                                                  child: Text(
                                                      "الحزب " +
                                                          getVerseEndSymbol(
                                                              int.parse(state
                                                                  .quranPageModel
                                                                  .page[index]
                                                                  .haz
                                                                  .toString())),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              ThemeHandler().isDark(context)
                                  ? Container(
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.15),
                                            const Color(0xFFFFF9B6)
                                                .withOpacity(0.0),
                                            const Color(0xFFFFF9B6)
                                                .withOpacity(0.0),
                                            const Color(0xFFFFF9B6)
                                                .withOpacity(0.0),
                                            Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.15),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              if (index ==
                                  BlocProvider.of<QuranCubit>(context)
                                      .markPageNo)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    height: size.height * 0.25,
                                    width: size.width * 0.05,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 107, 26, 20)
                                            .withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                Radius.elliptical(20, 50),
                                            bottomRight:
                                                Radius.elliptical(20, 50))),
                                  ),
                                )
                            ],
                          );
                        }),
                    showAppBar
                        ? Column(
                            children: [
                              Container(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.7),
                                height: size.height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.arrow_back)),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            fullscrean = !fullscrean;
                                          });
                                        },
                                        icon: const Icon(Icons.fullscreen))
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.7),
                                height: size.height * 0.25,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.04,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: savePage(
                                                ontap: () {
                                                  BlocProvider.of<QuranCubit>(
                                                          context)
                                                      .addMarkPage(
                                                          value: indexpa)
                                                      .then((value) =>
                                                          BlocProvider.of<
                                                                      QuranCubit>(
                                                                  context)
                                                              .getpage());
                                                },
                                                title: "اضف علامة",
                                                icon: Icons.book_outlined),
                                          ),
                                          VerticalDivider(
                                            thickness: 1.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.7),
                                          ),
                                          Expanded(
                                            child: savePage(
                                                ontap: () {
                                                  pageController.jumpToPage(
                                                      BlocProvider.of<
                                                                  QuranCubit>(
                                                              context)
                                                          .markPageNo);
                                                },
                                                title: "انتقال الي العلامة",
                                                icon: Icons.bookmark_outlined),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.7),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "الصفحة : ${getVerseEndSymbol(num.toInt() + 1)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              "سورة : ${state.quranPageModel.page[num.toInt()].name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Slider(
                                        value: num,
                                        max: 603,
                                        min: 0,
                                        divisions: 604,
                                        onChangeEnd: (value) {
                                          pageController.jumpToPage(creindex);
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            num = value;
                                            creindex = value.toInt();
                                          });
                                        }),
                                  ],
                                ),
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// base64ToImageFormatter(page) {
//   final data = page
//       .toString()
//       .substring(1, page.toString().length - 1)
//       .replaceFirst("'", "");

//   return data;
// }
