class MenuItem {
  final String id;
  final String label;
  final List<MenuItem>? children;
  final bool isLink;

  MenuItem({
    required this.id,
    required this.label,
    this.children,
    this.isLink = false,
  });
}