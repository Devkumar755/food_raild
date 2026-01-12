import 'package:flutter/material.dart';
import 'package:food_rail/shared/widgets/custom_text_field.dart';

class CustomSearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final String Function(T) itemLabel;
  final T? selectedItem;
  final Function(T) onChanged;
  final String hint;

  const CustomSearchableDropdown({
    super.key,
    required this.items,
    required this.title,
    required this.itemLabel,
    required this.onChanged,
    this.selectedItem,
    this.hint = "Select Item",
  });

  @override
  State<CustomSearchableDropdown<T>> createState() =>
      _CustomSearchableDropdownState<T>();
}

class _CustomSearchableDropdownState<T>
    extends State<CustomSearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();

  void _showSelectionDialog(BuildContext context) {
    _searchController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return _SelectionDialog<T>(
          items: widget.items,
          title: widget.title,
          itemLabel: widget.itemLabel,
          onSelected: (item) {
            widget.onChanged(item);
            Navigator.pop(context);
          },
          searchController: _searchController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedItem != null
                  ? widget.itemLabel(widget.selectedItem as T)
                  : widget.hint,
              style: TextStyle(
                color: widget.selectedItem != null ? Colors.black : Colors.grey,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _SelectionDialog<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final String Function(T) itemLabel;
  final Function(T) onSelected;
  final TextEditingController searchController;

  const _SelectionDialog({
    required this.items,
    required this.title,
    required this.itemLabel,
    required this.onSelected,
    required this.searchController,
  });

  @override
  State<_SelectionDialog<T>> createState() => _SelectionDialogState<T>();
}

class _SelectionDialogState<T> extends State<_SelectionDialog<T>> {
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filter(String query) {
    setState(() {
      _filteredItems = widget.items
          .where(
            (item) => widget
                .itemLabel(item)
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: widget.searchController,
              hintText: "Search...",
              labelText: "Search",
              type: TextFieldType.name,
              isLabelRequired: false,
              onChanged: _filter,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _filteredItems.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return ListTile(
                    title: Text(widget.itemLabel(item)),
                    onTap: () => widget.onSelected(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
