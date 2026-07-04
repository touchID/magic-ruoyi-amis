import 'package:flutter/material.dart';

mixin ChatCommonWidget {
  List<Widget>? buildAppBarCloseButton(BuildContext context, Function(BuildContext? context) tapClose) {
    return [
      GestureDetector(
        onTap: () {
          tapClose(context);
        },
        child: Container(
          transform: Matrix4.translationValues(-3, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 9),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.close, size: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }

  Widget buildSearchBarWidget(TextEditingController searchController, Function(String) onSearch) {
    return Container(
      transform: Matrix4.translationValues(0, 8, 0),
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF9E9E9E),
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: '搜索聊天记录',
          hintStyle: TextStyle(
            color: const Color(0xFF757575),
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            height: 1.50,
          ),
          icon: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Icon(Icons.search, size: 16, color: Colors.black),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: -8, top: 8, bottom: 8, right: 0),
          isDense: true,
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: CircleAvatar(
                    radius: 7,
                    backgroundColor: const Color(0xFFEEEEEE),
                    child: Icon(Icons.close, size: 16),
                  ),
                  onPressed: () {
                    searchController.clear();
                    onSearch('');
                  },
                )
              : null,
        ),
        onChanged: (value) {
          onSearch(value);
        },
      ),
    );
  }

  Widget buildSearchResultHeaderWidget(String searchKeyword, int currentChatIndex, int searchResultsLength,
      Function()? onUpPress, Function()? onDownPress) {
    bool isEnterMessageDetail = currentChatIndex > -1;
    if (searchKeyword.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 0, right: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '搜索关键词',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: isEnterMessageDetail ? '　${currentChatIndex + 1}' : '　$searchResultsLength条',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: isEnterMessageDetail ? '/$searchResultsLength条' : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 76,
            height: 38,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 38,
                    height: 38,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !isEnterMessageDetail
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: onUpPress,
                                child: Icon(
                                  Icons.arrow_upward,
                                  size: 22,
                                  color: currentChatIndex == 0 ? const Color(0xFF616161) : Colors.black,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 38,
                  top: 0,
                  child: Container(
                    width: 38,
                    height: 38,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !isEnterMessageDetail
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: onDownPress,
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 22,
                                  color: (searchResultsLength - currentChatIndex > 1) ? Colors.black : const Color(0xFF616161),
                                ),
                              ),
                      ],
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

  Widget buildChatSupportWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0xFFEEEEEE),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Icon(Icons.message, size: 16),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '开始咨询',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300,
                                    height: 1.75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}