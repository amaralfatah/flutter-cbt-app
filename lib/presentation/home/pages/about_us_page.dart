import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app/presentation/home/bloc/content/content_bloc.dart';

import '../../../core/components/custom_scaffold.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    context.read<ContentBloc>().add(const ContentEvent.getContentById('1'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: const Text('About US'),
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(child: Text('Error'));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (data) {
              return ListView(
                // padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
                children: [
                  data.data.isEmpty
                      ? const SizedBox()
                      : CachedNetworkImage(
                          imageUrl: data.data[0].image,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      data.data.isEmpty ? 'no content' : data.data[0].content,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
