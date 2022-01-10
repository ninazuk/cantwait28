import 'package:cantwait28/features/add/page/add_page.dart';
import 'package:cantwait28/features/auth/pages/user_profile.dart';
import 'package:cantwait28/features/details/cubit/details_cubit.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Can\'t Wait 🤩'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: const _DetailsPageBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DetailsPageBody extends StatelessWidget {
  const _DetailsPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(),
      child: BlocListener<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state.removingErrorOccured) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unable to remove the item'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.loadingErrorOccured) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Couldn\'t load data :('),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final itemModel = state.itemModel;
            if (itemModel == null) {
              return const SizedBox.shrink();
            }
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              children: [
                _ListViewItem(
                  itemModel: itemModel,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.black12,
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(
                  itemModel.imageURL,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        itemModel.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(itemModel.releaseDateFormatted),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      '${itemModel.daysLeft}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('days left'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
