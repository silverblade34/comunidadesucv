import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerEffect extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;

  const ProfileShimmerEffect({
    super.key,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name shimmer
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 20,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Career title shimmer
                Container(
                  width: 100,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                // Career value shimmer
                Container(
                  width: 200,
                  height: 14,
                  color: Colors.white,
                ),
                SizedBox(height: 15),
                // Campus title shimmer
                Container(
                  width: 100,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                // Campus value shimmer
                Container(
                  width: 200,
                  height: 14,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // Interests shimmer
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // Communities shimmer
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}