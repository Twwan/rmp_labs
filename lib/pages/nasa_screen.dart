import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmp_lab/cubit/nasa_cubit.dart';
import 'package:rmp_lab/cubit/nasa_state.dart';

class NasaScreen extends StatelessWidget {
  const NasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NasaCubit()..loadData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Неборский Мирон Евгеньевич'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocBuilder<NasaCubit, NasaState>(
          builder: (context, state) {
            if (state is NasaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NasaLoadedState) {
              return ListView.builder(
                itemCount: state.data.photos!.length,
                itemBuilder: (context, index) {
                  final photo = state.data.photos![index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          photo.imgSrc!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ровер: ${photo.rover!.name!}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Камера: ${photo.camera!.name!}'),
                              const SizedBox(height: 4),
                              Text('Дата: ${photo.earthDate!}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is NasaErrorState) {
              return const Center(
                child: Text('Произошла ошибка. Попробуйте позже.'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
