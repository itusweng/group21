import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Given user in sign in page When click sign in then user should switch to home screen', (WidgetTester tester) async {
    
    // ASSEMBLE
    await tester.pumpWidget(
      TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    );
    
    // ACT
    final textfield = find.byType(TextField);
    await tester.pump();
    
    // ASSERT
    final text = find.text('');
    expect(text, findsOneWidget);
  });
}