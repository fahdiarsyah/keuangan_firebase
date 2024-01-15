import 'package:flutter/material.dart';

class InputPicker extends StatelessWidget {
  final Widget child;
  final Widget icon;

  InputPicker({required this.child, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [ // Jarak antara ikon dan input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Warna border
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    child,
                    icon,
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
    
//     Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           child,
//           const SizedBox(height: 5),
//           icon,
//         ],
//       ),
//     );
//   }
// }