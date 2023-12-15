import 'package:readitique_mobile/screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:readitique_mobile/models/book.dart';

class BookDetail extends StatefulWidget {
  final Fields books;

  BookDetail({required this.books});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> with TickerProviderStateMixin {
  bool showDetails = true;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), 
    );

    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [

          Container(
            child: Hero(
              tag: widget.books.title,
              child: Image.network(
                widget.books.imageLink,
                height: 750,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 48, left: 32,),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.5,
              padding: EdgeInsets.only(top: 64),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 32, left: 32, bottom: 16,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Text(
                                widget.books.title,
                                
                              ),

                              Text(
                                widget.books.author,
                                
                              ),

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    showDetails = !showDetails;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [

                                      Row(
                                        children: <Widget>[

                                          Icon(Icons.star, size: 20, color: kStarsColor,),
                                          Icon(Icons.star, size: 20, color: kStarsColor,),
                                          Icon(Icons.star, size: 20, color: kStarsColor,),
                                          Icon(Icons.star, size: 20, color: kStarsColor,),
                                          Icon(Icons.star_half, size: 20, color: kStarsColor,),

                                        ],
                                      ),

                                      SizedBox(
                                        width: 12,
                                      ),

                                      Text(
                                        widget.books.rating.toString(),
                                        
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              if (showDetails)
                                Expanded(
                                  child: Container(
                                    height: _heightAnimation.value * (size.height * 0.5),
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Text(
                                        widget.books.description,
                                        
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  Container(
                    height: 100,
                    width: size.width,
                    padding: EdgeInsets.only(top: 16, left: 32, right: 32, bottom: 32,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Container(
                          width: size.width / 2 - 44,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Reviews",
                                  
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: size.width / 2 - 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bookmarks",
                                  
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.content_copy,
                                  color: kPrimaryColor,
                                  size: 20,
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
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 32, bottom: (size.height * 0.5) - (75 / 2)),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.books.imageLink), 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}