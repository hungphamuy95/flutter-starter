import 'package:flutter/material.dart';
import 'package:demo_app/models/cart.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCart extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.display4),
        backgroundColor: Colors.white,
      ),
      body: (Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: new _CartList(),
              ),
            ),
            Container(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      )),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({
    Key key,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    /// In the current implementation, this screen does not allow the user
    /// to modify the contents of the cart, and the cart can not change
    /// from the outside (it is not sychoronized with a database, for example).
    /// Therefore, the model can not change while we are on the screen.
    /// 
    /// But because it's practically guaranteed that we'll want the cart screen
    /// to be dynamic (allow removing items, changing counts, clearing, etc.)
    /// we use ScopedModelDescendant here.
    ///
    /// This makes sure the cart will always list the current contents of
    /// the cart.
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, cart) => ListView(
        children: cart.items.map((item) =>
         Text('${item.name}',
         style: Theme.of(context).textTheme.title,
         )
        ).toList(),
      ),
      );
  }

}

// This is the bottom part of the cart screen, showing the price.
class _CartTotal extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScopedModelDescendant<CartModel>(
              builder: (context, child, cart) => Text('\$${cart.totalPrice}', style: Theme.of(context).textTheme.display4.copyWith(fontSize: 48))),
              FlatButton(
                onPressed: (){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Buying is not supported')));
                },
                color: Colors.white,
                child: Text('BUY'),
              )
          ],
        ),
      ),
    );
  }
  
}