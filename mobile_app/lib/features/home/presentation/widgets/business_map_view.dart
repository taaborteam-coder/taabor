import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/business.dart';

class BusinessMapView extends StatefulWidget {
  final List<Business> businesses;
  final LatLng? userLocation;
  final Function(Business)? onBusinessTap;

  const BusinessMapView({
    super.key,
    required this.businesses,
    this.userLocation,
    this.onBusinessTap,
  });

  @override
  State<BusinessMapView> createState() => _BusinessMapViewState();
}

class _BusinessMapViewState extends State<BusinessMapView> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  @override
  void didUpdateWidget(BusinessMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.businesses != widget.businesses) {
      _createMarkers();
    }
  }

  void _createMarkers() {
    _markers.clear();

    // Add user location marker
    if (widget.userLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: widget.userLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'موقعك'),
        ),
      );
    }

    // Add business markers
    for (final business in widget.businesses) {
      // Latitude and Longitude are required, so they will not be null
      // We can check if they are non-zero if we want to filter invalid locations
      if (business.latitude != 0.0 && business.longitude != 0.0) {
        _markers.add(
          Marker(
            markerId: MarkerId(business.id),
            position: LatLng(business.latitude, business.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            infoWindow: InfoWindow(
              title: business.name,
              snippet: business.category,
              onTap: () {
                if (widget.onBusinessTap != null) {
                  widget.onBusinessTap!(business);
                }
              },
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _fitMapToMarkers();
  }

  void _fitMapToMarkers() {
    if (_markers.isEmpty || _mapController == null) return;

    LatLngBounds bounds;
    if (_markers.length == 1) {
      final marker = _markers.first;
      bounds = LatLngBounds(
        southwest: LatLng(
          marker.position.latitude - 0.01,
          marker.position.longitude - 0.01,
        ),
        northeast: LatLng(
          marker.position.latitude + 0.01,
          marker.position.longitude + 0.01,
        ),
      );
    } else {
      double minLat = _markers.first.position.latitude;
      double maxLat = _markers.first.position.latitude;
      double minLng = _markers.first.position.longitude;
      double maxLng = _markers.first.position.longitude;

      for (final marker in _markers) {
        if (marker.position.latitude < minLat) {
          minLat = marker.position.latitude;
        }
        if (marker.position.latitude > maxLat) {
          maxLat = marker.position.latitude;
        }
        if (marker.position.longitude < minLng) {
          minLng = marker.position.longitude;
        }
        if (marker.position.longitude > maxLng) {
          maxLng = marker.position.longitude;
        }
      }

      bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
    }

    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  @override
  Widget build(BuildContext context) {
    final initialPosition =
        widget.userLocation ??
        (widget.businesses.isNotEmpty
            ? LatLng(
                widget.businesses.first.latitude,
                widget.businesses.first.longitude,
              )
            : const LatLng(36.1925, 44.0092)); // Default: Erbil

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: initialPosition, zoom: 12),
      markers: _markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      mapToolbarEnabled: false,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
