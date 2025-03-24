import 'package:flutter/material.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';

class AddressSearchPage extends StatelessWidget {
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Address Autocomplete')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddressAutocompleteTextField(
          controller: _addressController,
          mapsApiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
          decoration: InputDecoration(
            labelText: 'Enter Address',
            border: OutlineInputBorder(),
          ),
          onSuggestionClick: (place) {

          },
        ),
      ),
    );
  }
}
