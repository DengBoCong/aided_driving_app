import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/grid//flutter_staggered_grid_view.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(4, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

List<Widget> _tiles = const <Widget>[
  const _HouseholdItem(Colors.blue, Icons.radio),
  const _HouseholdItem(Colors.green, Icons.widgets),
  const _HouseholdItem(Colors.lightBlue, Icons.wifi),
  const _HouseholdItem(Colors.amber, Icons.panorama_wide_angle),
  const _HouseholdItem(Colors.brown, Icons.map),
  const _HouseholdItem(Colors.deepOrange, Icons.send),
  const _HouseholdItem(Colors.indigo, Icons.airline_seat_flat),
  const _HouseholdItem(Colors.red, Icons.bluetooth),
  const _HouseholdItem(Colors.pink, Icons.battery_alert),
  const _HouseholdItem(Colors.purple, Icons.desktop_windows),
  const _HouseholdItem(Colors.blue, Icons.radio),
];

class HouseholdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            )));
  }
}

class _HouseholdItem extends StatelessWidget {
  const _HouseholdItem(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
