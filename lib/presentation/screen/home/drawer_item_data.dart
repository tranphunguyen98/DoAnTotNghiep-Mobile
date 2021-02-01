class DrawerItemData {
  static const int kTypeMain = 0;
  static const int kTypeProject = 1;
  static const int kTypeLabel = 2;
  static const int kTypeFilter = 3;

  final String name;
  final String icon;
  final int type;
  DrawerItemData(this.name, this.icon, [this.type = 0]);
}
