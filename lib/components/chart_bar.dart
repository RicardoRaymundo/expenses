import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    this.label,
    this.value,
    this.percentage,
    super.key,
  });

  final String? label;
  final double? value;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, contraints) {
        return Column(
          children: [
            SizedBox(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(value!.toStringAsFixed(2)),
              ),
            ),
            SizedBox(height: contraints.maxHeight * 0.05),
            SizedBox(
              height: contraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: contraints.maxHeight * 0.05),
            SizedBox(
                height: contraints.maxHeight * 0.15,
                child: FittedBox(child: Text(label!))),
          ],
        );
      }),
    );
  }
}
