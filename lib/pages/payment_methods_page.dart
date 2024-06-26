import 'package:finalproject/components/credit_card_form.dart';
import 'package:finalproject/view_models/credit_card_cubit/credit_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CreditCardCubit();
        cubit.getCreditCardList();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Credit Cards'),
        ),
        body: BlocConsumer<CreditCardCubit, CreditCardState>(
          listener: (context, state) {
            if (state is CreditCardAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Credit card added successfully'),
                ),
              );
            }
            if (state is CreditCardSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Credit card removed successfully'),
                ),
              );
            }
            if (state is CreditCardFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error loading credit cards'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CreditCardsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CreditCardsLoaded) {
              if (state.creditCards.isEmpty) {
                return const Center(child: Text('No credit cards found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.creditCards.length,
                itemBuilder: (context, index) {
                  final card = state.creditCards[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.credit_card,
                          color: Colors.blueAccent),
                      title: Text(
                        '**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Expires ${card.expiryDate}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          // Add logic to remove the card
                          BlocProvider.of<CreditCardCubit>(context)
                              .removeCreditCard(card.cardNumber);
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is CreditCardsFailure) {
              return const Center(child: Text('Error loading credit cards'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: BlocProvider.value(
                  value: BlocProvider.of<CreditCardCubit>(context),
                  child: const CreditCardForm(),
                ),
              ),
            );
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
