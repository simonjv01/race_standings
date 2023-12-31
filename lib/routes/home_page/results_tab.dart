import 'dart:math';


import 'package:flutter/material.dart';
import 'package:race_standings/localization/localization.dart';

import '../../models/data_source.dart';
import '../../models/results_entry.dart';

/// This page shows the races results in various countries around the world.
class ResultsTab extends StatelessWidget {
  /// Creates a [ResultsTab] widget.
  const ResultsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimensions) {
        // Small devices
        if (dimensions.maxWidth <= mobileResultsBreakpoint) {
          return ListView.builder(
            itemCount: resultsList.length,
            itemBuilder: (context, index) => _CompactResultCard(
              results: resultsList[index],
            ),
          );
        }

        // Larger devices
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: ListView.builder(
            itemCount: resultsList.length,
            itemBuilder: (context, index) => _ExpandedResultCard(
              results: resultsList[index],
            ),
          ),
        );
      },
    );
  }
}

/// Shows race results in a compact way, without much details.
class _CompactResultCard extends StatelessWidget with RandomDateGenerator {
  /// The data.
  final List<ResultsEntry> results;

  /// Creates a [_CompactResultCard] widget.
  const _CompactResultCard({
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return CollapsibleState(
      state: ValueNotifier<bool>(false),
      child: LayoutBuilder(
        builder: (context, dimensions) {
          final width =
          min<double>(mobileResultsBreakpoint, dimensions.maxWidth);

          return SizedBox(
            width: width,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              child: Collapsible(
                edgeInsets: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                header: ListTile(
                  title: Text(results.first.circuitName),
                  subtitle: Text(randomDate),
                ),
                content: DriversList(
                  results: results,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Shows race results in a detailed way.
class _ExpandedResultCard extends StatelessWidget with RandomDateGenerator {
  /// The data.
  final List<ResultsEntry> results;

  /// Creates a [_ExpandedResultCard] widget.
  const _ExpandedResultCard({
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimensions) {
        var cardWidth = max<double>(
          mobileResultsBreakpoint,
          dimensions.maxWidth,
        );

        if (cardWidth >= maxStretchResultCards - 50) {
          cardWidth = maxStretchResultCards;
        }

        final leftFlex = cardWidth < maxStretchResultCards ? 2 : 3;

        return Center(
          child: SizedBox(
            width: cardWidth - 50,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    // Race details
                    Expanded(
                      flex: leftFlex,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(results.first.circuitName),
                          Text(
                            context.l10n.circuit_name,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '${results.first.name} ${results.first.surname}',
                          ),
                          Text(
                            context.l10n.winner,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Drivers
                    Expanded(
                      flex: 3,
                      child: DriversList(
                        results: results,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}