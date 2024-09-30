import '../../bloc/hug_cubit/hug_cubit.dart';
import '../../bloc/hug_cubit/hug_state.dart';
import '../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HugView extends StatelessWidget {
  const HugView({Key? key}) : super(key: key);
  static const routeName = "/Hug";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " مناسك الحج و العمرة",
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<HugCubit>()..getHug(),
        child: BlocBuilder<HugCubit, HugState>(
          builder: (context, state) {
            if (state is HugLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HugError) {
              return Center(child: Text(state.message));
            } else if (state is HugScasses) {
              return ListView.builder(
                  itemCount: state.hugModel.hugData.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 15,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: BoxShape.circle),
                              ),
                              Flexible(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 30.0,
                                        right: 10.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${state.hugModel.hugData[index].name}\n",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ...state
                                                  .hugModel.hugData[index].info!
                                                  .map((e) => Text(
                                                        "$e\n",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ))
                                            ],
                                          )
                                        ],
                                      )))
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.secondary,
                            endIndent:
                                MediaQuery.of(context).size.height * 0.08,
                            indent: MediaQuery.of(context).size.height * 0.08,
                          ),
                          // const SizedBox(height: 16),
                        ],
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
