import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_card.dart';

// REST API DEMO: fetches a random quote from https://dummyjson.com/quotes/random
//
// Concepts shown:
//   Future / async / await  -> fetchQuote()
//   http.get()              -> sends a GET request
//   jsonDecode()            -> converts JSON text into a Dart Map
//   FutureBuilder           -> builds UI for loading / error / success
//
// If the internet or API fails, only THIS card shows an error.
// The rest of the portfolio keeps working.
class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  late Future<Map<String, String>> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = fetchQuote(); // start the request once
  }

  Future<Map<String, String>> fetchQuote() async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/quotes/random'))
        .timeout(const Duration(seconds: 8));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return {
        'quote': data['quote'].toString(),
        'author': data['author'].toString(),
      };
    }
    // Any non-200 status is treated as an error.
    throw Exception('Server returned ${response.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, color: scheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Quote of the moment (REST API)',
                    style: textTheme.titleMedium),
              ),
              IconButton(
                tooltip: 'New quote',
                icon: const Icon(Icons.refresh),
                // setState re-runs the request and rebuilds the card.
                onPressed: () => setState(() => _quoteFuture = fetchQuote()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FutureBuilder<Map<String, String>>(
            future: _quoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(
                  'Could not load a quote right now. '
                  'Check your internet and tap refresh.',
                  style: textTheme.bodyMedium?.copyWith(color: scheme.error),
                );
              }
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('"${data['quote']}"',
                      style: textTheme.bodyLarge
                          ?.copyWith(fontStyle: FontStyle.italic)),
                  const SizedBox(height: 6),
                  Text('— ${data['author']}',
                      style: textTheme.labelLarge
                          ?.copyWith(color: scheme.primary)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
