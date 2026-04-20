// import 'package:flutter/material.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';

// import '../../../../../app/config/theme/colors.dart';
// import '../../../../../domain/models/resultdata_model.dart';

// class Resultitem extends StatelessWidget {
//   const Resultitem({super.key, required this.resultModel, required this.index});
//   final ResultModel resultModel;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         // height: 100,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ]),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 15,
//                   backgroundColor: AppColors.grey,
//                   child: Text('Q${index + 1}'),
//                 ),
//                 const SizedBox(width: 10),
//                 AppTextHelper.subHead(
//                   maxLines: 5,
//                   text: resultModel.qns),
//               ],
//             ),
//             const SizedBox(height: 20,),
//             GridView(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               scrollDirection: Axis.vertical,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4 / 1),
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: AppTextHelper.caption(text:'A.${resultModel.optionA}' )),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: AppTextHelper.caption(text:'B.${resultModel.optionB}' )),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: AppTextHelper.caption(text:'C.${resultModel.optionC}' )),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: AppTextHelper.caption(text:'D.${resultModel.optionD}' )),
//                 // AppTextHelper.caption(text:'E.${resultModel.optionE}' ),
//                 // AppTextHelper.caption(text:'${resultModel.currectAnwser}' ),
//               ],
//             ),
//             Divider()
//           ],

//         ));
//   }
// }
import 'package:flutter/material.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';
import '../../../../../app/config/theme/colors.dart';
import '../../../../../domain/models/resultdata_model.dart';

class Resultitem extends StatelessWidget {
  const Resultitem({super.key, required this.resultModel, required this.index});
  final ResultModel resultModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {}, // Add interaction if needed
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    if (resultModel.yourAns == 'Skip')
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(
                            //   Icons.verified_rounded,
                            //   color: AppColors.success,
                            //   size: 18,
                            // ),
                            const SizedBox(width: 8),
                            Text(
                              resultModel.yourAns,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withOpacity(0.8),
                              AppColors.primary.withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          resultModel.qns,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildOptionTile('A', resultModel.optionA,
                          resultModel.currectAnwser, resultModel.yourAns),
                      _buildOptionTile('B', resultModel.optionB,
                          resultModel.currectAnwser, resultModel.yourAns),
                      _buildOptionTile('C', resultModel.optionC,
                          resultModel.currectAnwser, resultModel.yourAns),
                      _buildOptionTile('D', resultModel.optionD,
                          resultModel.currectAnwser, resultModel.yourAns),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: AppColors.success,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Correct answer: ${resultModel.currectAnwser}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(
      String optionLetter, String optionText, correctans, youans) {
    final isWrong = optionText == youans && optionText != correctans;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isWrong ? AppColors.error.withOpacity(0.1) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isWrong
              ? AppColors.error.withOpacity(0.5)
              : Colors.grey.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isWrong ? AppColors.error : Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: isWrong
                    ? [
                        BoxShadow(
                          color: AppColors.error.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
              ),
              child: Text(
                optionLetter,
                style: TextStyle(
                  color: isWrong ? Colors.white : Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 14,
                  color: isWrong ? AppColors.error : Colors.grey.shade800,
                  fontWeight: isWrong ? FontWeight.w600 : FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isWrong)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.error,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
