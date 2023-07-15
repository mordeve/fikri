import 'package:animate_do/animate_do.dart';
import 'package:fikri/models/shopping_list_item.dart';
import 'package:fikri/utils/colors.dart';
import 'package:flutter/material.dart';

class ShoppingListTileWidget extends StatefulWidget {
  final ShoppingListItem product;
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onUpdate;
  const ShoppingListTileWidget({
    Key? key,
    required this.product,
    required this.index,
    required this.onRemove,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<ShoppingListTileWidget> createState() => _ShoppingListTileWidgetState();
}

class _ShoppingListTileWidgetState extends State<ShoppingListTileWidget> {
  final double _boxWidth = 450;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 150,
                width: _boxWidth,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    color: kPrimaryAppColor),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.product.product.name,
                            softWrap: true,
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontSize: 23,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const IconWidget(icon: Icons.read_more_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            const IconWidget(icon: Icons.edit),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                widget.onRemove();
                                // setState(
                                //   () {
                                //     if (widget.product.isDone) {
                                //       _boxWidth = 450;
                                //     } else {
                                //       _boxWidth = 400;
                                //     }
                                //   },
                                // );
                              },
                              child: const IconWidget(
                                icon: Icons.delete,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Quantity: ${widget.product.quantity}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.onUpdate();
                          // Future.delayed(const Duration(milliseconds: 100), () {
                          //   setState(() {
                          //     if (widget.product.isDone) {
                          //       _boxWidth = 450;
                          //     } else {
                          //       _boxWidth = 400;
                          //     }
                          //   });
                          // });
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: widget.product.isDone
                              ? const Icon(
                                  Icons.check,
                                  size: 32,
                                )
                              : Container(),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
            Positioned(
              left: 10,
              child: SizedBox(
                height: 150,
                width: 150,
                child: ZoomIn(
                  duration: const Duration(seconds: 2),
                  child: // make a checkbox  to see if the plant is added to the cart
                      Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  final IconData icon;
  const IconWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(.7)),
          borderRadius: BorderRadius.circular(10)),
      child: Icon(
        icon,
        color: Colors.white.withOpacity(.7),
      ),
    );
  }
}
