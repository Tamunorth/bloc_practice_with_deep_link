import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/constants/enum.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit/counter_cubit.dart';
import 'package:flutter_bloc_concepts/logic/cubit/internet_cubit/internet_cubit.dart';
import 'package:flutter_bloc_concepts/presentation/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // dynamicLinkService.retrieveDynamicLink();

    super.initState();
  }

  @override
  Widget build(BuildContext homeScreenContext) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (internetCubitContext, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Connected to Wifi!!!',
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Careful you are on Mobile Data!!!',
                    );
                  } else {
                    return Text(
                      'Disconnected!, Do something about it quick ',
                    );
                  }
                },
              ),
              BlocConsumer<CounterCubit, CounterState>(
                builder: (counterCubitContext, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, NEGATIVE ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMM, NUMBER 5',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                },
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: Text('${widget.title}'),
                    onPressed: () {
                      // BlocProvider.of<CounterCubit>(context).decrement();
                      context.read<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: Text('${widget.title} 2nd'),
                    onPressed: () {
                      // BlocProvider.of<CounterCubit>(context).increment();
                      context.read<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Builder(builder: (materialButtonContext) {
                return MaterialButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Go to Second Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(materialButtonContext).pushNamed(
                      '/second',
                    );
                  },
                );
              }),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                child: Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(homeScreenContext)
                      .pushNamed(RoutingConstants.thirdScreenRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
