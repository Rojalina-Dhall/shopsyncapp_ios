// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shopsync_app/services/user_service.dart';

// class CategoryChips extends StatelessWidget {
//   final String selectedCategory;
//   final ValueChanged<String> onChanged;

//   const CategoryChips({
//     super.key,
//     required this.selectedCategory,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final userService = UserService();

//     return SizedBox(
//       height: 56,
//       child: StreamBuilder<Map<String, dynamic>>(
//         stream: userService.userStream(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final categoryIds =
//               userService.getSortedCategoryIds(snapshot.data!);

//           return ListView(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             children: categoryIds.map((categoryId) {
//               final isAll = categoryId == 'all';
//               final isSelected = selectedCategory == categoryId;

//               return Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: 
// Chip(
//                   label: Text(isAll ? 'All' : categoryId),
//                   selected: isSelected,
//                   selectedColor: Colors.deepPurple.shade400,
//                   backgroundColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   shape: StadiumBorder(
//                     side: BorderSide(
//                       color: Colors.deepPurple.shade400,
//                       width: 2,
//                     ),
//                   ),
//                   onSelected: (_) {
//                     onChanged(categoryId);
//                     if (!isAll) {
//                       userService.incrementCategoryUsage(
//                         uid: FirebaseAuth.instance.currentUser!.uid,
//                         categoryId: categoryId,
//                       );
//                     }
//                   },
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/services/user_service.dart';

class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return SizedBox(
      height: 36,
      child: StreamBuilder<Map<String, dynamic>>(
        stream: userService.userStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryIds =
              userService.getSortedCategoryIds(snapshot.data!);

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categoryIds.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final categoryId = categoryIds[index];
              final isAll = categoryId == 'all';
              final isSelected = selectedCategory == categoryId;

              return GestureDetector(
                onTap: () {
                  onChanged(categoryId);

                  if (!isAll) {
                    userService.incrementCategoryUsage(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      categoryId: categoryId,
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),


decoration: BoxDecoration(
  color: isSelected
      // ? const Color(0xFF2E2E2E) // selected pill color
      ? const Color(0xFF2F3136)


      : Colors.white,
  borderRadius: BorderRadius.circular(22),
  border: Border.all(
    color: isSelected
        ? Colors.transparent
        : Colors.deepPurple.shade300,
    width: 1.2,
  ),
  boxShadow: isSelected
      ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ]
      : [],
),












                //   decoration: BoxDecoration(
                //     gradient: isSelected
                //         ? const LinearGradient(
                //             colors: [
                //               Color(0xFF6A5AE0),
                //               Color(0xFF8E7BFF),
                //             ],
                //             begin: Alignment.topLeft,
                //             end: Alignment.bottomRight,
                //           )
                //         : null,
                //     color: isSelected 
                //     ? const Color(0xFF2E2E2E) 
                //     : Colors.white,
                //     borderRadius: BorderRadius.circular(56),
                //     border: Border.all(
                //       color: isSelected
                //           ? Colors.transparent
                //           : Colors.deepPurple.shade300,
                        
                //       width: 1.2,
                //     ),
                //     boxShadow: isSelected
                //         ? [
                //             BoxShadow(
                //               color: Colors.deepPurple.withOpacity(0.35),
                //               blurRadius: 8,
                //               offset: const Offset(0, 3),
                //             ),
                //           ]
                //         : [],
                //   ),




















                  child: Text(
                    isAll ? 'All' : categoryId,
                    style: TextStyle(
                      color:
                          isSelected 
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
